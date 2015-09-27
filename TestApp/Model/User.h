//
//  User.h
//  TestApp
//
//  Created by vmalov on 26.09.15.
//  Copyright © 2015 vmalov. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "TypeDefs.h"

@interface User : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSString *avatar_url;


+(void)requestUsersSince:(NSUInteger)since
             withSuccess:(ArrayBlock)success
              andFailure:(FailureBlock)failure;

@end

