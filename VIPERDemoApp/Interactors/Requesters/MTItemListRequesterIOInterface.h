//
//  MTItemListRequesterIOInterface.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTItemListRequesterInputInterface <NSObject>

@optional

- (void)fetchItems;
- (void)refreshItems;
- (void)searchItemsWithSearchString: (NSString *)searchString;
- (void)cancelActions;

@end

@protocol MTItemListRequesterOutputInterface <NSObject>

- (void)onDidFetchItemsWithError:(NSError *)error;

@end
