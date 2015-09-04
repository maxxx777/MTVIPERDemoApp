//
//  MTMergeItemsOperation+MTMergeObjects.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMergeItemsOperation+MTMergeObjects.h"
#import "MTDataStore.h"
#import "MTErrorHandlingConstants.h"
#import "MTMergeItemsOperation+MTMergeObject.h"

@implementation MTMergeItemsOperation (MTMergeObjects)

- (BOOL)mt_mergeObjects: (NSArray *)objects
         idPropertyName: (NSString *)idPropertyName
                 entity: (NSString *)entityName
         additionalData: (id)additionalData
              predicate: (NSPredicate *)predicate
                context: (NSManagedObjectContext *)context
                  error: (NSError * __autoreleasing *)error
{
    return [self mt_mergeObjects:objects
                  idPropertyName:idPropertyName
                          entity:entityName
                  additionalData:additionalData
                       predicate:predicate
                    mergeChanges:YES
                         context:context
                           error:error];
}

- (BOOL)mt_mergeObjects: (NSArray *)objects
         idPropertyName: (NSString *)idPropertyName
                 entity: (NSString *)entityName
         additionalData: (id)additionalData
              predicate: (NSPredicate *)predicate
           mergeChanges: (BOOL)mergeChanges
                context: (NSManagedObjectContext *)context
                  error: (NSError * __autoreleasing *)error
{
    BOOL success = YES;
    
    @try {
        
        NSSet* idsOfNewObjects = [NSSet setWithArray:[objects valueForKey:idPropertyName]];
        
        NSArray* idsOfRelatedOldObjectsArray = [[MTDataStore sharedStore] objectsForEntity:entityName
                                                                                 predicate:predicate
                                                                         sortedDescriptors:nil
                                                                         propertiesToFetch:@[idPropertyName]
                                                                       includesSubentities:YES
                                                                    returnsObjectsAsFaults:NO
                                                                    includesPendingChanges:YES
                                                                                   context:context];
        NSSet* idsOfRelatedOldObjects = [NSSet setWithArray:[idsOfRelatedOldObjectsArray valueForKey:idPropertyName]];
        
        NSSet* idsOfObjectsForDelete = [self mt_idsOfObjectsForDeleteWithOldObjectsIds:idsOfRelatedOldObjects
                                                                         newObjectsIds:idsOfNewObjects];
        //        DLog(@"objects count for delete: %lu", (unsigned long)[idsOfObjectsForDelete count]);
        
        NSArray* idsOfAllOldObjectsArray = [[MTDataStore sharedStore] objectsForEntity:entityName
                                                                             predicate:nil
                                                                     sortedDescriptors:nil
                                                                     propertiesToFetch:@[idPropertyName]
                                                                   includesSubentities:YES
                                                                returnsObjectsAsFaults:NO
                                                                includesPendingChanges:YES
                                                                               context:context];
        NSSet* idsOfAllOldObjects = [NSSet setWithArray:[idsOfAllOldObjectsArray valueForKey:idPropertyName]];
        
        NSSet* idsOfObjectsForUpdate = [self mt_idsOfObjectsForUpdateWithOldObjectsIds:idsOfAllOldObjects
                                                                         newObjectsIds:idsOfNewObjects];
        //        DLog(@"objects count for update: %lu", (unsigned long)[idsOfObjectsForUpdate count]);
        
        NSSet* idsOfObjectsForInsert = [self mt_idsOfObjectsForInsertWithOldObjectsIds:idsOfAllOldObjects
                                                                         newObjectsIds:idsOfNewObjects];
        //        DLog(@"objects count for insert: %lu", (unsigned long)[idsOfObjectsForInsert count]);
        
        [self mt_deleteObjectsWithIds:idsOfObjectsForDelete
                       idPropertyName:idPropertyName
                           entityName:entityName
                              context:context];
        
        [self mt_updateObjectsWithIds:idsOfObjectsForUpdate
                           newObjects:objects
                       additionalData:additionalData
                       idPropertyName:idPropertyName
                           entityName:entityName
                         mergeChanges:mergeChanges
                              context:context];
        
        [self mt_insertObjectsWithIds:idsOfObjectsForInsert
                           newObjects:objects
                       additionalData:additionalData
                       idPropertyName:idPropertyName
                           entityName:entityName
                              context:context];
        
    }
    @catch (NSException *exception) {
        DLog(@"%@", exception);
        success = NO;
    }
    @finally {
        
        if (!success) {
            if (error) {
                *error = [NSError errorWithDomain:MTErrorHandlingErrorDomain
                                             code:MTErrorTypeMergeObjects
                                         userInfo:nil];
            }
        }
        
        return success;
    }
}

- (NSSet*)mt_idsOfObjectsForDeleteWithOldObjectsIds: (NSSet *)oldObjectsIds
                                      newObjectsIds: (NSSet *)newObjectsIds
{
    return [oldObjectsIds filteredSetUsingPredicate:
            [NSPredicate predicateWithFormat:@"NOT SELF IN %@", newObjectsIds]];
}

- (NSSet*)mt_idsOfObjectsForUpdateWithOldObjectsIds: (NSSet *)oldObjectsIds
                                      newObjectsIds: (NSSet *)newObjectsIds
{
    return [oldObjectsIds filteredSetUsingPredicate:
            [NSPredicate predicateWithFormat:@"SELF IN %@", newObjectsIds]];
}

- (NSSet*)mt_idsOfObjectsForInsertWithOldObjectsIds: (NSSet *)oldObjectsIds
                                      newObjectsIds: (NSSet *)newObjectsIds
{
    return [newObjectsIds filteredSetUsingPredicate:
            [NSPredicate predicateWithFormat:@"NOT SELF IN %@", oldObjectsIds]];
}

- (void)mt_deleteObjectsWithIds: (NSSet *)idsOfObjectsForDelete
                 idPropertyName: (NSString *)idPropertyName
                     entityName: (NSString *)entityName
                        context: (NSManagedObjectContext *)context
{
    //delete objects
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
    [fetch setPredicate:[NSPredicate predicateWithFormat:@"%K IN %@", idPropertyName, idsOfObjectsForDelete]];
    NSArray *result = [context executeFetchRequest:fetch error:nil];
    for (NSManagedObject *o in result) {
        [[MTDataStore sharedStore] deleteObject:o
                                        context:context];
    }
    
}

- (void)mt_updateObjectsWithIds: (NSSet *)idsOfObjectsForUpdate
                     newObjects: (NSArray *)newObjects
                 additionalData: (id)additionalData
                 idPropertyName: (NSString *)idPropertyName
                     entityName: (NSString *)entityName
                        context: (NSManagedObjectContext *)context
{
    [self mt_updateObjectsWithIds:idsOfObjectsForUpdate
                       newObjects:newObjects
                   additionalData:additionalData
                   idPropertyName:idPropertyName
                       entityName:entityName
                     mergeChanges:YES
                          context:context];
}

- (void)mt_updateObjectsWithIds: (NSSet *)idsOfObjectsForUpdate
                     newObjects: (NSArray *)newObjects
                 additionalData: (id)additionalData
                 idPropertyName: (NSString *)idPropertyName
                     entityName: (NSString *)entityName
                   mergeChanges: (BOOL)mergeChanges
                        context: (NSManagedObjectContext *)context
{
    //update objects
    NSSortDescriptor* sd = [[NSSortDescriptor alloc] initWithKey:idPropertyName ascending:YES];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K IN %@", idPropertyName, idsOfObjectsForUpdate];
    
    NSArray* newObjectsForUpdate = [newObjects filteredArrayUsingPredicate:predicate];
    newObjectsForUpdate = [newObjectsForUpdate sortedArrayUsingDescriptors:@[sd]];
    NSArray* oldObjectsForUpdate = [[MTDataStore sharedStore] objectsForEntity:entityName
                                                                     predicate:predicate
                                                             sortedDescriptors:@[sd]
                                                                       context:context];
    for (int i = 0; i < [oldObjectsForUpdate count]; i++) {
        
        NSManagedObject* oldObject = oldObjectsForUpdate[i];
        id newObject = newObjectsForUpdate[i];
        
        [self mt_updateObject:oldObject
                 mappedObject:newObject
               additionalData:additionalData
                       entity:entityName
                 mergeChanges:mergeChanges
                      context:context];
    }
}

- (void)mt_insertObjectsWithIds: (NSSet *)idsOfObjectsForInsert
                     newObjects: (NSArray *)newObjects
                 additionalData: (id)additionalData
                 idPropertyName: (NSString *)idPropertyName
                     entityName: (NSString *)entityName
                        context: (NSManagedObjectContext *)context
{
    //insert objects
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K IN %@", idPropertyName, idsOfObjectsForInsert];
    NSArray* objectsForInsert = [newObjects filteredArrayUsingPredicate:predicate];
    for (id mappedObject in objectsForInsert) {
        
        [self mt_insertObjectWithMappedObject:mappedObject
                               additionalData:additionalData
                                       entity:entityName
                                      context:context];
    }
}

@end
