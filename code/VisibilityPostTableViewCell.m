//
//  GenderPostTableViewCell.m
//  Post
//
//  Created by nutc on 2015/11/15.
//  Copyright © 2015年 HW. All rights reserved.
//

#import "VisibilityPostTableViewCell.h"

@implementation VisibilityPostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView addSubview:self.yesButton];
    [self.contentView addSubview:self.noButton];
    [self.yesButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.noButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonAction:(UIButton *)button {
    self.currentSelectedIndex = button.tag;
    if (button.tag == 0) {
        [self.yesButton setBackgroundImage:[UIImage imageNamed:@"Oval43"] forState:UIControlStateNormal];
        [self.noButton setBackgroundImage:[UIImage imageNamed:@"Oval41"] forState:UIControlStateNormal];
    } else {
        [self.yesButton setBackgroundImage:[UIImage imageNamed:@"Oval41"] forState:UIControlStateNormal];
        [self.noButton setBackgroundImage:[UIImage imageNamed:@"Oval43"] forState:UIControlStateNormal];
    }
    NSLog(@"%d", (int)button.tag);
}

@end
