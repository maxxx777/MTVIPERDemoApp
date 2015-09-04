//
//  MTCityWebServiceInterface.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTCityWebServiceInterface <NSObject>

- (void)fetchCityListWithCountryCode:(NSString *)countryCode
                          completion:(MTRootServiceRequestCompletionBlock)completion;

@end
