//
//  MTNetworkWrapperInterface.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTNetworkWrapperConstants.h"

@protocol MTNetworkWrapperInterface <NSObject>

- (void)sendHttpRequest:(NSURLRequest *)request
             completion:(MTNetworkWrapperRequestCompletionBlock)completion;

@end
