//
//  MTItemListFetcher.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListFetcher.h"
#import "MTItemListCacheInterface.h"
#import "MTRootDataManagerInterface.h"

@interface MTItemListFetcher ()

@property (nonatomic, strong) id<MTItemListCacheInterface>itemListCache;
@property (nonatomic, strong) id<MTRootDataManagerInterface>rootDataManager;

@end

@implementation MTItemListFetcher

- (instancetype)initWithItemListCache:(id<MTItemListCacheInterface>)itemListCache
                      rootDataManager:(id<MTRootDataManagerInterface>)rootDataManager
{
    self = [super init];
    if (self) {
        
        _itemListCache = itemListCache;
        _rootDataManager = rootDataManager;
        
    }
    return self;
}

#pragma mark - MTItemListFetcherInputInterface

- (NSUInteger)countOfItems
{
    return [self.itemListCache numberOfAllCachedItems];
}

- (NSUInteger)numberOfSections
{
    return [self.itemListCache numberOfSections];
}

- (NSUInteger)numberOfRowsInSection:(NSInteger)section
{
    return [self.itemListCache numberOfRowsInSection:section];
}

- (NSArray *)allItems
{
    return [self.itemListCache allCachedItems];
}

- (NSArray *)sectionIndexTitles
{
    return [self.itemListCache sectionIndexTitles];
}

- (NSString *)sectionIndexTitleForSectionName:(NSString *)sectionName
{
    return [self.itemListCache sectionIndexTitleForSectionName:sectionName];
}

- (NSString *)titleForHeaderInSection:(NSInteger)section
{
    return [self.itemListCache titleForHeaderInSection:section];
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.rootDataManager mappedObjectAtIndexPath:indexPath
                                           itemListCache:self.itemListCache];
}

@end
