//
//  MTCityDataManager.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootDataManager.h"
#import "MTCityDataManagerInterface.h"
#import "MTMergeObjectsOperationDelegate.h"

@class MTCityWebService;

@interface MTCityDataManager : MTRootDataManager
<
    MTCityDataManagerInterface,
    MTMergeObjectsOperationDelegate
>

@property (nonatomic, strong) MTCityWebService *cityWebService;

@end
