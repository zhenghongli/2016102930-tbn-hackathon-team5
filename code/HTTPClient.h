//
//  HTTPClient.h
//  TheHunt
//
//  Created by nutc on 8/4/15.
//  Copyright (c) 2015 HW. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface HTTPClient : AFHTTPSessionManager

+ (HTTPClient *)shareInstance;
- (void)loginWithAccount:(NSString *)account password:(NSString *)password success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure;

- (void)registerWithAccount:(NSString *)account password:(NSString *)password success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure;

- (void)uploadProfile:(NSDictionary *)dic success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure;

- (void)uploadArticleWithDic:(NSDictionary *)dic images:(NSArray *)images success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure ;

- (void)productListWithType:(NSString *)type success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure;

//- (void)loginFBWithFBEmail:(NSString *)email fbId:(NSString *)fbId phone:(NSString *)phone brithday:(NSString *)birthday name:(NSString *)name gender:(NSString *)gender imageURL:(NSString *)imageURL deviceToken:(NSString *)deviceToken device:(NSString *)device success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure;
//- (void)checkAccount:(NSString *)account token:(NSString *)token success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure;
//
//- (void)createArticleWithToken:(NSString *)token uId:(NSString *)uId shortTitle:(NSString *)shortTitle deInfo:(NSString *)deInfo tags:(NSArray *)tags num:(NSString *)num vaildHour:(NSString *)vaildHour price:(NSString *)price type:(NSString *)type success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure;
//
//- (void)uploadImagesWithPid:(NSString *)pId token:(NSString *)token uId:(NSString *)uId images:(NSArray *)images success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure;
//
//
//- (void)like:(NSString *)uid token:(NSString *)token pid:(NSString *)pid success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure ;
//
//- (void)listWithUID:(NSString *)uid token:(NSString *)token type:(NSInteger)type productType:(NSInteger)productType searchID:(NSString *)searchId time:(NSString *)time page:(NSInteger)page orderType:(NSInteger)orderType success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure ;
//
//- (void)listDetialWithId:(NSString *)uid token:(NSString *)token pid:(NSString *)pid type:(NSString *)type success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure ;
//
//- (void)vote:(NSString *)uid token:(NSString *)token pid:(NSString *)pid option:(NSInteger)option success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure ;
//
//- (void)message:(NSString *)uid token:(NSString *)token pid:(NSString *)pid time:(NSString *)time pageY:(NSInteger)pageY success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure ;
//
//- (void)createMessageWithUID:(NSString *)uid token:(NSString *)token pid:(NSString *)pid time:(NSString *)time message:(NSString *)message isPrivate:(BOOL)isPrivate success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure ;
//
//- (void)replyMessageWithUID:(NSString *)uid token:(NSString *)token mmid:(NSString *)mmid time:(NSString *)time pageY:(NSInteger)pageY success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure ;
//
//- (void)userProfileWithId:(NSString *)identifier success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure;
//
//- (void)searchTag:(NSString *)tag success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure ;
//
//- (void)followListWithId:(NSString *)identifier pageY:(NSInteger)count time:(NSString *)time success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure ;
//
//- (void)beFollowListWithId:(NSString *)identifier pageY:(NSInteger)count time:(NSString *)time success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure ;
//
//- (void)followUser:(NSString *)account token:(NSString *)token myId:(NSString *)identifier  success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure ;
//
//- (void)userProfileInfo:(NSString *)uid success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure;
//
//- (void)userProfileUpdateWithUserId:(NSString *)uId token:(NSString *)token userInfo:(NSDictionary *)userInfos  success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure ;
//
//- (void)userProfileImageUpdateWithUserId:(NSString *)uId token:(NSString *)token image:(UIImage *)image success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure ;
//
//- (void)getHotTagsWithPageX:(NSString *)pageX pageY:(NSString *)pageY success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure;
//
//- (void)getWeekTagsWithPageX:(NSString *)pageX pageY:(NSString *)pageY success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure ;

@end
