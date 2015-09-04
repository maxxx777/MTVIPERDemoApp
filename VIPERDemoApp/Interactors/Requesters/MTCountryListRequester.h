//
//  MTCountryListRequester.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListRequester.h"

@protocol MTFetchedResultsControllerBasedItemListCacheInterface;
@protocol MTArrayBasedItemListCacheInterface;
@protocol MTCountryDataManagerInterface;

@interface MTCountryListRequester : MTItemListRequester

- (instancetype) __unavailable initWithRootDataManager:(id<MTRootDataManagerInterface>)rootDataManager
                       mainItemListCache:(id<MTItemListCacheInterface>)mainItemListCache
                      searchResultsCache:(id<MTArrayBasedItemListCacheInterface>)searchResultsCache;
- (instancetype)initWithMainItemListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)mainItemListCache
                       searchResultsCache:(id<MTArrayBasedItemListCacheInterface>)searchResultsCache
                       countryDataManager:(id<MTCountryDataManagerInterface>)countryDataManager NS_DESIGNATED_INITIALIZER;

@end
