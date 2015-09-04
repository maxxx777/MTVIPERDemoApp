//
//  MTRootDataManager.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootDataManagerInterface.h"
#import "MTItemListCacheDelegate.h"

@protocol MTRootDataManagerDelegate;

@interface MTRootDataManager : NSObject
<
    MTRootDataManagerInterface,
    MTItemListCacheDelegate
>

- (instancetype)initWithDelegate:(id<MTRootDataManagerDelegate>)delegate NS_DESIGNATED_INITIALIZER;

@end
