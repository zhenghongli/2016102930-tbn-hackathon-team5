//
//  HTTPStatusCode.m
//  TheHunt
//
//  Created by nutc on 8/4/15.
//  Copyright (c) 2015 HW. All rights reserved.
//

#import "HTTPStatusCode.h"

@implementation HTTPStatusCode

+ (NSString *)getErrorMessageWithErrorCode:(NSInteger)errorCode {
    switch (errorCode) {
        case 0: {
            return @"成功";
            break;
        }
        case 1: {
            return @"輸入參數不滿足";
            break;
        }
        case 11: {
            return @"輸入參數Type類型不對";
            break;
        }
        case 2: {
            return @"失敗";
            break;
        }
        case 21: {
            return @"相片錯誤";
            break;
        }
        case 22: {
            return @"token錯誤";
            break;
        }
        case 3: {
            return @"使用者認證錯誤";
            break;
        }
        case 31: {
            return @"已有此使用者";
            break;
        }
        case 33: {
            return @"帳號密碼錯誤";
            break;
        }
        default: {
            return @"未知錯誤";
            break;
        }
    }
}

@end
