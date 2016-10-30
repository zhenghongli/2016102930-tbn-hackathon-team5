//
//  UserInfo.m
//  TheHunt
//
//  Created by nutc on 8/4/15.
//  Copyright (c) 2015 HW. All rights reserved.
//
#import "HTTPClient.h"

#import "UserInfo.h"

@implementation UserInfo

+ (UserInfo *)shareInstance {
    static UserInfo *sharedUserInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUserInfo = [[UserInfo alloc] init];
        [sharedUserInfo loadUserData];
    });
    return sharedUserInfo;
}

- (void)loadUserData {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    _uId = [userDefault objectForKey:@"UID"];
    _account = [userDefault objectForKey:@"Account"];
    _password = [userDefault objectForKey:@"Password"];
    NSLog(@"Token: %@", _account);
    NSLog(@"UId: %@", _uId);
    
}


- (void)setUserDic:(NSDictionary *)userDic {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    _uId = (NSString *)userDic[@"UID"];
    _account = (NSString *)userDic[@"Account"];
    _password = (NSString *)userDic[@"Password"];
    [userDefault setObject:_uId forKey:@"UID"];
    [userDefault setObject:_account forKey:@"Account"];
    [userDefault setObject:_password forKey:@"Password"];
    [userDefault synchronize];
}

- (void)resetUser {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:@"UID"];
    [userDefault removeObjectForKey:@"Account"];
    [userDefault removeObjectForKey:@"Password"];
    [userDefault synchronize];
}

@end
