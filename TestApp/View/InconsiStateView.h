//
//  InconsiStateView.h
//  TestApp
//
//  Created by vmalov on 27.09.15.
//  Copyright © 2015 vmalov. All rights reserved.
//

#import <UIKit/UIKit.h>


extern NSString *const  ViewStateDidTappedReloadButtonNotification;


typedef NS_ENUM(NSUInteger, ViewState) {
    StateNoData,
    StateLoading,
};

@interface InconsiStateView : UIView

@property (nonatomic) ViewState state;
@end
