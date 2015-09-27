//
//  UsersTableView.m
//  TestApp
//
//  Created by vmalov on 26.09.15.
//  Copyright © 2015 vmalov. All rights reserved.
//

#import "UsersTableView.h"
#import "UserTableViewCell.h"
#import "User.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>
@interface UsersTableView () <UITableViewDelegate,UITableViewDataSource>{
    UIRefreshControl *bRefreshControl;
}

@end

@implementation UsersTableView

-(void)awakeFromNib{
    self.delegate = self;
    self.dataSource = self;
    self.allowsSelection = NO;
    
    
    bRefreshControl = [UIRefreshControl new];
    bRefreshControl.triggerVerticalOffset = 100.;
    [bRefreshControl addTarget:self
                        action:@selector(nextUsers)
                   forControlEvents:UIControlEventValueChanged];
    self.bottomRefreshControl = bRefreshControl;
    
}
#pragma mark - Custom Methods
-(void)setTableAlpha:(CGFloat)alpha{
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:alpha];
    }];
}

-(void)nextUsers{
    if ([self.dlgt respondsToSelector:@selector(needLoadNextUsers:oldCountUsers:)]) {
        [self.dlgt needLoadNextUsers:self oldCountUsers:self.users.count];
    }
}

-(void)flushData{
    _users = nil;
    [self reloadData];
    [self setTableAlpha:0.0];
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.users.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
    [cell setUser:self.users[indexPath.row]];
    [cell checkerwithRow:indexPath.row];
    
    return cell;
}


-(void)inserRowsWithUsersCount:(NSUInteger)usersCount andNewUsersCount:(NSUInteger)newUsersCount{
    NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
    
    for (NSInteger i = usersCount; i < usersCount + newUsersCount; i++) {
        [insertIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    [self beginUpdates];
    [self insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationRight];
    [self endUpdates];

    [bRefreshControl endRefreshing];
}

#pragma mark - setters
-(void)setUsers:(NSArray *)users{
    NSUInteger usersCount = _users.count;
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    [mArray addObjectsFromArray:_users];
    [mArray addObjectsFromArray:users];
    
    _users = [NSArray arrayWithArray:mArray];
    if (!mArray.count) {
        [self setTableAlpha:0.0f];
    }
    else{
        [self setTableAlpha:1.0f];
    }
    [self inserRowsWithUsersCount:usersCount andNewUsersCount:users.count];
}

@end
