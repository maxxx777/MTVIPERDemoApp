//
//  MTCountryWebService.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCountryWebService.h"
#import "NSString+MTSpecificStrings.h"

@implementation MTCountryWebService

#pragma mark - MTCountryWebServiceInterface

- (void)fetchCountryListWithCompletion:(MTRootServiceRequestCompletionBlock)completion
{
    NSString *scheme = MTRequestBuilderURLSchemeHTTP;
    NSString *path = [NSString stringWithFormat:@"/countryInfoJSON?username=%@", [NSString mt_apiUserName]];
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
                                     
                                     id result = [self.parser parseCountryListFromRawData:rawData];
                                     
                                     completion(result, error, urlRequest);
                                     
                                 } else {
                                     
                                     completion(nil, error, urlRequest);
                                     
                                 }
                                 
                             }
    }];
}


@end
