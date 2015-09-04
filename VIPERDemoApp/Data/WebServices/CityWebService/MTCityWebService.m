//
//  MTCityWebService.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCityWebService.h"
#import "NSString+MTSpecificStrings.h"

@implementation MTCityWebService

#pragma mark - MTCityWebServiceInterface

- (void)fetchCityListWithCountryCode:(NSString *)countryCode
                          completion:(MTRootServiceRequestCompletionBlock)completion
{
    NSString *scheme = MTRequestBuilderURLSchemeHTTP;
    NSString *path =  [NSString stringWithFormat:@"/searchJSON?username=%@&featureClass=P&country=%@", [NSString mt_apiUserName], countryCode];
    NSString *method = MTRequestBuilderHTTPMethodGet;
    
    NSURLRequest *urlRequest = [self.requestBuilder makeRequestWithScheme:scheme
                                                                     host:[NSString mt_appHostName]
                                                                     path:path
                                                                   method:method
                                                                   params:nil];
    [self.networkWrapper sendHttpRequest:urlRequest
                              completion:^(id rawData, NSError *error){
        
                             if (completion) {
                                 
                                 if (rawData) {
                                     
                                     id result = [self.parser parseCityListFromRawData:rawData];

                                     completion(result, error, urlRequest);
                                     
                                 } else {
                                     
                                     completion(nil, error, urlRequest);
                                     
                                 }
                                 
                             }
    }];
}

@end
