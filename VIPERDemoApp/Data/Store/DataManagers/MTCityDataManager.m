//
//  MTCityDataManager.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCityDataManager.h"
#import "MTCityWebService.h"
#import "MTMergeCitiesOperation.h"
#import "MTOperationManager.h"
#import "MTArrayBasedItemListCacheInterface.h"
#import "MTFetchedResultsControllerBasedItemListCacheInterface.h"
#import "NSString+MTSpecificStrings.h"
#import "NSString+MTFormatting.h"
#import "MTDataStore.h"
#import "MTMappedCountry.h"

@interface MTCityDataManager ()

@property (nonatomic, strong) MTMergeCitiesOperation *mergeCitiesOperation;
@property (nonatomic, strong) MTMappedCountry *countryForFetch;
@property (nonatomic, weak) id<MTFetchedResultsControllerBasedItemListCacheInterface> itemListCache;
@property (nonatomic, strong) void(^processCityCompletion)(NSError *, id);

@end

@implementation MTCityDataManager

#pragma mark - MTCityDataManagerInterface

- (void)fetchCityListWithCountry:(MTMappedCountry *)country
                   itemListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)itemListCache
                      completion:(MTRootDataManagerCompletionBlock)completionBlock
{
    [self setCountryForFetch:country];
    [self setProcessCityCompletion:completionBlock];
    [self setItemListCache:itemListCache];
    
    if (![country.isCityListDownloaded boolValue]) {
        [self refreshCityListWithCountry:country
                           itemListCache:self.itemListCache
                              completion:self.processCityCompletion];
    } else {
        [self cacheItemListWithCountry:self.countryForFetch
                            completion:self.processCityCompletion];
    }
}

- (void)refreshCityListWithCountry:(MTMappedCountry *)country
                     itemListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)itemListCache
                        completion:(MTRootDataManagerCompletionBlock)completionBlock
{
    [self setCountryForFetch:country];
    [self setProcessCityCompletion:completionBlock];
    [self setItemListCache:itemListCache];
    
    [self.cityWebService fetchCityListWithCountryCode:country.countryCode
                                           completion:^(id data, NSError *error, NSURLRequest *urlRequest){
        if (data) {
            
            MTMappedCountry *fetchedCountry = [[MTMappedCountry alloc]
                                               initWithItemId:self.countryForFetch.itemId
                                               itemName:self.countryForFetch.itemName
                                               isCityListDownloaded:@(YES)
                                               countryCode:self.countryForFetch.countryCode
                                               continentName:self.countryForFetch.continentName
                                               capitalName:self.countryForFetch.capitalName
                                               population:self.countryForFetch.population
                                               square:self.countryForFetch.square];
            
            _mergeCitiesOperation = [[MTMergeCitiesOperation alloc] initWithCities:(NSArray *)data
                                                                           country:fetchedCountry
                                                                          delegate:self];
            [[MTOperationManager sharedManager] queueOperation:self.mergeCitiesOperation];
            
        } else {
            if (self.processCityCompletion) {
                self.processCityCompletion(error, nil);
                [self setProcessCityCompletion:nil];
            }
        }
    }];
}

- (void)searchItemsWithSearchString:(NSString *)searchString
                      itemListCache:(id<MTItemListCacheInterface>)itemListCache
                 searchResultsCache:(id<MTArrayBasedItemListCacheInterface>)searchResultsCache
                         completion:(MTRootDataManagerCompletionBlock)completionBlock
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemName BEGINSWITH[cd] %@", searchString];
    
    [searchResultsCache cacheItemListWithSourceObjects:[itemListCache allCachedItems]
                                             predicate:predicate
                                            completion:completionBlock];
}

#pragma mark - MTMergeObjectsOperationDelegate

- (void)onDidObjectsMergeWithError:(NSError *)error
              isOperationCancelled:(BOOL)isOperationCancelled
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
    {
        [self cacheItemListWithCountry:self.countryForFetch
                            completion:self.processCityCompletion];
    }];
}

#pragma mark - Helper

- (void)cacheItemListWithCountry:(MTMappedCountry *)country
                      completion:(MTRootDataManagerCompletionBlock)completionBlock
{
    if (self.itemListCache && [self.itemListCache respondsToSelector:@selector(cacheItemListWithEntityName:sortDescriptors:predicate:sectionNameKeyPath:context:completion:)]) {
        NSSortDescriptor *sd1 = [[NSSortDescriptor alloc] initWithKey:@"itemName"
                                                            ascending:YES];
        [self.itemListCache cacheItemListWithEntityName:@"MTManagedCity"
                                        sortDescriptors:@[sd1]
                                              predicate:[NSPredicate predicateWithFormat:@"country.itemId = %@", country.itemId]
                                     sectionNameKeyPath:@"itemName.mt_formatFirstCharacter"
                                                context:[[MTDataStore sharedStore] mainQueueContext]
                                             completion:^(NSError *error, id fetchedItem){
                                                 if (self.processCityCompletion != nil) {
                                                     self.processCityCompletion(error, nil);
                                                     [self setProcessCityCompletion:nil];
                                                 }
                                             }];
    }
}

@end
