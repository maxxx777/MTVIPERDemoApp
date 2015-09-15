//
//  MTDataMappingInterface.h
//
//  Created by MAXIM TSVETKOV on 06.09.15.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol MTDataMappingInterface <NSObject>

- (id)mappedObjectFromManagedObject: (NSManagedObject *)managedObject;
- (NSDictionary*)managedObjectDictFromMappedObject: (id)mappedObject
                                    additionalData: (id)additionalData
                                        entityName: (NSString *)entityName;

@end
