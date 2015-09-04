//
//  MTRequestBuilderInterface.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTRequestBuilderInterface <NSObject>

- (NSURLRequest *)makeRequestWithScheme:(NSString *)scheme
                                   host:(NSString *)host
                                   path:(NSString *)path
                                 method:(NSString *)method
                                 params:(id)params;
- (NSURLRequest *)makeRequestWithURLString:(NSString *)urlString
                                    method:(NSString *)method
                                    params:(id)params;
- (NSURLRequest *)makeRequestWithURL:(NSURL *)url
                              method:(NSString *)method
                              params:(id)params;

@end
