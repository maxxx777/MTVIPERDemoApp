//
//  MTMergeCountriesOperation.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMergeItemsOperation.h"

@protocol MTMergeObjectsOperationDelegate;

@interface MTMergeCountriesOperation : MTMergeItemsOperation

- (instancetype) __unavailable init;
- (instancetype)initWithCountries: (NSArray *)countries
                         delegate: (id<MTMergeObjectsOperationDelegate>)delegate NS_DESIGNATED_INITIALIZER;

@end
