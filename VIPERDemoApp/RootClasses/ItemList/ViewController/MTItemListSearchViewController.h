//
//  MTItemListSearchViewController.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListSearchViewInterface.h"

@protocol MTItemListSearchPresenterInterface;

@interface MTItemListSearchViewController : UITableViewController
<
    MTItemListSearchViewInterface,
    UISearchDisplayDelegate
>

@property (nonatomic, strong) id<MTItemListSearchPresenterInterface> presenter;

@end
