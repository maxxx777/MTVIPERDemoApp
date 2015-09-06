//
//  MTMappedItem.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@interface MTMappedItem : NSObject

@property (nonatomic, strong, readonly) NSNumber *itemId;
@property (nonatomic, strong, readonly) NSString *itemName;

- (instancetype) __unavailable init;
- (instancetype)initWithItemId:(NSNumber *)itemId_
                      itemName:(NSString *)itemName_ NS_DESIGNATED_INITIALIZER;

@end
