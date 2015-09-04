//
//  MTCountryListSearchPresenter.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListSearchPresenter.h"
#import "MTItemListRequesterIOInterface.h"
#import "MTItemListSearcherIOInterface.h"

@class MTCityListWireframe;

@interface MTCityListSearchPresenter : MTItemListSearchPresenter
<
    MTItemListRequesterOutputInterface,
    MTItemListSearcherOutputInterface
>

- (instancetype)initWithItemListRequester:(id<MTItemListRequesterInputInterface>)itemListRequester
                         itemListSearcher:(id<MTItemListSearcherInputInterface>)itemListSearcher
                                wireframe:(MTCityListWireframe *)wireframe NS_DESIGNATED_INITIALIZER;

@end
