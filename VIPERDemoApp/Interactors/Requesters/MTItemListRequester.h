//
//  MTItemListRequester.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootInteractor.h"
#import "MTItemListRequesterIOInterface.h"

@protocol MTRootDataManagerInterface;
@protocol MTItemListCacheInterface;
@protocol MTArrayBasedItemListCacheInterface;

@interface MTItemListRequester : MTRootInteractor
<
    MTItemListRequesterInputInterface
>

- (instancetype)initWithRootDataManager:(id<MTRootDataManagerInterface>)rootDataManager
                      mainItemListCache:(id<MTItemListCacheInterface>)mainItemListCache
                     searchResultsCache:(id<MTArrayBasedItemListCacheInterface>)searchResultsCache NS_DESIGNATED_INITIALIZER;

@end
