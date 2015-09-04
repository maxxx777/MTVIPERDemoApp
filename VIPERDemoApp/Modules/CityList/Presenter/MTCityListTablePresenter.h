//
//  MTCountryListTablePresenter.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListTablePresenter.h"
#import "MTItemListRequesterIOInterface.h"
#import "MTItemListFetcherIOInterface.h"

@class MTCityListWireframe;

@interface MTCityListTablePresenter : MTItemListTablePresenter
<
    MTItemListRequesterOutputInterface,
    MTItemListFetcherOutputInterface
>

- (instancetype)initWithItemListRequester:(id<MTItemListRequesterInputInterface>)itemListRequester
                          itemListFetcher:(id<MTItemListFetcherInputInterface>)itemListFetcher
                                wireframe:(MTCityListWireframe *)wireframe NS_DESIGNATED_INITIALIZER;

@end
