//
//  MTRootInteractor.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootInteractor.h"

@interface MTRootInteractor ()

@property (nonatomic, strong) NSPointerArray *outputsPointerArray;

@end

@implementation MTRootInteractor

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _outputsPointerArray = [NSPointerArray weakObjectsPointerArray];
        
    }
    return self;
}

- (void)dealloc
{
    DLog(@"%@ deallocated: %p", NSStringFromClass([self class]), self);
}

- (void)setOutputs:(NSArray *)outputs
{
    _outputsPointerArray = [NSPointerArray weakObjectsPointerArray];
    for (id output in outputs) {
        [self.outputsPointerArray addPointer:(__bridge void *)output];
    }
}

- (NSArray *)outputs
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.outputsPointerArray count]; i++) {
        id object = [self.outputsPointerArray pointerAtIndex:i];
        if (object) {
            [result addObject:object];
        }        
    }
    return result;
}

@end
