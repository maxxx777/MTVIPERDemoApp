//
//  MTMergeObjectsOperationDelegate.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTMergeObjectsOperationDelegate <NSObject>

- (void)onDidObjectsMergeWithError: (NSError *)error
              isOperationCancelled: (BOOL)isOperationCancelled;

@end
