//
//  UserTableViewCell.m
//  TestApp
//
//  Created by vmalov on 26.09.15.
//  Copyright © 2015 vmalov. All rights reserved.
//

#import "UserTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+VM.h"
#import "UIImageView+VM.h"
#import <QuartzCore/QuartzCore.h>
#import "User.h"
@implementation UserTableViewCell

-(void)checkerwithRow:(NSInteger)row{
    if (row%2) {
        [self setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:0.95]];
    }
    else{
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}

-(void)setImagewithAnimation:(UIImage *)image{
    
    [UIView transitionWithView:self.avatarImageView
                      duration:0.1f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.avatarImageView setImage:image];
                    } completion:NULL];
}

-(void)setUser:(User *)user{
    [self.loginLabel setText:user.login];
    [self.avatarImageView radialImageView];
    [self.avatarImageView sd_setImageWithURL:user.avatar_url.URLPath
                            placeholderImage:[UIImage imageNamed:@"placeholder"]
                                     options:SDWebImageAvoidAutoSetImage
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                       [self setImagewithAnimation:image];
                                   }];
    
}
@end
