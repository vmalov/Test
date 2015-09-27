//
//  NSString+VM.m
//  TestApp
//
//  Created by vmalov on 26.09.15.
//  Copyright © 2015 vmalov. All rights reserved.
//

#import "NSString+VM.h"

@implementation NSString (VM)
-(NSURL *)URLPath{
    return [NSURL URLWithString:self];
}
@end
