//
//  MTCountryListPresenter.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCountryListPresenter.h"
#import "MTItemListViewInterface.h"
#import "MTCountryListWireframe.h"

@interface MTCountryListPresenter ()

@property (nonatomic, weak) MTCountryListWireframe *wireframe;

@end

@implementation MTCountryListPresenter

- (instancetype)initWithWireframe:(MTCountryListWireframe *)wireframe
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
    [self.userInterface configureNavigationBarWithTitle:NSLocalizedString(@"Select country", nil)];
    [self.userInterface configureLeftBarButtonWithTitle:NSLocalizedString(@"Back", nil)];
    [self.userInterface configureSearchBarWithPlaceholder:NSLocalizedString(@"Search country", nil)];
}

@end
