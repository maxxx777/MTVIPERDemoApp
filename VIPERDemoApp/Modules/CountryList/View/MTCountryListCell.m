//
//  MTCountryListCell.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCountryListCell.h"
#import "MTMappedCountry.h"

@implementation MTCountryListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //
        
    }
    return self;
}

- (void)configureCellWithItem:(id)item
{
    MTMappedCountry *mappedCountry = (MTMappedCountry *)item;
    
    self.textLabel.text = mappedCountry.itemName;
    self.detailTextLabel.text = mappedCountry.capitalName;
}

@end
