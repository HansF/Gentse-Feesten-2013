//
//  GFAPIClient.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 11/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFAPIClient.h"

#import "AFNetworking.h"

#define GFApiClientBaseUrl @"http://datatank.gent.be/"

@implementation GFAPIClient

+ (id)sharedInstance {
    static GFAPIClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[GFAPIClient alloc] initWithBaseURL:
                            [NSURL URLWithString:GFApiClientBaseUrl]];
    });
    return __sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }

    return self;
}

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [super getPath:path parameters:parameters success:success failure:failure];
}


@end
