//
//  UIImageView+VM.m
//  TestApp
//
//  Created by vmalov on 26.09.15.
//  Copyright © 2015 vmalov. All rights reserved.
//

#import "UIImageView+VM.h"

@implementation UIImageView (VM)
-(void)radialImageView{
    self.layer.cornerRadius = self.frame.size.height/2.0f;
    self.layer.masksToBounds = YES;
}
@end
