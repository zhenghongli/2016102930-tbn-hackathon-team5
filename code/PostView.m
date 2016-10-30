//
//  PostView.m
//  Post
//
//  Created by nutc on 2015/11/14.
//  Copyright © 2015年 HW. All rights reserved.
//

#import "PostView.h"

@interface PostView()

@property (nonatomic, weak) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeightConstraint;

@end

@implementation PostView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headerHeightConstraint.constant = CGRectGetHeight([UIScreen mainScreen].bounds) * 0.25f;
    self.shadowView.backgroundColor = [UIColor whiteColor];
    self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, 1);
    self.shadowView.layer.shadowRadius = 1;
    self.shadowView.layer.shadowOpacity = 0.5;
}

@end
