//
//  MTAppModulesConnector.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTAppModulesConnector.h"
#import "MTCountryListWireframe.h"
#import "MTCityListWireframe.h"

@interface MTAppModulesConnector ()

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) MTCountryListWireframe *countryListModule;

@end

@implementation MTAppModulesConnector

- (instancetype)initWithWindow:(UIWindow *)window
{
    self = [super init];
    if (self) {
        
        _window = window;
    
    }
    return self;
}

#pragma mark - MTAppModulesConnectorInterface

- (void)configureDependencies
{
    _countryListModule = [[MTCountryListWireframe alloc] init];
    MTCityListWireframe *cityListModule = [[MTCityListWireframe alloc] init];
    
    self.countryListModule.cityListModule = cityListModule;
}

- (void)showMainScreen
{
    [self.countryListModule showCountryListViewInWindow:self.window];
}

@end
