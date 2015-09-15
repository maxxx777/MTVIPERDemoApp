//
//  MTCountryListTablePresenter.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCityListTablePresenter.h"
#import "MTItemListTableViewInterface.h"
#import "MTCityListWireframe.h"
#import "MTCityListCell.h"
#import "MTAlertViewWrapper.h"

static NSString *MTOffScreenCellIdentifier = @"OffScreenTableViewCell";
static NSString *MTTableViewCellIdentifier = @"TableViewCellIdentifier";

@interface MTCityListTablePresenter ()
{
    MTAlertViewWrapper *alertViewWrapper;
}

@property (nonatomic, strong) id<MTItemListRequesterInputInterface>itemListRequester;
@property (nonatomic, strong) id<MTItemListFetcherInputInterface>itemListFetcher;
@property (nonatomic, weak) MTCityListWireframe *wireframe;
@property (nonatomic) BOOL isFirstAppearance;
@property (nonatomic, strong) MTCityListCell *prototypeCell;

@end

@implementation MTCityListTablePresenter

- (instancetype)initWithItemListRequester:(id<MTItemListRequesterInputInterface>)itemListRequester
                          itemListFetcher:(id<MTItemListFetcherInputInterface>)itemListFetcher
                                wireframe:(MTCityListWireframe *)wireframe
{
    self = [super init];
    if (self) {
        
        _itemListRequester = itemListRequester;
        _itemListFetcher = itemListFetcher;
        _wireframe = wireframe;
        
        alertViewWrapper = [[MTAlertViewWrapper alloc] init];
        
        _isFirstAppearance = YES;
        
    }
    return self;
}

#pragma mark - MTItemListTablePresenterInterface

- (void)updateViewBeforeAppearing
{
    if (self.isFirstAppearance) {
        [self.userInterface updateFooterLabelWithText:@"Идет построение списка..."];
        [self.itemListRequester fetchItems];
    }
}

- (void)updateViewAfterAppearing
{
    
}

- (void)refreshContent
{
    [self.itemListRequester refreshItems];
}

- (void)willCloseView
{
    [self.itemListRequester cancelActions];
}

- (void)scrollViewWithOffset:(CGPoint)offset
{
    
}

- (NSUInteger)numberOfSections
{
    return [self.itemListFetcher numberOfSections];
}

- (NSUInteger)numberOfRowsInSection:(NSInteger)section
{
    return [self.itemListFetcher numberOfRowsInSection:section];
}

- (NSArray *)sectionIndexTitles
{
    return [self.itemListFetcher sectionIndexTitles];
}

- (NSString *)sectionIndexTitleForSectionName:(NSString *)sectionName
{
    return [self.itemListFetcher sectionIndexTitleForSectionName:sectionName];
}

- (NSString *)titleForHeaderInSection:(NSInteger)section
{
    return [self.itemListFetcher titleForHeaderInSection:section];
}

- (void)configureCell:(UITableViewCell *)cell
          atIndexPath:(NSIndexPath *)indexPath
          inTableView:(UITableView *)tableView
{
    id item = [self.itemListFetcher objectAtIndexPath:indexPath];
    MTCityListCell *cellToConfigure = (MTCityListCell *)cell;
    [cellToConfigure configureCellWithItem:item];
}

- (CGFloat)heightForCell:(UITableViewCell *)cell
             atIndexPath:(NSIndexPath *)indexPath
             inTableView:(UITableView *)tableView
{
    if (!self.prototypeCell) {
        self.prototypeCell = [tableView dequeueReusableCellWithIdentifier:MTOffScreenCellIdentifier];
    }
    
    id item = [self.itemListFetcher objectAtIndexPath:indexPath];
    
    return [self.prototypeCell heightForCellWithItem:item];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    id country = [self.itemListFetcher objectAtIndexPath:indexPath];
//    
//    [self.wireframe onDidSelectCountry:country];
}

- (void)registerCellForTableView:(UITableView *)tableView
{
    [tableView registerClass:[MTCityListCell class]
      forCellReuseIdentifier:MTTableViewCellIdentifier];
    [tableView registerClass:[MTCityListCell class]
      forCellReuseIdentifier:MTOffScreenCellIdentifier];
}

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    return MTTableViewCellIdentifier;
}

#pragma mark - MTItemListFetcherOutputInterface

- (void)onDidFetchItemsWithError:(NSError *)error
{
    self.isFirstAppearance = NO;
    if (!error) {
        
        [self updateFooterLabel];
        
    } else {
        [alertViewWrapper showRepeatRequestAlertWithText:NSLocalizedString(@"Sorry, can't receive cities from server", nil)
                                       clickedCompletion:^(NSInteger buttonIndex, NSString *text){
                                           if (buttonIndex == 1) {
                                               [self.itemListRequester refreshItems];
                                           } else {
                                               [self.userInterface stopPullToRefreshAnimating];
                                               [self updateFooterLabel];
                                           }
                                       } didDismissCompletion:nil];
    }
    [self.userInterface stopPullToRefreshAnimating];
}

#pragma mark - Helper

- (void)updateFooterLabel
{
    NSString *text = [NSString stringWithFormat:NSLocalizedString(@"Total cities: %d", nil), [self.itemListFetcher countOfItems]];
    [self.userInterface updateFooterLabelWithText:text];
    [self.userInterface reloadData];
}

@end
