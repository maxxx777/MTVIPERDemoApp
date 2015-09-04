//
//  MTCountryListRequester.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCountryListRequester.h"
#import "MTFetchedResultsControllerBasedItemListCacheInterface.h"
#import "MTArrayBasedItemListCacheInterface.h"
#import "MTCountryDataManagerInterface.h"

@interface MTCountryListRequester ()

@property (nonatomic, strong) id<MTFetchedResultsControllerBasedItemListCacheInterface>mainItemListCache;
@property (nonatomic, strong) id<MTArrayBasedItemListCacheInterface>searchResultsCache;
@property (nonatomic, strong) id<MTCountryDataManagerInterface>countryDataManager;

@end

@implementation MTCountryListRequester

- (instancetype)initWithMainItemListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)mainItemListCache
                       searchResultsCache:(id<MTArrayBasedItemListCacheInterface>)searchResultsCache
                       countryDataManager:(id<MTCountryDataManagerInterface>)countryDataManager
{
    self = [super initWithRootDataManager:countryDataManager
                        mainItemListCache:mainItemListCache
                       searchResultsCache:searchResultsCache];
    if (self) {
        
        _mainItemListCache = mainItemListCache;
        _searchResultsCache = searchResultsCache;
        _countryDataManager = countryDataManager;
        
    }
    return self;
}

- (instancetype)initWithRootDataManager:(id<MTRootDataManagerInterface>)rootDataManager
                      mainItemListCache:(id<MTItemListCacheInterface>)mainItemListCache
                     searchResultsCache:(id<MTArrayBasedItemListCacheInterface>)searchResultsCache
{
    return [self initWithMainItemListCache:nil
                        searchResultsCache:nil
                        countryDataManager:nil];
}

#pragma mark - MTItemListRequesterInputInterface

- (void)fetchItems
{
    [self.countryDataManager fetchCountryListWithItemListCache:self.mainItemListCache
                                                    completion:^(NSError *error, id fetchedItem){
                                                       for (id<MTItemListRequesterOutputInterface> output in self.outputs) {
                                                           if ([output respondsToSelector:@selector(onDidFetchItemsWithError:)]) {
                                                               [output onDidFetchItemsWithError:error];
                                                           }
                                           }
    }];
}

- (void)refreshItems
{
    [self.countryDataManager refreshCountryListWithItemListCache:self.mainItemListCache
                                                      completion:^(NSError *error, id fetchedItem){
                                              for (id<MTItemListRequesterOutputInterface> output in self.outputs) {
                                                  if ([output respondsToSelector:@selector(onDidFetchItemsWithError:)]) {
                                                      [output onDidFetchItemsWithError:error];
                                                  }
                                              }
                                          }];
}

@end
