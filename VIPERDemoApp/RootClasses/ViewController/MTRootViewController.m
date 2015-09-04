//
//  MTRootViewController.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootViewController.h"
#import "MTRootPresenterInterface.h"

@interface MTRootViewController ()

@end

@implementation MTRootViewController

- (void)dealloc
{
    DLog(@"%@ deallocated: %p", NSStringFromClass([self class]), self);
}

- (void)viewDidLoad
{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [super viewDidLoad];
}

@end
