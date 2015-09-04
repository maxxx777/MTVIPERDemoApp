//
//  MTRootTableViewController.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootTableViewController.h"
#import "MTRootTablePresenterInterface.h"
#import "MTTableViewSectionHeader.h"
#import "MTTableViewSectionFooter.h"
#import "UIColor+MTSpecificColors.h"

static NSString *HeaderIdentifier = @"ItemListTableViewSectionHeader";
static NSString *FooterIdentifier = @"ItemListTableViewSectionFooter";

@interface MTRootTableViewController ()

@end

@implementation MTRootTableViewController

- (void)dealloc
{
    DLog(@"%@ deallocated: %p", NSStringFromClass([self class]), self);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundView.backgroundColor = [UIColor mt_tableViewBackgroundColor];
    self.tableView.backgroundColor = [UIColor mt_tableViewBackgroundColor];
    if ([self.tableView respondsToSelector:@selector(sectionIndexBackgroundColor)]) {
        self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    } else {
        self.tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    }
    self.tableView.sectionIndexColor = [UIColor mt_tableViewSectionIndexColor];
    self.tableView.sectionFooterHeight = 0.0f;
    
    [self.tableView registerClass:[MTTableViewSectionHeader class]
forHeaderFooterViewReuseIdentifier:HeaderIdentifier];
}

#pragma mark - Table View Data Source

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MTTableViewSectionHeader *header = [[MTTableViewSectionHeader alloc] initWithReuseIdentifier:HeaderIdentifier];
    
    [header setTitle:[self tableView:tableView titleForHeaderInSection:section]];
    
    return header.contentView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    MTTableViewSectionFooter *footer = [[MTTableViewSectionFooter alloc] initWithReuseIdentifier:FooterIdentifier];
    
    [footer setTitle:[self tableView:tableView titleForFooterInSection:section]];
    
    return footer.contentView;
}

@end
