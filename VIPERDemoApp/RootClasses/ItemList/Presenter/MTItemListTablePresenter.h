//
//  MTItemListTablePresenter.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootTablePresenter.h"
#import "MTItemListTablePresenterInterface.h"

@protocol MTItemListTableViewInterface;

@interface MTItemListTablePresenter : MTRootTablePresenter
<
    MTItemListTablePresenterInterface
>

@property (nonatomic, weak) UIViewController<MTItemListTableViewInterface> *userInterface;

@end
