//
//  UserInfo.h
//  TheHunt
//
//  Created by nutc on 8/4/15.
//  Copyright (c) 2015 HW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, readonly) NSString *uId;
@property (nonatomic, readonly) NSString *account;
@property (nonatomic, strong) NSString *password;

+ (UserInfo *)shareInstance;
- (void)setUserDic:(NSDictionary *)userDic;
- (void)resetUser;
@end
