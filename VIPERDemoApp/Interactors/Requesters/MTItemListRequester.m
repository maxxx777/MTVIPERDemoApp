//
//  MTItemListRequester.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListRequester.h"
#import "MTRootDataManagerInterface.h"

@interface MTItemListRequester ()

@property (nonatomic, strong) id<MTRootDataManagerInterface>rootDataManager;
@property (nonatomic, strong) id<MTItemListCacheInterface>mainItemListCache;
@property (nonatomic, strong) id<MTArrayBasedItemListCacheInterface>searchResultsCache;

@end

@implementation MTItemListRequester

- (instancetype)initWithRootDataManager:(id<MTRootDataManagerInterface>)rootDataManager
                      mainItemListCache:(id<MTItemListCacheInterface>)mainItemListCache
                     searchResultsCache:(id<MTArrayBasedItemListCacheInterface>)searchResultsCache
{
    self = [super init];
    if (self) {
        
        _rootDataManager = rootDataManager;
        _mainItemListCache = mainItemListCache;
        _searchResultsCache = searchResultsCache;
        
    }
    return self;
}

- (void)searchItemsWithSearchString: (NSString *)searchString
{
    [self.rootDataManager searchItemsWithSearchString:searchString
                                        itemListCache:self.mainItemListCache
                                   searchResultsCache:self.searchResultsCache
                                           completion:nil];
}

- (void)cancelActions
{
//    [self.rootDataManager cancelActions];
}

@end
