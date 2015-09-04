//
//  MTMappedCountry.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMappedCountry.h"

@interface MTMappedCountry ()

@property (nonatomic, strong, readwrite) NSNumber *isCityListDownloaded;
@property (nonatomic, strong, readwrite) NSString *countryCode;
@property (nonatomic, strong, readwrite) NSString *continentName;
@property (nonatomic, strong, readwrite) NSString *capitalName;
@property (nonatomic, strong, readwrite) NSString *population;
@property (nonatomic, strong, readwrite) NSString *square;

@end

@implementation MTMappedCountry

- (instancetype)initWithItemId:(NSNumber *)itemId_
                      itemName:(NSString *)itemName_
          isCityListDownloaded:(NSNumber *)isCityListDownloaded_
                   countryCode:(NSString *)countryCode_
                 continentName:(NSString *)continentName_
                   capitalName:(NSString *)capitalName_
                    population:(NSString *)population_
                        square:(NSString *)square_
{
    self = [super initWithItemId:itemId_
                        itemName:itemName_];
    if (self) {
        
        _isCityListDownloaded = isCityListDownloaded_;
        _countryCode = countryCode_;
        _continentName = continentName_;
        _capitalName = capitalName_;
        _population = population_;
        _square = square_;
        
    }
    return self;
}

- (instancetype)initWithItemId:(NSNumber *)itemId_
                      itemName:(NSString *)itemName_
{
    return [self initWithItemId:itemId_
                       itemName:itemName_
           isCityListDownloaded:nil
                    countryCode:nil
                  continentName:nil
                    capitalName:nil
                     population:nil
                         square:nil];
}

@end
