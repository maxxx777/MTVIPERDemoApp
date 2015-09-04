//
//  MTRootWebService.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootWebService.h"
#import "MTNetworkWrapper.h"
#import "MTWebServiceSerializer.h"
#import "MTWebServiceParser.h"
#import "MTRequestBuilder.h"

@interface MTRootWebService ()

@property (nonatomic, strong) id<MTNetworkWrapperInterface>networkWrapper;
@property (nonatomic, strong) id<MTWebServiceSerializerInterface>serializer;
@property (nonatomic, strong) id<MTWebServiceParserInterface>parser;

@end

@implementation MTRootWebService

- (void)dealloc
{
    DLog(@"%@ deallocated: %p", NSStringFromClass([self class]), self);
}

- (instancetype)initWithNetworkWrapper:(id<MTNetworkWrapperInterface>)networkWrapper
                            serializer:(id<MTWebServiceSerializerInterface>)serializer
                                parser:(id<MTWebServiceParserInterface>)parser
                        requestBuilder:(id<MTRequestBuilderInterface>)requestBuilder
{
    self = [super init];
    if (self) {
        
        _networkWrapper = networkWrapper;
        _serializer = serializer;
        _parser = parser;
        _requestBuilder = requestBuilder;
        
    }
    return self;
}

- (instancetype)initWithSerializer:(id<MTWebServiceSerializerInterface>)serializer
                            parser:(id<MTWebServiceParserInterface>)parser
                    requestBuilder:(id<MTRequestBuilderInterface>)requestBuilder
{
    MTNetworkWrapper *networkWrapper = [[MTNetworkWrapper alloc] init];
    return [self initWithNetworkWrapper:networkWrapper
                             serializer:serializer
                                 parser:parser
                         requestBuilder:requestBuilder];
}

- (instancetype)init
{
    MTNetworkWrapper *networkWrapper = [[MTNetworkWrapper alloc] init];
    MTWebServiceSerializer *serializer = [[MTWebServiceSerializer alloc] init];
    MTWebServiceParser *parser = [[MTWebServiceParser alloc] init];
    MTRequestBuilder *requestBuilder = [[MTRequestBuilder alloc] init];
    return [self initWithNetworkWrapper:networkWrapper
                             serializer:serializer
                                 parser:parser
                         requestBuilder:requestBuilder];
}

@end
