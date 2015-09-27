//
//  UserTableViewCell.h
//  TestApp
//
//  Created by vmalov on 26.09.15.
//  Copyright © 2015 vmalov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;

@interface UserTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (nonatomic,retain) User *user;
-(void)checkerwithRow:(NSInteger)row;
@end
