//
//  MTItemListViewController.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootViewController.h"
#import "MTItemListViewInterface.h"
#import "MTItemListPresenterInterface.h"

@class MTItemListTableViewController, MTItemListSearchViewController;

@interface MTItemListViewController : MTRootViewController
<
    MTItemListViewInterface
>

@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UIView *containerView;
@property (nonatomic, strong) MTItemListTableViewController *childTableViewController;
@property (nonatomic, strong) MTItemListSearchViewController *searchViewController;
@property (nonatomic, strong) id<MTItemListPresenterInterface> presenter;

@end
