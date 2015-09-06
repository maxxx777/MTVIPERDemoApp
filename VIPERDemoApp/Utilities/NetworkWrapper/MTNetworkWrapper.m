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

@property (nonatomic, copy) MTNetworkWrapperRequestCompletionBlock requestCompletionBlock;

@end

@implementation MTNetworkWrapper

enum { kTimeout = 60 };

- (void)sendHttpRequest:(NSURLRequest *)request
             completion:(MTNetworkWrapperRequestCompletionBlock)completion
{
    [self setRequestCompletionBlock:completion];
    __weak MTNetworkWrapperRequestCompletionBlock weakCompletionHandler = self.requestCompletionBlock;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      NSInteger statusCode = [((NSHTTPURLResponse*)response) statusCode];
                                      NSDictionary *result;
                                      
                                      if (statusCode == 200) {
                                          result = [self convertDataToJSON:data
                                                                 withError:&error];
                                      } else {
                                          
                                          NSDictionary *userInfo = @{
                                                                     @"description" : [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]
                                                                     };
                                          
                                          error = [NSError errorWithDomain:MTErrorHandlingErrorDomain
                                                                      code:statusCode
                                                                  userInfo:userInfo];
                                          
                                      }
                                      
                                      weakCompletionHandler(result, error);
                                  }];
    [task resume];
}

-(NSDictionary *)convertDataToJSON:(NSData *)data withError:(NSError **)error {

    NSString *string = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSUTF8StringEncoding];
    //NSString *string = @"{\"status\": \"OK\"}";
    NSData *result = [string dataUsingEncoding:NSUTF8StringEncoding];
//    DLog(@"response: %@", string);
    
    return [result objectFromJSONDataWithParseOptions:JKParseOptionNone error:error];
    
}

@end
