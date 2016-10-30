//
//  InputValidator.m
//  TheHunt
//
//  Created by I.M.A.C on 2015/8/7.
//  Copyright (c) 2015年 HW. All rights reserved.
//

#import "InputValidator.h"

@implementation InputValidator
- (BOOL) validateInput:(UITextField *)textFiled error:(NSError **)error {
    if (error) {
        *error = nil;
    }
    return NO;
}
@end
