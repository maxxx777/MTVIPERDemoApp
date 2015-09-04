//
//  MTCountryListCell.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCityListCell.h"
#import "MTMappedCity.h"

@implementation MTCityListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //
        
    }
    return self;
}

- (void)configureCellWithItem:(id)item
{
    MTMappedCity *mappedCity = (MTMappedCity *)item;
    
    self.textLabel.text = mappedCity.itemName;
    self.detailTextLabel.text = mappedCity.adminName;
}

@end
