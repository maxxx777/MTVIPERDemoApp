//
//  MTRootWebService.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTNetworkWrapperInterface.h"
#import "MTWebServiceParserInterface.h"
#import "MTWebServiceSerializerInterface.h"
#import "MTURLRequestBuilderInterface.h"
#import "MTRootServiceConstants.h"

@interface MTRootWebService : NSObject

@property (nonatomic, strong, readonly) id<MTNetworkWrapperInterface>networkWrapper;
@property (nonatomic, strong, readonly) id<MTWebServiceSerializerInterface>serializer;
@property (nonatomic, strong, readonly) id<MTWebServiceParserInterface>parser;
@property (nonatomic, strong, readonly) id<MTURLRequestBuilderInterface>requestBuilder;

- (instancetype)initWithNetworkWrapper:(id<MTNetworkWrapperInterface>)networkWrapper
                            serializer:(id<MTWebServiceSerializerInterface>)serializer
                                parser:(id<MTWebServiceParserInterface>)parser
                        requestBuilder:(id<MTURLRequestBuilderInterface>)requestBuilder NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithSerializer:(id<MTWebServiceSerializerInterface>)serializer
                            parser:(id<MTWebServiceParserInterface>)parser
                    requestBuilder:(id<MTURLRequestBuilderInterface>)requestBuilder;

@end
