//
//  APIManager.h
//  TestApp
//
//  Created by vmalov on 26.09.15.
//  Copyright © 2015 vmalov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeDefs.h"

static NSString *const  kServerAddress = @"https://api.github.com/";

#define endpointUsers(x) [NSString stringWithFormat:@"users?since=%lu",(unsigned long)since];

@interface APIWrapper : NSObject

+ (instancetype)instance;

-(void)GETMethod:(NSString *)URL
   withParametrs:(NSString *)parameters
      andSuccess:(objectBlock)success
      andFailure:(FailureBlock)failure;

@end
