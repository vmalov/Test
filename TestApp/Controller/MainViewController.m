    //
//  ViewController.m
//  TestApp
//
//  Created by vmalov on 26.09.15.
//  Copyright © 2015 vmalov. All rights reserved.
//

#import "MainViewController.h"
#import "UsersTableView.h"
#import "User.h"
#import "MBLMessageBanner.h"
#import "InconsiStateView.h"
@interface MainViewController () <UsersTableViewDelegate,MBLMessageBannerDelegate>{
    __weak IBOutlet UsersTableView *uTV;
    __weak IBOutlet UIBarButtonItem *trashBarButton;
    __weak IBOutlet InconsiStateView *inconsistentView;
}
@end

@implementation MainViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setTitle:NSLocalizedString(@"GithubUsers", nil)];
    [uTV setDlgt:self];
    [uTV setTableAlpha:0.0];
    [self requestUsers];
    [self startListeningNotification];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [self stopListeningNotification];
}

#pragma mark - IBActions

- (IBAction)flushData:(id)sender {
    [uTV flushData];
    [inconsistentView setState:StateNoData];
    [trashBarButton setEnabled:NO];
}

#pragma mark - NSNotifications

-(void)startListeningNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(requestUsers)
                                                 name:ViewStateDidTappedReloadButtonNotification
                                               object:nil];
}

-(void)stopListeningNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - API

-(void)requestUsers{
    [inconsistentView setState:StateLoading];
    [User requestUsersSince:uTV.users.count
                withSuccess:^(NSArray *result) {
                    [uTV setUsers:result];
                    [trashBarButton setEnabled:YES];
                } andFailure:^(NSDictionary *errorDict) {
                    [self loadingFailedwithError:errorDict];
                }];
}



#pragma mark - Error Handling
-(void)loadingFailedwithError:(NSDictionary *)error{
    if (uTV.users.count) {

        [MBLMessageBanner showMessageBannerInViewController:self
                                                      title:NSLocalizedString(@"DownloadFailed", nil)
                                                   subtitle:nil
                                                      image:nil
                                                       type:MBLMessageBannerTypeWarning
                                                   duration:2.0f
                                     userDissmissedCallback:nil
                                                buttonTitle:NSLocalizedString(@"Close", nil)
                                  userPressedButtonCallback:^(MBLMessageBannerView *banner) {
                                      [self requestUsers];
                                      [MBLMessageBanner hideMessageBanner];
                                      
                                  }
                                                 atPosition:MBLMessageBannerPositionBottom
                                       canBeDismissedByUser:YES
                                                   delegate:self];
    }
    else{
        [uTV setTableAlpha:0.0f];
        [MBLMessageBanner showMessageBannerInViewController:self
                                                      title:NSLocalizedString(@"DownloadFailed", nil)
                                                   subtitle:nil
                                                      image:nil
                                                       type:MBLMessageBannerTypeError
                                                   duration:MBLMessageBannerDurationEndless
                                     userDissmissedCallback:^(MBLMessageBannerView *bannerView) {
                                         [MBLMessageBanner hideMessageBanner];
                                     }
                                                buttonTitle:NSLocalizedString(@"Repeat", nil)
                                  userPressedButtonCallback:^(MBLMessageBannerView *banner) {
                                      [self requestUsers];
                                      [MBLMessageBanner hideMessageBanner];
                                      
                                  }
                                                 atPosition:MBLMessageBannerPositionTop
                                       canBeDismissedByUser:YES
                                                   delegate:nil];
    }
}

#pragma mark - UsersTableView delegate
-(void)needLoadNextUsers:(UsersTableView *)sender oldCountUsers:(NSUInteger)count{
    [self requestUsers];
}
#pragma mark - MBLMessageBanner delegate
-(void)messageBannerViewDidDisappear:(MBLMessageBannerView *)messageBanner{
    [uTV setUsers:@[]];
}

@end
