//
//  MTMergeCitiesOperation.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMergeCitiesOperation.h"
#import "MTMergeObjectsOperationDelegate.h"
#import "NSString+MTSpecificStrings.h"
#import "MTDataStore.h"
#import "MTErrorHandlingConstants.h"
#import "MTMergeItemsOperation+MTMergeObjects.h"
#import "MTMergeItemsOperation+MTMergeObject.h"
#import "MTMappedCountry.h"

@interface MTMergeCitiesOperation ()

@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong) MTMappedCountry *country;
@property (nonatomic, weak) id<MTMergeObjectsOperationDelegate> delegate;

@end

@implementation MTMergeCitiesOperation

- (instancetype)initWithCities:(NSArray *)cities
                       country:(MTMappedCountry *)country
                      delegate:(id<MTMergeObjectsOperationDelegate>)delegate
{
    self = [super init];
    if (self) {
        
        _cities = cities;
        _country = country;
        _delegate = delegate;
        
    }
    return self;
}

- (void)main
{
    NSError *error = nil;
    NSManagedObjectContext *context = [[MTDataStore sharedStore] privateQueueContext];
    
    NSNumber *countryId = self.country.itemId;
    NSManagedObject* managedCountry = [[MTDataStore sharedStore]
                                       objectForEntity:@"MTManagedCountry"
                                       predicate:[NSPredicate predicateWithFormat:@"itemId == %@", countryId]
                                       sortedDescriptors:nil
                                       context:context];
    
    BOOL success = [self mt_mergeObjects:self.cities
                          idPropertyName:[NSString mt_propertyNameForItemId]
                                  entity:@"MTManagedCity"
                          additionalData:managedCountry
                               predicate:[NSPredicate predicateWithFormat:@"country.itemId == %@", self.country.itemId]
                            mergeChanges:YES
                                 context:context
                                   error:&error];
    
    if (self.isCancelled) {
        [context rollback];
    } else {
        
        if (success) {
            success = [self mt_mergeObjectWithEntity:@"MTManagedCountry"
                                        mappedObject:self.country
                                      additionalData:nil
                                           predicate:[NSPredicate predicateWithFormat:@"itemId == %@", countryId]
                                             context:context
                                               error:&error];
            
            if (self.isCancelled) {
                [context rollback];
            } else {
                if (success) {
                    [[MTDataStore sharedStore] saveContext:context];
                }
            }
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(onDidObjectsMergeWithError:isOperationCancelled:)]) {
        [self.delegate onDidObjectsMergeWithError:error
                             isOperationCancelled:self.isCancelled];
    }
}

@end
