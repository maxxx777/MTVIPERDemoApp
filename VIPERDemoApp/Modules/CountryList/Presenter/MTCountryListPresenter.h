//
//  MTCountryListPresenter.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListPresenter.h"

@class MTCountryListWireframe;

@interface MTCountryListPresenter : MTItemListPresenter

- (instancetype)initWithWireframe:(MTCountryListWireframe *)wireframe NS_DESIGNATED_INITIALIZER;

@end
