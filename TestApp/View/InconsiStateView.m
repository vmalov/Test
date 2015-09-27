//
//  InconsiStateView.m
//  TestApp
//
//  Created by vmalov on 27.09.15.
//  Copyright © 2015 vmalov. All rights reserved.
//

#import "InconsiStateView.h"

NSString *const ViewStateDidTappedReloadButtonNotification = @"ViewStateDidTappedReloadButtonNotification";

@interface InconsiStateView (){
    __weak IBOutlet UIActivityIndicatorView *activityView;
    __weak IBOutlet UILabel *stateLabel;
    
}

@end

@implementation InconsiStateView

-(IBAction)tapToReload:(UIGestureRecognizer *)recognizer{
    [self setState:StateLoading];
    [[NSNotificationCenter defaultCenter] postNotificationName:ViewStateDidTappedReloadButtonNotification
                                                        object:nil];
}

-(void)setState:(ViewState)state{
    switch (state) {
        case StateLoading:{
            [activityView startAnimating];
            [stateLabel setText:NSLocalizedString(@"Loading", nil)];
        }
            break;
        case StateNoData:
            [activityView stopAnimating];
            [stateLabel setText:NSLocalizedString(@"TapToLoad", nil)];
        default:
            break;
    }
}
@end
