//
//  MTItemListTableViewController.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListTableViewController.h"
//#import "SVPullToRefresh.h"
#import "UIColor+MTSpecificColors.h"
#import "MTTableViewSectionHeader.h"
#import "MTTableFooterView.h"

static NSString *HeaderIdentifier = @"ItemListTableViewSectionHeader";

static NSInteger loadMoreCount = 10;

@interface MTItemListTableViewController ()
{
    NSInteger loadedObjectsCount;
    NSInteger loadedSectionsCount;
    NSInteger loadedRowsCountInLastSection;
    BOOL loadMoreInAction;
    BOOL loadMoreFinished;
}

@end

@implementation MTItemListTableViewController
@synthesize presenter = _presenter;

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        _enablePullToRefresh = NO;
        _enableIndexedList = NO;
        _enableLoadMore = NO;
        
        loadedObjectsCount = 0;
        loadedSectionsCount = 0;
        loadedRowsCountInLastSection = 0;
        loadMoreInAction = NO;
        loadMoreFinished = NO;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.presenter registerCellForTableView:self.tableView];
    
    if (self.enablePullToRefresh) {
        [self configurePullToRefresh];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIView transitionWithView: self.tableView
                      duration: 0.0f
                       options: UIViewAnimationOptionTransitionNone
                    animations: ^(void)
     {
         [self.presenter updateViewBeforeAppearing];
     }
                    completion: ^(BOOL isFinished)
     {
         [self reloadData];
     }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.presenter updateViewAfterAppearing];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        [self.presenter willCloseView];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.enableLoadMore) {
        return [self numberOfLoadedSections];
    } else {
        return [self.presenter numberOfSections];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.enableLoadMore) {
        return [self numberOfLoadedRowsInSection:section];
    } else {
        return [self.presenter numberOfRowsInSection:section];
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.enableIndexedList ? [self.presenter sectionIndexTitles] : nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.presenter titleForHeaderInSection:section];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MTTableViewSectionHeader *header = [[MTTableViewSectionHeader alloc] initWithReuseIdentifier:HeaderIdentifier];
    
    [header setTitle:[self tableView:tableView titleForHeaderInSection:section]];

    return header.contentView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self.presenter cellIdentifierForIndexPath:indexPath]];
    [self.presenter configureCell:cell
                      atIndexPath:indexPath
                      inTableView:tableView];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self.presenter cellIdentifierForIndexPath:indexPath]];
    
    CGFloat height = [self.presenter heightForCell:cell
                                       atIndexPath:indexPath
                                       inTableView:tableView];
    return height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.presenter respondsToSelector:@selector(willDisplayCell:atIndexPath:inTableView:)]) {
        [self.presenter willDisplayCell:cell atIndexPath:indexPath inTableView:self.tableView];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!tableView.isEditing) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [self.presenter didSelectRowAtIndexPath:indexPath];
        
    }
}

#pragma mark - Helper

- (void)configurePullToRefresh
{
    __weak MTItemListTableViewController *weakSelf = self;
    
    // Setup Pull to refresh
//    [self.tableView addPullToRefreshWithActionHandler:^{
//        [weakSelf.presenter refreshContent];
//    }];
    
//    self.tableView.pullToRefreshView.arrowColor = [UIColor mt_tableViewTextColor];
//    self.tableView.pullToRefreshView.textColor = [UIColor mt_tableViewTextColor];
//    self.tableView.pullToRefreshView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
//    
//    [self.tableView.pullToRefreshView setSubtitle:@"" forState:SVPullToRefreshStateLoading];
}

- (void)configurePullToRefreshSubtitleWithText:(NSString *)text
{
//    [self.tableView.pullToRefreshView setSubtitle:text
//                                         forState:SVPullToRefreshStateStopped];
}

- (void)stopPullToRefreshAnimating
{
//    [self.tableView.pullToRefreshView stopAnimating];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
 
    [self.presenter scrollViewWithOffset:offset];

    if (self.enableLoadMore) {
        if (([scrollView contentOffset].y + self.tableView.frame.size.height) >= [scrollView contentSize].height && [scrollView contentOffset].y != 0 && loadedObjectsCount > 0) {
//            DLog(@"load more");
            if (!loadMoreInAction && !loadMoreFinished) {
                [self loadMore];
                
                return;
            }
            
        }
    }
}

#pragma mark - MTItemListTableViewInterface

- (void)updateFooterLabelWithText:(NSString *)text
{
    [self.tableFooterView setTitle:text];
}

- (void)reloadData
{
    [self.tableView reloadData];
}

- (void)reloadDataAndScrollToRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UIView transitionWithView: self.tableView
                      duration: 0.0f
                       options: UIViewAnimationOptionTransitionNone
                    animations: ^(void)
     {
         [self reloadData];
     }
                    completion: ^(BOOL isFinished)
     {
         if (indexPath != nil) {
             [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
         }
     }];
}

- (void)selectAndScrollToRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView beginUpdates];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    [self.tableView endUpdates];
    
    CGRect rect = [self.tableView rectForRowAtIndexPath:indexPath];
    [self.tableView scrollRectToVisible:rect animated:YES];
}

- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView beginUpdates];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

- (void)clearLoadMoreValues
{
    loadedObjectsCount = 0;
    loadedSectionsCount = 0;
    loadedRowsCountInLastSection = 0;
}

#pragma mark - Load More

- (void)startLoadCells
{
    if (self.enableLoadMore) {
        
        loadMoreFinished = NO;
        
        [self showLoadMoreCell];
        [self loadMore];
    }
}

- (void)loadMore
{
//    DLog(@"start show cells: %lu", (unsigned long)loadedObjectsCount);
    loadMoreInAction = YES;
    NSInteger localObjectsCount = loadedObjectsCount;
    NSInteger totalObjectsCount = [self.presenter numberOfAllItemsOfSelectedType];
    
    NSMutableIndexSet* insertIndexSet = [[NSMutableIndexSet alloc] init];;
    NSMutableArray *insertIndexPaths = [NSMutableArray array];
    while ((localObjectsCount < loadedObjectsCount + loadMoreCount) && (localObjectsCount < totalObjectsCount)) {
        NSInteger notLoadedRowsCountInLastSection = [self.presenter numberOfRowsInSection:loadedSectionsCount] - loadedRowsCountInLastSection;
        if ([insertIndexPaths count] + notLoadedRowsCountInLastSection > loadMoreCount) {
            NSInteger rowsToLoadNow = loadMoreCount - [insertIndexPaths count];
            [insertIndexSet addIndex:loadedSectionsCount];
            [insertIndexPaths addObjectsFromArray:[self insertedIndexPathsWithSection:loadedSectionsCount
                                                                             startRow:loadedRowsCountInLastSection
                                                                            finishRow:loadedRowsCountInLastSection+rowsToLoadNow]];
            
            localObjectsCount += rowsToLoadNow;
            loadedRowsCountInLastSection += rowsToLoadNow;
        } else {
            [insertIndexSet addIndex:loadedSectionsCount];
            [insertIndexPaths addObjectsFromArray:[self insertedIndexPathsWithSection:loadedSectionsCount
                                                                             startRow:loadedRowsCountInLastSection
                                                                            finishRow:[self.presenter numberOfRowsInSection:loadedSectionsCount]]];
            
            localObjectsCount += [self.presenter numberOfRowsInSection:loadedSectionsCount] - loadedRowsCountInLastSection;
            loadedSectionsCount +=1;
            loadedRowsCountInLastSection = 0;
        }
    }
    
    loadedObjectsCount = localObjectsCount;
    
    if ((totalObjectsCount == 0) || (totalObjectsCount == loadedObjectsCount && [insertIndexPaths count] > 0)) {
        loadMoreFinished = YES;
        [self hideLoadMoreCell];
    }
    
    [self insertSectionsAtIndexSet:insertIndexSet
               andRowsAtIndexPaths:insertIndexPaths];
}

- (void)tableViewReloaded
{
    loadedObjectsCount = 0;
    loadedSectionsCount = 0;
    loadedRowsCountInLastSection = 0;
}

- (void)showLoadMoreCell
{
    [self.tableFooterView setTitle:@"Загрузить еще..." animated:YES];
}

- (void)hideLoadMoreCell
{
    [self updateFooterLabelWithText:@""];
}

- (void)insertSectionsAtIndexSet:(NSIndexSet*)indexSet
             andRowsAtIndexPaths:(NSArray*)indexPaths
{
    [UIView setAnimationsEnabled:NO];
    [self.tableView beginUpdates];
    
    if ([self.tableView numberOfSections] > 0) {
        NSInteger index = [indexSet indexGreaterThanIndex:[self.tableView numberOfSections] - 1];
        while(index != NSNotFound)
        {
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:index]
                          withRowAnimation:UITableViewRowAnimationNone];
            index = [indexSet indexGreaterThanIndex: index];
        }
    } else {
        [self.tableView insertSections:indexSet
                      withRowAnimation:UITableViewRowAnimationNone];
    }
    
    [self.tableView insertRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    [UIView setAnimationsEnabled:YES];
    
    loadMoreInAction = NO;
}

- (NSArray*)insertedIndexPathsWithSection: (NSInteger)section
                                 startRow: (NSInteger)startRow
                                finishRow: (NSInteger)finishRow
{
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSInteger i = startRow; i < finishRow; i++) {
        
        [result addObject:[NSIndexPath indexPathForRow:i
                                             inSection:section]];
    }
    
    return result;
}

- (NSInteger)numberOfLoadedSections
{
    NSInteger count;
    if (loadedObjectsCount > 0) {
        if (loadedRowsCountInLastSection > 0) {
            count = loadedSectionsCount + 1;
        } else {
            count = loadedSectionsCount;
        }
    } else {
        count = 0;
    }
    return count;
}

- (NSInteger)numberOfLoadedRowsInSection:(NSInteger)section
{
    if (section == loadedSectionsCount && loadedRowsCountInLastSection > 0) {
        return loadedRowsCountInLastSection;
    } else {
        return [self.presenter numberOfRowsInSection:section];
    }
}

@end
