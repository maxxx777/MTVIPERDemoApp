//
//  MTNetworkWrapper.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTNetworkWrapperInterface.h"

@interface MTNetworkWrapper : NSObject
<
    NSURLConnectionDelegate,
    NSURLConnectionDataDelegate,
    MTNetworkWrapperInterface
>

@end
