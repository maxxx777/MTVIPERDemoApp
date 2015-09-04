//
//  MTCountryListSearchPresenter.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCountryListSearchPresenter.h"
#import "MTItemListSearchViewInterface.h"
#import "MTCountryListWireframe.h"
#import "MTCountryListCell.h"

static NSString *MTOffScreenCellIdentifier = @"OffScreenTableViewCell";
static NSString *MTSearchTableViewCellIdentifier = @"SearchTableViewCellIdentifier";

@interface MTCountryListSearchPresenter ()

@property (nonatomic, strong) id<MTItemListRequesterInputInterface>itemListRequester;
@property (nonatomic, strong) id<MTItemListSearcherInputInterface>itemListSearcher;
@property (nonatomic, strong) MTCountryListCell *prototypeCell;
@property (nonatomic, weak) MTCountryListWireframe *wireframe;

@end

@implementation MTCountryListSearchPresenter

- (instancetype)initWithItemListRequester:(id<MTItemListRequesterInputInterface>)itemListRequester
                         itemListSearcher:(id<MTItemListSearcherInputInterface>)itemListSearcher
                                wireframe:(MTCountryListWireframe *)wireframe
{
    self = [super init];
    if (self) {
        
        _itemListRequester = itemListRequester;
        _itemListSearcher = itemListSearcher;
        _wireframe = wireframe;
        
    }
    return self;
}

#pragma mark - MTItemListSearchPresenterInterface

- (void)searchItemsWithSearchString: (NSString *)searchString
{
    [self.itemListRequester searchItemsWithSearchString:searchString];
}

- (NSUInteger)numberOfSearchResults
{
    return [self.itemListSearcher numberOfSearchResults];
}

- (CGFloat)heightForCell:(UITableViewCell *)cell
                 atIndex:(NSUInteger)index
             inTableView:(UITableView *)tableView
{
    if (!self.prototypeCell) {
        self.prototypeCell = [tableView dequeueReusableCellWithIdentifier:MTOffScreenCellIdentifier];
    }
    
    id item = [self.itemListSearcher searchResultAtIndex:index];
    
    return [self.prototypeCell heightForCellWithItem:item
                                      hasIndexedList:NO];
}

- (void)configureCell:(UITableViewCell *)cell
              atIndex:(NSUInteger)index
          inTableView:(UITableView *)tableView
{
    MTCountryListCell *cellToConfigure = (MTCountryListCell *)cell;
    id item = [self.itemListSearcher searchResultAtIndex:index];
    [cellToConfigure configureCellWithItem:item];
}

- (void)didSelectRowAtIndex:(NSUInteger)index
{
    id country = [self.itemListSearcher searchResultAtIndex:index];
    
    [self.wireframe onDidSelectCountry:country];
}

- (void)registerCellForTableView:(UITableView *)tableView
{
    [tableView registerClass:[MTCountryListCell class]
      forCellReuseIdentifier:MTSearchTableViewCellIdentifier];
    [tableView registerClass:[MTCountryListCell class]
      forCellReuseIdentifier:MTOffScreenCellIdentifier];
}

- (NSString *)cellIdentifierForIndex:(NSUInteger)index
{
    return MTSearchTableViewCellIdentifier;
}

#pragma mark - MTItemListSearcherOutputInterface

- (void)onDidFetchItemsWithError:(NSError *)error
{
    //
}

@end
