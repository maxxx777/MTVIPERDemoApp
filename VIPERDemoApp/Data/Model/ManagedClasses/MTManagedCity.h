//
//  MTManagedCity.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 03.09.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MTManagedItem.h"

@class MTManagedCountry;

@interface MTManagedCity : MTManagedItem

@property (nonatomic, retain) NSString * adminName;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * population;
@property (nonatomic, retain) MTManagedCountry *country;

@end
