//
//  MTCountryWebServiceInterface.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTCountryWebServiceInterface <NSObject>

- (void)fetchCountryListWithCompletion: (MTRootServiceRequestCompletionBlock)completion;

@end
