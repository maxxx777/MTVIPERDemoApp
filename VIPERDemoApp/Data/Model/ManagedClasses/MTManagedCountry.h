//
//  MTManagedCountry.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 03.09.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MTManagedItem.h"

@class MTManagedCity;

@interface MTManagedCountry : MTManagedItem

@property (nonatomic, retain) NSString * capitalName;
@property (nonatomic, retain) NSString * continentName;
@property (nonatomic, retain) NSString * countryCode;
@property (nonatomic, retain) NSNumber * isCityListDownloaded;
@property (nonatomic, retain) NSString * population;
@property (nonatomic, retain) NSString * square;
@property (nonatomic, retain) NSSet *cities;
@end

@interface MTManagedCountry (CoreDataGeneratedAccessors)

- (void)addCitiesObject:(MTManagedCity *)value;
- (void)removeCitiesObject:(MTManagedCity *)value;
- (void)addCities:(NSSet *)values;
- (void)removeCities:(NSSet *)values;

@end
