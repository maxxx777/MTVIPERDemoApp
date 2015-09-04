//
//  MTWebServiceParser.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTWebServiceParser.h"

#import "MTMappedCity.h"
#import "MTMappedCountry.h"

@implementation MTWebServiceParser

#pragma mark - MTWebServiceParserInterface

- (id)parseCountryListFromRawData:(id)rawData
{
    id result;
    
    if ([rawData isKindOfClass:[NSDictionary class]]) {
        
        NSMutableArray *parsedCountries = [[NSMutableArray alloc] init];
        
        NSArray *rawArray = rawData[@"geonames"];
        for (id rawObject in rawArray) {
            
            id country = [self parseCountryObjectFromRawData:rawObject];
            
            [parsedCountries addObject:country];
        }
        
        result = [NSArray arrayWithArray:parsedCountries];
    }
    
    return result;
}

- (id)parseCityListFromRawData:(id)rawData
{
    id result;
    
    if ([rawData isKindOfClass:[NSDictionary class]]) {
        
        NSMutableArray *parsedCities = [[NSMutableArray alloc] init];
        
        NSArray *rawArray = rawData[@"geonames"];
        for (id rawObject in rawArray) {
            
            id city = [self parseCityObjectFromRawData:rawObject];
            
            [parsedCities addObject:city];
        }
        
        result = [NSArray arrayWithArray:parsedCities];
    }
    
    return result;
}

#pragma mark - Private

- (id)parseCountryObjectFromRawData:(id)rawData
{
    id result;
    
    if ([rawData isKindOfClass:[NSDictionary class]]) {
        
        NSNumber *itemId;
        NSString *itemName;
        NSString *countryCode;
        NSString *continentName;
        NSString *capitalName;
        NSString *population;
        NSString *square;
        
        itemId = rawData[@"geonameId"];
        itemName = rawData[@"countryName"];
        countryCode = rawData[@"countryCode"];
        continentName = rawData[@"continentName"];
        capitalName = rawData[@"capital"];
        population = rawData[@"population"];
        square = rawData[@"areaInSqKm"];
        
        result = [[MTMappedCountry alloc] initWithItemId:itemId
                                                itemName:itemName
                                    isCityListDownloaded:nil
                                             countryCode:countryCode
                                           continentName:continentName
                                             capitalName:capitalName
                                              population:population
                                                  square:square];
    }
    
    return result;
}

- (id)parseCityObjectFromRawData:(id)rawData
{
    id result;
    
    if ([rawData isKindOfClass:[NSDictionary class]]) {
        
        NSNumber *itemId;
        NSString *itemName;
        NSNumber *latitude;
        NSNumber *longitude;
        NSString *adminName;
        NSString *population;
        
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        [nf setNumberStyle:NSNumberFormatterDecimalStyle];
        
        itemId = rawData[@"geonameId"];
        itemName = rawData[@"name"];
        longitude = [nf numberFromString:rawData[@"lng"]];
        latitude = [nf numberFromString:rawData[@"lat"]];
        adminName = rawData[@"adminName1"];
        population = [nf stringFromNumber:rawData[@"population"]];
        
        result = [[MTMappedCity alloc] initWithItemId:itemId
                                             itemName:itemName
                                              country:nil
                                             latitude:latitude
                                            longitude:longitude
                                            adminName:adminName
                                           population:population];
    }
    
    return result;
}

@end
