//
//  MTRequestBuilder.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRequestBuilder.h"

@implementation MTRequestBuilder

#pragma mark - MTRequestBuilderInterface

- (NSURLRequest *)makeRequestWithScheme:(NSString *)scheme
                                   host:(NSString *)host
                                   path:(NSString *)path
                                 method:(NSString *)method
                                 params:(id)params
{
    NSURL *url = [[NSURL alloc] initWithScheme:scheme host:host path:path];
    
    return [self makeRequestWithURL:url
                             method:method
                             params:params];
}

- (NSURLRequest *)makeRequestWithURLString:(NSString *)urlString
                                    method:(NSString *)method
                                    params:(id)params
{
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    return [self makeRequestWithURL:url
                             method:method
                             params:params];
}

- (NSURLRequest *)makeRequestWithURL:(NSURL *)url
                              method:(NSString *)method
                              params:(id)params
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60.0];
    
    [request setHTTPMethod:method];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    if (params != nil) {
        NSError* error = nil;
        NSData *httpBody;
        if ([params isKindOfClass:[NSDictionary class]]) {
            httpBody = [NSJSONSerialization dataWithJSONObject:params
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
        } else if ([params isKindOfClass:[NSString class]]) {
            NSString *paramsString = (NSString *)params;
            httpBody = [paramsString dataUsingEncoding:NSUTF8StringEncoding];
        }
        [request setHTTPBody:httpBody];
        
        NSString* jsonStr = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        DLog(@"json str: %@", jsonStr);
    }
    
    return request;
}

@end
