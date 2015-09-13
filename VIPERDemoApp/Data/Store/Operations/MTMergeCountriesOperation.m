//
//  MTMergeCountriesOperation.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMergeCountriesOperation.h"
#import "MTMergeObjectsOperationDelegate.h"
#import "NSString+MTSpecificStrings.h"
#import "MTDataStore.h"
#import "NSObject+MTMergeObjects.h"

@interface MTMergeCountriesOperation ()

@property (nonatomic, strong) NSArray *countries;
@property (nonatomic, weak) id<MTMergeObjectsOperationDelegate> delegate;

@end

@implementation MTMergeCountriesOperation

- (instancetype)initWithCountries:(NSArray *)countries
                         delegate:(id<MTMergeObjectsOperationDelegate>)delegate
{
    self = [super init];
    if (self) {
        
        _countries = countries;
        _delegate = delegate;
        
    }
    return self;
}

- (void)main
{
    NSError *error = nil;
    NSManagedObjectContext *context = [[MTDataStore sharedStore] privateQueueContext];
    
    BOOL success = [self mt_mergeObjects:self.countries
                          idPropertyName:[NSString mt_propertyNameForItemId]
                                  entity:@"MTManagedCountry"
                          additionalData:nil
                               predicate:nil
                            mergeChanges:YES
                                 context:context
                                   error:&error];
    
    if (self.isCancelled) {
        [context rollback];
    } else {
        if (success) {
            [[MTDataStore sharedStore] saveContext:context];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(onDidObjectsMergeWithError:isOperationCancelled:)]) {
        [self.delegate onDidObjectsMergeWithError:error
                             isOperationCancelled:self.isCancelled];
    }
}

@end
