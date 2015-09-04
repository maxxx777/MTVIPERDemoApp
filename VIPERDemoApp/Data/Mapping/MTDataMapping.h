//
//  MTDataMapping.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@interface MTDataMapping : NSObject

- (id)mappedObjectFromManagedObject: (NSManagedObject *)managedObject;
- (NSDictionary*)managedObjectDictFromMappedObject: (id)mappedObject
                                    additionalData: (id)additionalData
                                        entityName: (NSString *)entityName;

@end
