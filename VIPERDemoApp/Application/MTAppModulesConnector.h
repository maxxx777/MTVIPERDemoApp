//
//  MTAppModulesConnector.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTAppModulesConnectorInterface.h"

@interface MTAppModulesConnector : NSObject
<
    MTAppModulesConnectorInterface
>

- (instancetype)initWithWindow:(UIWindow *)window NS_DESIGNATED_INITIALIZER;

@end
