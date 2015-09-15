//
//  MTDataMapping.m
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//

#import "MTDataMapping.h"
#import "MTManagedCountry.h"
#import "MTManagedCity.h"
#import "MTMappedCountry.h"
#import "MTMappedCity.h"

@implementation MTDataMapping

- (id)mappedObjectFromManagedObject: (NSManagedObject *)managedObject
{
    if (managedObject == nil) {
        return nil;
    }
    
    if ([managedObject isKindOfClass:[MTManagedCountry class]]) {
        
        return [[MTMappedCountry alloc] initWithItemId:[managedObject valueForKey:@"itemId"]
                                              itemName:[managedObject valueForKey:@"itemName"]
                                  isCityListDownloaded:[managedObject valueForKey:@"isCityListDownloaded"]
                                           countryCode:[managedObject valueForKey:@"countryCode"]
                                         continentName:[managedObject valueForKey:@"continentName"]
                                           capitalName:[managedObject valueForKey:@"capitalName"]
                                            population:[managedObject valueForKey:@"population"]
                                                square:[managedObject valueForKey:@"square"]];
        
    } else if ([managedObject isKindOfClass:[MTManagedCity class]]) {
        
        NSManagedObject *managedCountry = [managedObject valueForKey:@"country"];
        
        id mappedCountry = [self mappedObjectFromManagedObject:managedCountry];
        
        return [[MTMappedCity alloc] initWithItemId:[managedObject valueForKey:@"itemId"]
                                           itemName:[managedObject valueForKey:@"itemName"]
                                            country:mappedCountry
                                           latitude:[managedObject valueForKey:@"latitude"]
                                          longitude:[managedObject valueForKey:@"longitude"]
                                          adminName:[managedObject valueForKey:@"adminName"]
                                         population:[managedObject valueForKey:@"population"]];
    }
    
    return nil;
}

- (NSDictionary *)managedObjectDictFromMappedObject:(id)mappedObject
                                     additionalData:(id)additionalData
                                         entityName:(NSString *)entityName
{
    if ([entityName isEqualToString:@"MTManagedCountry"]) {
        
        NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
        MTMappedCountry *mappedCountry = (MTMappedCountry *)mappedObject;
        
        if (mappedCountry.itemId) {
            result[@"itemId"] = mappedCountry.itemId;
        }
        
        if (mappedCountry.itemName) {
            result[@"itemName"] = mappedCountry.itemName;
        }
        
        if (mappedCountry.isCityListDownloaded) {
            result[@"isCityListDownloaded"] = mappedCountry.isCityListDownloaded;
        }
        
        if (mappedCountry.countryCode) {
            result[@"countryCode"] = mappedCountry.countryCode;
        }
        
        if (mappedCountry.continentName) {
            result[@"continentName"] = mappedCountry.continentName;
        }
        
        if (mappedCountry.capitalName) {
            result[@"capitalName"] = mappedCountry.capitalName;
        }
        
        if (mappedCountry.population) {
            result[@"population"] = mappedCountry.population;
        }
        
        if (mappedCountry.square) {
            result[@"square"] = mappedCountry.square;
        }
        
        return result;
        
    } else if ([entityName isEqualToString:@"MTManagedCity"]) {
        
        NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
        MTMappedCity *mappedCity = (MTMappedCity *)mappedObject;
        
        if (mappedCity.itemId) {
            result[@"itemId"] = mappedCity.itemId;
        }
        
        if (mappedCity.itemName) {
            result[@"itemName"] = mappedCity.itemName;
        }
        
        if (mappedCity.latitude) {
            result[@"latitude"] = mappedCity.latitude;
        }
        
        if (mappedCity.longitude) {
            result[@"longitude"] = mappedCity.longitude;
        }
        
        if (mappedCity.adminName) {
            result[@"adminName"] = mappedCity.adminName;
        }
        
        if (mappedCity.population) {
            result[@"population"] = mappedCity.population;
        }
        
        NSManagedObject *country = (NSManagedObject *)additionalData;
        
        if (country != nil) {
            result[@"country"] = country;
        }
        
        return result;
    }
    
    return nil;
}

@end
