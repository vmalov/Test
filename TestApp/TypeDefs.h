//
//  TypeDefs.h
//  TestApp
//
//  Created by vmalov on 26.09.15.
//  Copyright © 2015 vmalov. All rights reserved.
//

#ifndef TypeDefs_h
#define TypeDefs_h


typedef void (^objectBlock)(id result);
typedef void (^ArrayBlock)(NSArray *result);
typedef void (^DictionaryBlock)(NSDictionary *result);
typedef void (^FailureBlock)(NSDictionary *errorDict);

#endif /* TypeDefs_h */
