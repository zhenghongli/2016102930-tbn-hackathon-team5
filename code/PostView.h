//
//  PostView.h
//  Post
//
//  Created by nutc on 2015/11/14.
//  Copyright © 2015年 HW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostView : UIView

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end
