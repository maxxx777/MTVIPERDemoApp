//
//  MTItemListSearcherIOInterface.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTItemListSearcherInputInterface <NSObject>

- (NSUInteger)numberOfSearchResults;
- (id)searchResultAtIndex:(NSUInteger)index;

@end

@protocol MTItemListSearcherOutputInterface <NSObject>

@end
