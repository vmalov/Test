//
//  NSURLResponse+VM.m
//  TestApp
//
//  Created by vmalov on 26.09.15.
//  Copyright © 2015 vmalov. All rights reserved.
//

#import "NSURLResponse+VM.h"

@implementation NSURLResponse (VM)
-(NSUInteger)statusCode{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)self;
    return httpResponse.statusCode;
}
@end
