//
//  MTCountryDataManagerInterface.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootDataManagerInterface.h"

@protocol MTFetchedResultsControllerBasedItemListCacheInterface;

@protocol MTCountryDataManagerInterface <NSObject, MTRootDataManagerInterface>

- (void)fetchCountryListWithItemListCache: (id<MTFetchedResultsControllerBasedItemListCacheInterface>)itemListCache
                               completion: (MTRootDataManagerCompletionBlock)completionBlock;
- (void)refreshCountryListWithItemListCache: (id<MTFetchedResultsControllerBasedItemListCacheInterface>)itemListCache
                                 completion: (MTRootDataManagerCompletionBlock)completionBlock;

@end
