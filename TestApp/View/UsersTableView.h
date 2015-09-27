//
//  UsersTableView.h
//  TestApp
//
//  Created by vmalov on 26.09.15.
//  Copyright © 2015 vmalov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UsersTableView;
@class User;
@protocol UsersTableViewDelegate <NSObject>
@required
-(void)needLoadNextUsers:(UsersTableView *)sender oldCountUsers:(NSUInteger)count;
@end


@interface UsersTableView : UITableView
@property (nonatomic, weak) id <UsersTableViewDelegate>dlgt;
@property (nonatomic,strong) NSArray <User *> *users;
-(void)setTableAlpha:(CGFloat)alpha;
-(void)flushData;
@end
