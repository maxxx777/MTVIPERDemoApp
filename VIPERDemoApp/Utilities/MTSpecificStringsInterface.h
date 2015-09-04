//
//  MTSpecificStringsInterface.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTSpecificStringsInterface <NSObject>

+ (NSString *)mt_appHostName;
+ (NSString *)mt_apiUserName;
+ (NSString *)mt_propertyNameForItemId;

@end
