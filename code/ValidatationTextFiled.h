//
//  ValidatationTextFiled.h
//  TheHunt
//
//  Created by I.M.A.C on 2015/8/7.
//  Copyright (c) 2015年 HW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InputValidator;
@interface ValidatationTextFiled : UITextField
@property (nonatomic, strong) InputValidator *validator;
- (BOOL)validate;
@end
