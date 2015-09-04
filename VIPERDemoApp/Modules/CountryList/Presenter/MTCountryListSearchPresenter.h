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

@class MTCountryListWireframe;

@interface MTCountryListSearchPresenter : MTItemListSearchPresenter
<
    MTItemListRequesterOutputInterface,
    MTItemListSearcherOutputInterface
>

- (instancetype)initWithItemListRequester:(id<MTItemListRequesterInputInterface>)itemListRequester
                         itemListSearcher:(id<MTItemListSearcherInputInterface>)itemListSearcher
                                wireframe:(MTCountryListWireframe *)wireframe NS_DESIGNATED_INITIALIZER;

@end
