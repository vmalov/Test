//
//  APIManager.m
//  TestApp
//
//  Created by vmalov on 26.09.15.
//  Copyright © 2015 vmalov. All rights reserved.
//

#import "APIWrapper.h"
#import "NSString+VM.h"
#import "NSURLResponse+VM.h"
@interface APIWrapper ()
@property (nonatomic) NSURLSession *session;
@end

@implementation APIWrapper

+ (instancetype)instance {
    static dispatch_once_t once;
    static APIWrapper *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    }
    return self;
}

#pragma mark - POST

- (NSURLRequest *)getRequestwithMethod:(NSString *)method
                             andParams:(NSString *)params{
    NSString *url = [kServerAddress stringByAppendingString:[NSString stringWithFormat:@"%@",method]];
    NSURL *reqURL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:reqURL
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:60.0];
    
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];

    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:language forHTTPHeaderField:@"Content-Language"];
    
    [request setHTTPMethod:@"GET"];
    
    return request;
}

-(void)GETMethodWithRequest:(NSURLRequest *)request
                 andSuccess:(objectBlock)success
                 andFailure:(FailureBlock)failure{
    [[self.session dataTaskWithRequest:request
                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                         
                         NSDictionary *dictionary;
                         if (response) {
                             dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:NSJSONReadingAllowFragments
                                                                            error:&error];
                         }
                         if (!error && response.statusCode < 300) {
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 success(dictionary);
                             });
                         }
                         else{
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 failure(error.userInfo);
                             });
                         }
                     }] resume];
}

-(void)GETMethod:(NSString *)URL
   withParametrs:(NSString *)parameters
      andSuccess:(objectBlock)success
      andFailure:(FailureBlock)failure{
    
    NSURLRequest *request = [self getRequestwithMethod:URL
                                             andParams:parameters];
    
    [self GETMethodWithRequest:request
                    andSuccess:success
                    andFailure:failure];
    
}


@end
