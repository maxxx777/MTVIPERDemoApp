//
//  MTTableFooterView.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTTableFooterView.h"
#import "UIColor+MTSpecificColors.h"

@interface MTTableFooterView ()

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityFooter;

@end

@implementation MTTableFooterView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        _labelTitle = [[UILabel alloc] init];
        self.labelTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
        self.labelTitle.textColor = [UIColor mt_tableViewTextColor];
        self.labelTitle.textAlignment = NSTextAlignmentCenter;
        self.labelTitle.backgroundColor = [UIColor mt_tableViewBackgroundColor];
        self.labelTitle.numberOfLines = 0;
        [self addSubview:self.labelTitle];
        
        _activityFooter = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self addSubview:self.activityFooter];
        
        [self.labelTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-0-[_labelTitle]-0-|"
                              options:NSLayoutFormatDirectionLeadingToTrailing
                              metrics:nil
                              views:NSDictionaryOfVariableBindings(_labelTitle)]];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|-10-[_labelTitle]-10-|"
                              options:NSLayoutFormatDirectionLeadingToTrailing
                              metrics:nil
                              views:NSDictionaryOfVariableBindings(_labelTitle)]];
        
        [self.activityFooter setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSLayoutConstraint *yCenterConstraintForActivityIndicator = [NSLayoutConstraint constraintWithItem:self.activityFooter
                                                                                             attribute:NSLayoutAttributeCenterY
                                                                                             relatedBy:NSLayoutRelationEqual
                                                                                                toItem:self
                                                                                             attribute:NSLayoutAttributeCenterY
                                                                                            multiplier:1.0
                                                                                              constant:0];
        [self addConstraint:yCenterConstraintForActivityIndicator];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-20-[_activityFooter]-|"
                              options:NSLayoutFormatDirectionLeadingToTrailing
                              metrics:nil
                              views:NSDictionaryOfVariableBindings(_activityFooter)]];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setTitle:(NSString *)title animated:(BOOL)animated
{
    self.labelTitle.text = title;
    
    if (animated) {
        [self.activityFooter startAnimating];
    } else {
        [self.activityFooter stopAnimating];
    }
    
    self.labelTitle.hidden = [self.labelTitle.text length] == 0;
    CGFloat dh = [self.labelTitle.text length] == 0 ? 0.0f : 20.0f;
    
    self.labelTitle.preferredMaxLayoutWidth = self.labelTitle.frame.size.width + dh;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGFloat h = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + dh;
    
    CGRect frame = self.frame;
    frame.size.height = h;
    self.frame = frame;
}

- (void)setTitle:(NSString *)title
{
    [self setTitle:title animated:NO];
}

@end
