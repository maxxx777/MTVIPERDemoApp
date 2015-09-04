//
//  MTItemListSearcher.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListSearcher.h"
#import "MTArrayBasedItemListCacheInterface.h"
#import "MTRootDataManagerInterface.h"

@interface MTItemListSearcher ()

@property (nonatomic, strong) id<MTArrayBasedItemListCacheInterface>searchResultsCache;
@property (nonatomic, strong) id<MTRootDataManagerInterface>rootDataManager;

@end

@implementation MTItemListSearcher

- (instancetype)initWithSearchResultsCache:(id<MTArrayBasedItemListCacheInterface>)searchResultsCache
                           rootDataManager:(id<MTRootDataManagerInterface>)rootDataManager
{
    self = [super init];
    if (self) {
        
        _searchResultsCache = searchResultsCache;
        _rootDataManager = rootDataManager;
        
    }
    return self;
}

#pragma mark - MTItemListSearcherInputInterface

- (NSUInteger)numberOfSearchResults
{
    return [self.searchResultsCache numberOfAllCachedItems];
}

- (id)searchResultAtIndex:(NSUInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    return [self.rootDataManager mappedObjectAtIndexPath:indexPath
                                           itemListCache:self.searchResultsCache];
}

@end
