//
//  MutipleColorView.h
//  HacktonProject
//
//  Created by I.M.A.C on 2015/11/14.
//  Copyright © 2015年 I.M.A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OBShapedButton.h"

@interface MutipleColorView : UIView
@property (nonatomic) BOOL isOpen;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yelloHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *greenHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *purpleHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yelloTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *greenTopConstraint;
@property (weak, nonatomic) IBOutlet OBShapedButton *blueButton;
@property (weak, nonatomic) IBOutlet OBShapedButton *redButton;
@property (weak, nonatomic) IBOutlet OBShapedButton *yelloButton;
@property (weak, nonatomic) IBOutlet OBShapedButton *purpleButton;
@property (weak, nonatomic) IBOutlet OBShapedButton *greenButton;
@end
