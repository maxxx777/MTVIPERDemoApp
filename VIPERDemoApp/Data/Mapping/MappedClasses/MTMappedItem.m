//
//  MTMappedItem.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMappedItem.h"

@interface MTMappedItem ()

@end

@implementation MTMappedItem

- (instancetype)initWithItemId:(NSNumber *)itemId_
                      itemName:(NSString *)itemName_
{
    self = [super init];
    if (self) {
        _itemId = itemId_;
        _itemName = itemName_;
    }
    return self;
}

@end
