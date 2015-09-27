//
//  User.m
//  TestApp
//
//  Created by vmalov on 26.09.15.
//  Copyright © 2015 vmalov. All rights reserved.
//

#import "User.h"
#import "APIWrapper.h"
@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        self.id = [dictionary[@"id"] integerValue];
        dictionary[@"avatar_url"] ? [self setAvatar_url:dictionary[@"avatar_url"]]:@"";
        dictionary[@"login"] ? [self setLogin:dictionary[@"login"]]:@"";
    }
    return self;
}

#pragma mark - API

+(NSArray*)parseUsersArray:(NSArray *)array{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in array) {
        User *user = [[User alloc] initWithDictionary:dict];
        [result addObject:user];
    }
    return [NSArray arrayWithArray:result];
}




+(void)requestUsersSince:(NSUInteger)since
             withSuccess:(ArrayBlock)success
              andFailure:(FailureBlock)failure{
    [NSString stringWithFormat:@"%lu",(unsigned long)since];
    NSString *url = endpointUsers(since);
    [[APIWrapper instance] GETMethod:url
                       withParametrs:nil
                          andSuccess:^(id result) {
                              if ([result isKindOfClass:[NSArray class]]) {
                                  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                     NSArray *array = [self parseUsersArray:result];
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          success(array);
                                      });
                                  });
                              }
                              else{
                                  failure(@{});
                              }
                          } andFailure:^(NSDictionary *errorDict) {
                              failure(errorDict);
                          }];
}

@end
