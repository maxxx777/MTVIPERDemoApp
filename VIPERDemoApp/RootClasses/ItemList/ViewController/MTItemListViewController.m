//
//  MTItemListViewController.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListViewController.h"
#import "MTItemListTableViewController.h"
#import "MTItemListSearchViewController.h"

@interface MTItemListViewController ()

@end

@implementation MTItemListViewController
@synthesize presenter = _presenter;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.presenter configureView];
    [self configureChildTableViewController];
    [self configureSearchDisplayController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

#pragma mark - Helper 

- (void)configureChildTableViewController
{
    UIView *tableView = self.childTableViewController.tableView;
    
    [self addChildViewController:self.childTableViewController];
    [self.containerView addSubview:tableView];
    
    [tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.containerView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|"
                                        options:NSLayoutFormatDirectionLeadingToTrailing
                                        metrics:nil
                                        views:NSDictionaryOfVariableBindings(tableView)]];
    [self.containerView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|"
                                        options:NSLayoutFormatDirectionLeadingToTrailing
                                        metrics:nil
                                        views:NSDictionaryOfVariableBindings(tableView)]];
    
    [self.childTableViewController didMoveToParentViewController:self];
}

- (void)configureSearchDisplayController
{
    self.searchDisplayController.delegate = self.searchViewController;
    self.searchDisplayController.searchResultsTableView.delegate = self.searchViewController;
    self.searchDisplayController.searchResultsTableView.dataSource = self.searchViewController;
}

#pragma mark - MTItemListViewInterface

- (void)configureNavigationBarWithTitle:(NSString *)title
{
    self.navigationItem.title = title;
}

- (void)configureLeftBarButtonWithTitle:(NSString *)title
{
    [self.navigationItem.leftBarButtonItem setTitle:title];
}

- (void)configureRightBarButtonWithTitle:(NSString *)title
{
    [self.navigationItem.rightBarButtonItem setTitle:title];
}

- (void)configureSearchBarWithPlaceholder: (NSString*)placeholder
{
    self.searchBar.placeholder = placeholder;
}

@end
