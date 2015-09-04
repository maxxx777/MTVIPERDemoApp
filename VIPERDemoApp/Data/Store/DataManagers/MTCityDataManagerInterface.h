//
//  MTCityDataManagerInterface.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootDataManagerInterface.h"

@class MTMappedCountry;

@protocol MTFetchedResultsControllerBasedItemListCacheInterface;

@protocol MTCityDataManagerInterface <NSObject, MTRootDataManagerInterface>

- (void)fetchCityListWithCountry:(MTMappedCountry *)country
                   itemListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)itemListCache
                      completion:(MTRootDataManagerCompletionBlock)completionBlock;
- (void)refreshCityListWithCountry:(MTMappedCountry *)country
                     itemListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)itemListCache
                        completion:(MTRootDataManagerCompletionBlock)completionBlock;

@end
