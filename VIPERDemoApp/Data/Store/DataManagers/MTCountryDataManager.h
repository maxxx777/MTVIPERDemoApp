//
//  MTCountryDataManager.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootDataManager.h"
#import "MTCountryDataManagerInterface.h"
#import "MTMergeObjectsOperationDelegate.h"

@class MTCountryWebService;

@interface MTCountryDataManager : MTRootDataManager
<
    MTCountryDataManagerInterface,
    MTMergeObjectsOperationDelegate
>

@property (nonatomic, strong) MTCountryWebService *countryWebService;

@end
