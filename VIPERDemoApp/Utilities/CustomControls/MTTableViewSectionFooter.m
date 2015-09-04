//
//  MTTableViewSectionHeader.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTTableViewSectionFooter.h"

@interface MTTableViewSectionFooter ()

@property (nonatomic, strong) UILabel *labelTitle;

@end

@implementation MTTableViewSectionFooter

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        _labelTitle = [[UILabel alloc] init];
        self.labelTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
        self.labelTitle.textColor = [UIColor blackColor];
        self.labelTitle.textAlignment = NSTextAlignmentCenter;
        self.labelTitle.backgroundColor = [UIColor whiteColor];
        self.labelTitle.numberOfLines = 0;
        [self.contentView addSubview:self.labelTitle];
        
        [self.labelTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"H:|-14-[_labelTitle]-14-|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(_labelTitle)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:|-0-[_labelTitle]-0-|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(_labelTitle)]];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    self.labelTitle.text = title;
}

@end
