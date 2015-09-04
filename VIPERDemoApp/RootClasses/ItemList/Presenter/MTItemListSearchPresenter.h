//
//  MTItemListSearchPresenter.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListSearchPresenterInterface.h"
#import "MTRootPresenter.h"

@protocol MTItemListSearchViewInterface;

@interface MTItemListSearchPresenter : MTRootPresenter
<
    MTItemListSearchPresenterInterface
>

@property (nonatomic, weak) id<MTItemListSearchViewInterface>userInterface;

@end
