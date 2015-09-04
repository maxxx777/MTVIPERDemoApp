//
//  UIColor+MTSpecificColors.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 23.05.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "UIColor+MTSpecificColors.h"
#import "UIColor+colorWithHex.h"

@implementation UIColor (MTSpecificColors)

+ (UIColor *)mt_tableViewTextColor
{
    return [UIColor colorWithHex:0xbfc7d1];
}

+ (UIColor *)mt_tableViewBackgroundColor
{
    return [UIColor colorWithHex:0x2a323e];
}

+ (UIColor *)mt_tableViewFooterTextColor
{
    return [UIColor colorWithHex:0x878fa4];
}

+ (UIColor *)mt_tableViewSectionIndexColor
{
    return [UIColor colorWithHex:0x8795a4];
}

@end
