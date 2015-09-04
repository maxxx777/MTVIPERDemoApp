//
//  MTItemListPresenter.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootPresenter.h"
#import "MTItemListPresenterInterface.h"

@protocol MTItemListViewInterface;

@interface MTItemListPresenter : MTRootPresenter
<
    MTItemListPresenterInterface
>

@property (nonatomic, weak) UIViewController<MTItemListViewInterface> *userInterface;

@end
