//
//  UIView+Helper.m
//  TheHunt
//
//  Created by I.M.A.C on 2015/8/21.
//  Copyright (c) 2015年 HW. All rights reserved.
//

#import "UIView+Helper.h"

@implementation UIView (Helper)
- (void)removeAllSubviews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}
@end
