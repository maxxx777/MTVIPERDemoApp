//
//  MTRootTableViewController.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTRootTablePresenterInterface;

@interface MTRootTableViewController : UITableViewController

@property (nonatomic, strong) id<MTRootTablePresenterInterface> presenter;

@end
