//
//  MTOperationManager.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTOperationManager.h"
#import "MTRootOperation.h"

@implementation MTOperationManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.sharedOperationQueue = [[NSOperationQueue alloc] init];
        self.sharedOperationQueue.maxConcurrentOperationCount = 1;
    }
    return self;
}

+ (MTOperationManager *)sharedManager
{
    static MTOperationManager *sharedManager = nil;
    static dispatch_once_t isDispatched;
    
    dispatch_once(&isDispatched, ^
                  {
                      sharedManager = [[self alloc] init];
                  });
    
    return sharedManager;
}

#pragma mark - Public

- (void)queueOperation:(MTRootOperation *)operation
{
    [self.sharedOperationQueue addOperation:operation];
}

- (void)cancelAllOperations
{
    [self.sharedOperationQueue cancelAllOperations];
}

@end
