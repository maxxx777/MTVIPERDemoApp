//
//  MTItemListSearchPresenterInterface.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTItemListSearchPresenterInterface <NSObject>

@optional

- (void)searchItemsWithSearchString: (NSString *)searchString;

- (NSUInteger)numberOfSearchResults;
- (id)searchResultAtIndex:(NSUInteger)index;
- (BOOL)isCheckedSearchResultAtIndex:(NSUInteger)index;
- (void)configureCell:(UITableViewCell *)cell
              atIndex:(NSUInteger)index
          inTableView:(UITableView *)tableView;
- (CGFloat)heightForCell:(UITableViewCell *)cell
                 atIndex:(NSUInteger)index
             inTableView:(UITableView *)tableView;
- (void)didSelectRowAtIndex:(NSUInteger)index;
- (void)registerCellForTableView:(UITableView *)tableView;
- (NSString *)cellIdentifierForIndex:(NSUInteger)index;

@end
