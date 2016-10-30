//
//  InputValidator.h
//  TheHunt
//
//  Created by I.M.A.C on 2015/8/7.
//  Copyright (c) 2015年 HW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InputValidator : NSObject
- (BOOL) validateInput:(UITextField *)textFiled error:(NSError **)error;
@end
