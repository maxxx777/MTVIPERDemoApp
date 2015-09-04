//
//  MTNetworkWrapper.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTNetworkWrapper.h"
#import "MTErrorHandlingConstants.h"
#import "JSONKit.h"

@interface MTNetworkWrapper ()
{
    NSMutableData *response_;
    NSInteger statusCode_;
    NSURLRequest *request_;
    NSURLConnection *connection_;
    NSTimer *timer_;
    BOOL error_;
}

@property (nonatomic, copy) MTNetworkWrapperRequestCompletionBlock requestCompletionBlock;

@end

@implementation MTNetworkWrapper

enum { kTimeout = 60 };

- (void)sendHttpRequest:(NSURLRequest *)request
             completion:(MTNetworkWrapperRequestCompletionBlock)completion
{
    request_ = request;
    [self setRequestCompletionBlock:completion];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    connection_ = [[NSURLConnection alloc] initWithRequest:request_ delegate:self];
    response_   = [[NSMutableData alloc] init];
    error_      = NO;
}


-(NSDictionary *)convertDataToJSON:(NSData *)data withError:(NSError **)error {

    NSString *string = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSUTF8StringEncoding];
    //NSString *string = @"{\"status\": \"OK\"}";
    NSData *result = [string dataUsingEncoding:NSUTF8StringEncoding];
//    DLog(@"response: %@", string);
    
    return [result objectFromJSONDataWithParseOptions:JKParseOptionNone error:error];
    
}

#pragma mark - Connection

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    error_ = NO;
    [self stopTimer];
    
//    DLog(@"ETHttpRequest result: %@", result);
//    DLog(@"ETHttpRequest status code: %ld", (long)statusCode_);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.requestCompletionBlock != nil) {
            self.requestCompletionBlock(nil , error);
            _requestCompletionBlock = nil;
        }
    });
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

    // reset data
    [response_ setLength:0];
    
    // check status code and if 200, set data, else set error
    statusCode_ = [((NSHTTPURLResponse*)response) statusCode];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    // add new data
    [response_ appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    error_ = NO;
    [self stopTimer];

    if (self.requestCompletionBlock != nil) {
        
        NSError *error = nil;
        NSDictionary *result;
        
        if (statusCode_ == 200) {
            result = [self convertDataToJSON:response_ withError:&error];
        } else {
            
            NSDictionary *userInfo = @{
                                       @"description" : [[NSString alloc] initWithData:response_ encoding:NSUTF8StringEncoding]
                                       };
            
            error = [NSError errorWithDomain:MTErrorHandlingErrorDomain
                                        code:statusCode_
                                    userInfo:userInfo];
            
        }
        
//        DLog(@"ETHttpRequest result: %@", result);
//        DLog(@"ETHttpRequest status code: %ld", (long)statusCode_);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.requestCompletionBlock) {
                self.requestCompletionBlock(result, error);
                _requestCompletionBlock = nil;
            }
        });
        
    }
}

#pragma mark - Timer

//
// Start timer for catch timeout error
//
-(void) startTimer {
    
//    DLog(@"startTimer");
    
    timer_ = [NSTimer 
               scheduledTimerWithTimeInterval:kTimeout target:self 
               selector:@selector(forceTimeout) userInfo:nil repeats:NO];
    
}

//
// Stop timer
//
-(void) stopTimer {
    
//    DLog(@"stopTimer");
    
    if (timer_) {
        [timer_ invalidate];
        timer_ = nil;
    }
    
}

//
//
//
-(void) forceTimeout {
    
//    DLog(@"forceTimeout");
    
    if (connection_) {
        
        [connection_ cancel];
        connection_ = nil;
        
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:@"Failed to load data (timeout)" forKey:NSLocalizedDescriptionKey];
        
        // TODO: check domain
        NSError *error = [NSError errorWithDomain:request_.URL.host code:1032 userInfo:errorDetail];
        [self connection:connection_ didFailWithError:error];
        
    }
    
}

@end
