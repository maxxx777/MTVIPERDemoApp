//
//  MTCountryListPresenter.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCityListPresenter.h"
#import "MTItemListViewInterface.h"
#import "MTCityListWireframe.h"

@interface MTCityListPresenter ()

@property (nonatomic, weak) MTCityListWireframe *wireframe;

@end

@implementation MTCityListPresenter

- (instancetype)initWithWireframe:(MTCityListWireframe *)wireframe
{
    self = [super init];
    if (self) {
        
        _wireframe = wireframe;
        
    }
    return self;
}

#pragma mark - MTItemListPresenterInterface

- (void)configureView
{
    [self.userInterface configureNavigationBarWithTitle:NSLocalizedString(@"Select city", nil)];
    [self.userInterface configureLeftBarButtonWithTitle:NSLocalizedString(@"Back", nil)];
    [self.userInterface configureSearchBarWithPlaceholder:NSLocalizedString(@"Search city", nil)];
}

@end
