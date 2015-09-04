//
//  MTItemListSearchViewController.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListSearchViewController.h"
#import "MTItemListSearchPresenterInterface.h"

@implementation MTItemListSearchViewController

- (void)dealloc
{
    DLog(@"%@ deallocated: %p", NSStringFromClass([self class]), self);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.presenter numberOfSearchResults];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self.presenter cellIdentifierForIndex:indexPath.row]];
    [self.presenter configureCell:cell
                      atIndex:indexPath.row
                      inTableView:tableView];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self.presenter cellIdentifierForIndex:indexPath.row]];
    
    CGFloat height = [self.presenter heightForCell:cell
                                           atIndex:indexPath.row
                                       inTableView:tableView];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!tableView.isEditing) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [self.presenter didSelectRowAtIndex:indexPath.row];
        
    }
}

#pragma mark - MTItemListSearchViewInterface

- (void)reloadData
{
    [self.tableView reloadData];
}

#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self.presenter searchItemsWithSearchString:searchString];

    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    [self.presenter registerCellForTableView:tableView];
}

@end
