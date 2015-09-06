//
//  MTMappedCity.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMappedItem.h"

@class MTMappedCountry;

@interface MTMappedCity : MTMappedItem

@property (nonatomic, strong, readonly) MTMappedCountry *country;
@property (nonatomic, strong, readonly) NSNumber *latitude;
@property (nonatomic, strong, readonly) NSNumber *longitude;
@property (nonatomic, strong, readonly) NSString *adminName;
@property (nonatomic, strong, readonly) NSString *population;

- (instancetype) __unavailable init;
- (instancetype) __unavailable initWithItemId: (NSNumber *)itemId_
                                     itemName: (NSString *)itemName_;
- (instancetype)initWithItemId: (NSNumber *)itemId_
                      itemName: (NSString *)itemName_
                       country: (MTMappedCountry *)country_
                      latitude: (NSNumber *)latitude_
                     longitude: (NSNumber *)longitude_
                     adminName: (NSString *)adminName_
                    population: (NSString *)population_ NS_DESIGNATED_INITIALIZER;

@end
