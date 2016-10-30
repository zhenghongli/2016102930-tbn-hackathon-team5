//
//  ValidatationTextFiled.m
//  TheHunt
//
//  Created by I.M.A.C on 2015/8/7.
//  Copyright (c) 2015年 HW. All rights reserved.
//

#import "ValidatationTextFiled.h"
#import "InputValidator.h"

@interface ValidatationTextFiled ()
@end

@implementation ValidatationTextFiled
- (BOOL) validate {
    NSError *error = nil;
    BOOL validationResult = [self.validator validateInput:self error:&error];
    if (!validationResult) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error localizedDescription] message:[error localizedFailureReason] delegate:nil cancelButtonTitle:@"Yes" otherButtonTitles: nil];
        [alertView show];
    }
    return validationResult;
}
@end
