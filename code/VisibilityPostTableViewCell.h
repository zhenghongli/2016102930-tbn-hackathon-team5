//
//  GenderPostTableViewCell.h
//  Post
//
//  Created by nutc on 2015/11/15.
//  Copyright © 2015年 HW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisibilityPostTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (nonatomic) NSInteger  currentSelectedIndex;
@property (nonatomic, weak) IBOutlet UIButton *noButton;

@end
