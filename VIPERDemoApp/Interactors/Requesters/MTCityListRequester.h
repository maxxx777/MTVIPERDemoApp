//
//  MTCityListRequester.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListRequester.h"

@class MTMappedCountry;

@protocol MTFetchedResultsControllerBasedItemListCacheInterface;
@protocol MTArrayBasedItemListCacheInterface;
@protocol MTCityDataManagerInterface;

@interface MTCityListRequester : MTItemListRequester

- (instancetype) __unavailable initWithRootDataManager:(id<MTRootDataManagerInterface>)rootDataManager
                                     mainItemListCache:(id<MTItemListCacheInterface>)mainItemListCache
                                    searchResultsCache:(id<MTArrayBasedItemListCacheInterface>)searchResultsCache;
- (instancetype)initWithCountry:(MTMappedCountry *)country
              mainItemListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)mainItemListCache
             searchResultsCache:(id<MTArrayBasedItemListCacheInterface>)searchResultsCache
                cityDataManager:(id<MTCityDataManagerInterface>)cityDataManager NS_DESIGNATED_INITIALIZER;

@end
