//
//  MTItemListFetcher.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootInteractor.h"
#import "MTItemListFetcherIOInterface.h"

@protocol MTItemListCacheInterface;
@protocol MTRootDataManagerInterface;

@interface MTItemListFetcher : MTRootInteractor
<
    MTItemListFetcherInputInterface
>

- (instancetype)initWithItemListCache:(id<MTItemListCacheInterface>)itemListCache
                      rootDataManager:(id<MTRootDataManagerInterface>)rootDataManager NS_DESIGNATED_INITIALIZER;

@end
