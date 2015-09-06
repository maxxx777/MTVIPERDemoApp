//
//  MTCountryDataManager.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCountryDataManager.h"
#import "MTCountryWebService.h"
#import "MTMergeCountriesOperation.h"
#import "MTOperationManager.h"
#import "MTArrayBasedItemListCacheInterface.h"
#import "MTFetchedResultsControllerBasedItemListCacheInterface.h"
#import "NSString+MTSpecificStrings.h"
#import "NSString+MTFormatting.h"
#import "MTDataStore.h"

@interface MTCountryDataManager ()

@property (nonatomic, strong) MTMergeCountriesOperation *mergeCountriesOperation;
@property (nonatomic, weak) id<MTFetchedResultsControllerBasedItemListCacheInterface> itemListCache;
@property (nonatomic, strong) void(^processCountryCompletion)(NSError *, id);

@end

@implementation MTCountryDataManager

#pragma mark - MTCountryDataManagerInterface

- (void)fetchCountryListWithItemListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)itemListCache
                               completion:(MTRootDataManagerCompletionBlock)completionBlock
{
    [self setProcessCountryCompletion:completionBlock];
    [self setItemListCache:itemListCache];
    
    if ([self countOfCountries] == 0) {
        [self refreshCountryListWithItemListCache:self.itemListCache
                                       completion:self.processCountryCompletion];
    } else {
        [self cacheItemListWithCompletion:self.processCountryCompletion];
    }
}

- (void)refreshCountryListWithItemListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)itemListCache
                                 completion:(MTRootDataManagerCompletionBlock)completionBlock
{
    [self setProcessCountryCompletion:completionBlock];
    [self setItemListCache:itemListCache];
    
    [self.countryWebService fetchCountryListWithCompletion:^(id data, NSError *error, NSURLRequest *urlRequest){
        if (data) {
            
            _mergeCountriesOperation = [[MTMergeCountriesOperation alloc] initWithCountries:(NSArray *)data
                                                                                   delegate:self];
            [[MTOperationManager sharedManager] queueOperation:self.mergeCountriesOperation];
            
        } else {
            if (self.processCountryCompletion) {
                self.processCountryCompletion(error, nil);
                [self setProcessCountryCompletion:nil];
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
        [self cacheItemListWithCompletion:self.processCountryCompletion];
    }];
    
}

#pragma mark - Helper

- (NSUInteger)countOfCountries
{
    return [[MTDataStore sharedStore] countOfObjectsForEntity:@"MTManagedCountry"
                                                    predicate:nil
                                            sortedDescriptors:nil
                                                      context:[[MTDataStore sharedStore] mainQueueContext]];
}

- (void)cacheItemListWithCompletion:(MTRootDataManagerCompletionBlock)completionBlock
{
    if (self.itemListCache && [self.itemListCache respondsToSelector:@selector(cacheItemListWithEntityName:sortDescriptors:predicate:sectionNameKeyPath:context:completion:)]) {
        NSSortDescriptor *sd1 = [[NSSortDescriptor alloc] initWithKey:@"itemName"
                                                            ascending:YES];
        [self.itemListCache cacheItemListWithEntityName:@"MTManagedCountry"
                                        sortDescriptors:@[sd1]
                                              predicate:nil
                                     sectionNameKeyPath:@"itemName.mt_formatFirstCharacter"
                                                context:[[MTDataStore sharedStore] mainQueueContext]
                                             completion:^(NSError *error, id fetchedItem){
                                                 if (self.processCountryCompletion != nil) {
                                                     self.processCountryCompletion(error, nil);
                                                     [self setProcessCountryCompletion:nil];
                                                 }
                                             }];
    }
}

@end
