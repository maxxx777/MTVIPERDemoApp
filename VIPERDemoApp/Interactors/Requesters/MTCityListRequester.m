//
//  MTCityListRequester.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCityListRequester.h"
#import "MTMappedCountry.h"
#import "MTFetchedResultsControllerBasedItemListCacheInterface.h"
#import "MTArrayBasedItemListCacheInterface.h"
#import "MTCityDataManagerInterface.h"

@interface MTCityListRequester ()

@property (nonatomic, strong) MTMappedCountry *country;
@property (nonatomic, strong) id<MTFetchedResultsControllerBasedItemListCacheInterface>mainItemListCache;
@property (nonatomic, strong) id<MTArrayBasedItemListCacheInterface>searchResultsCache;
@property (nonatomic, strong) id<MTCityDataManagerInterface>cityDataManager;

@end

@implementation MTCityListRequester

- (instancetype)initWithCountry:(MTMappedCountry *)country
              mainItemListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)mainItemListCache
             searchResultsCache:(id<MTArrayBasedItemListCacheInterface>)searchResultsCache
                cityDataManager:(id<MTCityDataManagerInterface>)cityDataManager
{
    self = [super initWithRootDataManager:cityDataManager
                        mainItemListCache:mainItemListCache
                       searchResultsCache:searchResultsCache];
    if (self) {
        
        _country = country;
        _mainItemListCache = mainItemListCache;
        _searchResultsCache = searchResultsCache;
        _cityDataManager = cityDataManager;
        
    }
    return self;
}

- (instancetype)initWithRootDataManager:(id<MTRootDataManagerInterface>)rootDataManager
                      mainItemListCache:(id<MTItemListCacheInterface>)mainItemListCache
                     searchResultsCache:(id<MTArrayBasedItemListCacheInterface>)searchResultsCache
{
    return [self initWithCountry:nil
               mainItemListCache:nil
              searchResultsCache:nil
                 cityDataManager:nil];
}

#pragma mark - MTItemListRequesterInputInterface

- (void)fetchItems
{
    [self.cityDataManager fetchCityListWithCountry:self.country
                                     itemListCache:self.mainItemListCache
                                       completion:^(NSError *error, id fetchedItem){
                                           _country = fetchedItem;
                                           for (id<MTItemListRequesterOutputInterface> output in self.outputs) {
                                               if ([output respondsToSelector:@selector(onDidFetchItemsWithError:)]) {
                                                   [output onDidFetchItemsWithError:error];
                                               }
                                           }
    }];
}

- (void)refreshItems
{
    [self.cityDataManager refreshCityListWithCountry:self.country
                                       itemListCache:self.mainItemListCache
                                          completion:^(NSError *error, id fetchedItem){
                                              _country = fetchedItem;
                                              for (id<MTItemListRequesterOutputInterface> output in self.outputs) {
                                                  if ([output respondsToSelector:@selector(onDidFetchItemsWithError:)]) {
                                                      [output onDidFetchItemsWithError:error];
                                                  }
                                              }
                                          }];
}

- (void)searchItemsWithSearchString: (NSString *)searchString
{
    [self.cityDataManager searchItemsWithSearchString:searchString
                                        itemListCache:self.mainItemListCache
                                   searchResultsCache:self.searchResultsCache
                                           completion:nil];
}

@end
