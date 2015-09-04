//
//  MTMappedCity.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMappedCity.h"
#import "MTMappedCountry.h"

@interface MTMappedCity ()

@property (nonatomic, strong, readwrite) MTMappedCountry *country;

@end

@implementation MTMappedCity

- (instancetype)initWithItemId: (NSNumber *)itemId_
                      itemName: (NSString *)itemName_
                       country: (MTMappedCountry *)country_
                      latitude:(NSNumber *)latitude_
                     longitude:(NSNumber *)longitude_
                     adminName:(NSString *)adminName_
                    population:(NSString *)population_
{
    self = [super initWithItemId:itemId_
                        itemName:itemName_];
    if (self) {
        
        _country = country_;
        _latitude = latitude_;
        _longitude = longitude_;
        _adminName = adminName_;
        _population = population_;
        
    }
    return self;
}

- (instancetype)initWithItemId:(NSNumber *)itemId_
                      itemName:(NSString *)itemName_
{
    return [self initWithItemId:itemId_
                       itemName:itemName_
                        country:nil
                       latitude:nil
                      longitude:nil
                      adminName:nil
                     population:nil];
}

@end
