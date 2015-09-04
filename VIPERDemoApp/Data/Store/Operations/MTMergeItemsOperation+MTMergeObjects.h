//
//  MTMergeItemsOperation+MTMergeObjects.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMergeItemsOperation.h"

@interface MTMergeItemsOperation (MTMergeObjects)

- (BOOL)mt_mergeObjects: (NSArray *)objects
         idPropertyName: (NSString *)idPropertyName
                 entity: (NSString *)entityName
         additionalData: (id)additionalData
              predicate: (NSPredicate *)predicate
                context: (NSManagedObjectContext *)context
                  error: (NSError * __autoreleasing *)error;
- (BOOL)mt_mergeObjects: (NSArray *)objects
         idPropertyName: (NSString *)idPropertyName
                 entity: (NSString *)entityName
         additionalData: (id)additionalData
              predicate: (NSPredicate *)predicate
           mergeChanges: (BOOL)mergeChanges
                context: (NSManagedObjectContext *)context
                  error: (NSError * __autoreleasing *)error;
- (NSSet *)mt_idsOfObjectsForDeleteWithOldObjectsIds: (NSSet *)oldObjectsIds
                                       newObjectsIds: (NSSet *)newObjectsIds;
- (NSSet *)mt_idsOfObjectsForUpdateWithOldObjectsIds: (NSSet *)oldObjectsIds
                                       newObjectsIds: (NSSet *)newObjectsIds;
- (NSSet *)mt_idsOfObjectsForInsertWithOldObjectsIds: (NSSet *)oldObjectsIds
                                       newObjectsIds: (NSSet *)newObjectsIds;
- (void)mt_deleteObjectsWithIds: (NSSet *)idsOfObjectsForDelete
                 idPropertyName: (NSString *)idPropertyName
                     entityName: (NSString *)entityName
                        context: (NSManagedObjectContext *)context;
- (void)mt_updateObjectsWithIds: (NSSet *)idsOfObjectsForUpdate
                     newObjects: (NSArray *)newObjects
                 additionalData: (id)additionalData
                 idPropertyName: (NSString *)idPropertyName
                     entityName: (NSString *)entityName
                        context: (NSManagedObjectContext *)context;
- (void)mt_insertObjectsWithIds: (NSSet *)idsOfObjectsForInsert
                     newObjects: (NSArray *)newObjects
                 additionalData: (id)additionalData
                 idPropertyName: (NSString *)idPropertyName
                     entityName: (NSString *)entityName
                        context: (NSManagedObjectContext *)context;

@end
