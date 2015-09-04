//
//  MTMergeItemsOperation+MTMergeObject.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMergeItemsOperation+MTMergeObject.h"
#import "MTDataStore.h"
#import "MTErrorHandlingConstants.h"
#import "MTDataMapping.h"

@implementation MTMergeItemsOperation (MTMergeObject)

- (BOOL)mt_mergeObjectWithEntity: (NSString *)entityName
                    mappedObject: (id)mappedObject
                  additionalData: (id)additionalData
                       predicate: (NSPredicate *)predicate
                         context: (NSManagedObjectContext *)context
                           error: (NSError * __autoreleasing *)error
{
    return [self mt_mergeObjectWithEntity:entityName
                             mappedObject:mappedObject
                           additionalData:additionalData
                                predicate:predicate
                             mergeChanges:YES
                                  context:context
                                    error:error];
}

- (BOOL)mt_mergeObjectWithEntity: (NSString *)entityName
                    mappedObject: (id)mappedObject
                  additionalData: (id)additionalData
                       predicate: (NSPredicate *)predicate
                    mergeChanges: (BOOL)mergeChanges
                         context: (NSManagedObjectContext *)context
                           error: (NSError * __autoreleasing *)error
{
    BOOL success = YES;
    
    @try {
        
        NSManagedObject* object = [[MTDataStore sharedStore] objectForEntity:entityName
                                                                   predicate:predicate
                                                           sortedDescriptors:nil
                                                                     context:context];
        
        if (object != nil) {
            
            [self mt_updateObject:object
                     mappedObject:mappedObject
                   additionalData:additionalData
                           entity:entityName
                     mergeChanges:mergeChanges
                          context:context];
            
        } else {
            
            [self mt_insertObjectWithMappedObject:mappedObject
                                   additionalData:additionalData
                                           entity:entityName
                                          context:context];
        }
    }
    @catch (NSException *exception) {
        DLog(@"%@", exception);
        success = NO;
    }
    @finally {
        
        if (!success) {
            if (error) {
                *error = [NSError errorWithDomain:MTErrorHandlingErrorDomain
                                             code:MTErrorTypeMergeObject
                                         userInfo:nil];
            }
        }
        
        return success;
    }
}

- (void)mt_updateObject: (NSManagedObject*)object
           mappedObject: (id)mappedObject
         additionalData: (id)additionalData
                 entity: (NSString*)entityName
           mergeChanges: (BOOL)mergeChanges
                context: (NSManagedObjectContext*)context
{
    MTDataMapping* dataMapping = [[MTDataMapping alloc] init];
    
    NSDictionary* valuesAndKeys = [dataMapping managedObjectDictFromMappedObject:mappedObject
                                                                  additionalData:additionalData
                                                                      entityName:entityName];
    [object setValuesForKeysWithDictionary:valuesAndKeys];
    [context refreshObject:object mergeChanges:mergeChanges];
}

- (void)mt_insertObjectWithMappedObject: (id)mappedObject
                         additionalData: (id)additionalData
                                 entity: (NSString*)entityName
                                context: (NSManagedObjectContext*)context
{
    NSManagedObject* object = [self mt_newObjectWithMappedObject:mappedObject
                                                  additionalData:additionalData
                                                          entity:entityName
                                                         context:context];
    
    [context insertObject:object];
}

- (NSManagedObject*)mt_newObjectWithMappedObject: (id)mappedObject
                                  additionalData: (id)additionalData
                                          entity: (NSString*)entityName
                                         context: (NSManagedObjectContext*)context
{
    NSManagedObject* object = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
    
    MTDataMapping* dataMapping = [[MTDataMapping alloc] init];
    
    NSDictionary* valuesAndKeys = [dataMapping managedObjectDictFromMappedObject:mappedObject
                                                                  additionalData:additionalData
                                                                      entityName:entityName];
    
    [object setValuesForKeysWithDictionary:valuesAndKeys];
    
    return object;
}

@end
