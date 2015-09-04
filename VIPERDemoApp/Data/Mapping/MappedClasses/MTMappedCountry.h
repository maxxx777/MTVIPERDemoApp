//
//  MTMappedCountry.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMappedItem.h"

@interface MTMappedCountry : MTMappedItem

@property (nonatomic, strong, readonly) NSNumber *isCityListDownloaded;
@property (nonatomic, strong, readonly) NSString *countryCode;
@property (nonatomic, strong, readonly) NSString *continentName;
@property (nonatomic, strong, readonly) NSString *capitalName;
@property (nonatomic, strong, readonly) NSString *population;
@property (nonatomic, strong, readonly) NSString *square;

- (instancetype) __unavailable init;
- (instancetype) __unavailable initWithItemId: (NSNumber *)itemId_
                                     itemName: (NSString *)itemName_;
- (instancetype)initWithItemId: (NSNumber *)itemId_
                      itemName: (NSString *)itemName_
          isCityListDownloaded: (NSNumber *)isCityListDownloaded_
                   countryCode: (NSString *)countryCode_
                 continentName: (NSString *)continentName_
                   capitalName: (NSString *)capitalName_
                    population: (NSString *)population_
                        square: (NSString *)square_ NS_DESIGNATED_INITIALIZER;

@end
