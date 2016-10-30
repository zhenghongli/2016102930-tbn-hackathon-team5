//
//  HTTPStatusCode.h
//  TheHunt
//
//  Created by nutc on 8/4/15.
//  Copyright (c) 2015 HW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPStatusCode : NSObject

+ (NSString *)getErrorMessageWithErrorCode:(NSInteger)errorCode;

@end
