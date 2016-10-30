//
//  HTTPClient.m
//  TheHunt
//
//  Created by nutc on 8/4/15.
//  Copyright (c) 2015 HW. All rights reserved.
//
 
#import "HTTPClient.h"
#import "HTTPStatusCode.h"

static NSTimeInterval const HTTPRequestTimeout = 5;
static NSString * const HTTPServerURLString = @"http://211.23.17.100:32038";
static NSString * const HTTPLoginURLString = @"login";
static NSString * const HTTPRegisterURLString = @"register";
static NSString * const HTTPListURLString = @"findproduct";
static NSString * const HTTPUpLoadProfile = @"userinfo";
static NSString * const HTTPCheckTokenString = @"user/checktoken";
static NSString * const HTTPCreateArticleURLString = @"product";
static NSString * const HTTPUploadImagesURLString = @"product/%@/update";
static NSString * const HTTPListString = @"product";
static NSString * const HTTPLikeString = @"like/";
static NSString * const HTTPListDetailString = @"product/%@";
static NSString * const HTTPVoteString = @"vote/%@";
static NSString * const HTTPMessageString = @"message/main/%@";
static NSString * const HTTPCreateMessageString = @"message/main/%@/store";
static NSString * const HTTPReplyMessageString = @"message/reply/%@";
static NSString * const HTTPUserProfileString = @"user/profile/%@";
static NSString * const HTTPTagSearchString = @"/tag";
static NSString * const HttpFollowListString = @"/user/profile/follow/%@";
static NSString * const HttpBeFollowListString = @"/user/profile/befollow/%@";
static NSString * const HttpFollowString = @"/follow/%@";
static NSString * const HttpProfileInfoSetting = @"/user/profile_info/%@";
static NSString * const HTTPUserProfileUpdateString = @"/user/profile/detail/%@/update";
static NSString * const HTTPUserProfileImageUpdateString = @"/user/profile/image/%@/update";
static NSString * const HTTPGetHotTagsURLString = @"/tag/rank";
static NSString * const HTTPGetWeekTagsURLString = @"/tag/rank/week";


@implementation HTTPClient

+ (HTTPClient *)shareInstance {
    static HTTPClient *sharedHTTPClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHTTPClient = [[HTTPClient alloc] init];
    });
    return sharedHTTPClient;
}

- (void)uploadProfile:(NSDictionary *)dic success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure {
    [self postWithURL:HTTPUpLoadProfile parameters:dic success:^(NSDictionary *response) {
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)productListWithType:(NSString *)type success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure{
    NSDictionary *dic = @{@"UID" : [UserInfo shareInstance].uId,
                          @"Type": type};
    [self postWithURL:HTTPListURLString parameters:dic success:^(NSDictionary *response) {

            if (success) {
                success(response);
            }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (instancetype)init {
    self = [super initWithBaseURL:[NSURL URLWithString:HTTPServerURLString]];
    if (self) {
        self.requestSerializer.timeoutInterval = HTTPRequestTimeout;
        NSSet *set = [NSSet setWithArray:@[@"text/html", @"application/json"]];
        self.responseSerializer.acceptableContentTypes = set;
    }
    return self;
}

- (void)uploadArticleWithDic:(NSDictionary *)dic images:(NSArray *)images success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure {
    
    [self POST:HTTPCreateArticleURLString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i < images.count; i++) {
            UIImage *image = (UIImage *)images[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.0001);
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"Image[%d]", i] fileName:[NSString stringWithFormat:@"image%d.jpg", i] mimeType:@"image/jpeg"];
        }
    } success:^(NSURLSessionDataTask *task, NSDictionary *response) {
        response = [self handleDictionary:response];
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)loginWithAccount:(NSString *)account password:(NSString *)password success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{@"Account" : account,
                                 @"Password" : password
                                 };
    [self postWithURL:HTTPLoginURLString parameters:parameters success:^(NSDictionary *response) {
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


- (void)checkAccount:(NSString *)account token:(NSString *)token success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{@"Token": token,
                                 @"UID": account};
    [self postWithURL:HTTPCheckTokenString parameters:parameters success:^(NSDictionary *response) {
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)registerWithAccount:(NSString *)account password:(NSString *)password success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{@"Account" : account,
                                 @"Password" : password
                                 };
    
        [self postWithURL:HTTPRegisterURLString parameters:parameters success:^(NSDictionary *response) {
            NSInteger errorCode = [response[@"ErrorCode"] integerValue];
            if (errorCode == 0) {
                if (success) {
                    success(response);
                }
            }
            else {
                if (errorResponse) {
                    errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
                }
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    
}


- (void)listWithUID:(NSString *)uid token:(NSString *)token type:(NSInteger)type productType:(NSInteger)productType searchID:(NSString *)searchId time:(NSString *)time page:(NSInteger)page orderType:(NSInteger)orderType success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure {
    NSDictionary *parameters = @{@"Time" : time ? time : @"",
                                 @"PageY" : @(page),
                                 @"UID" : uid,
                                 @"Token" : token,
                                 @"SearchID": searchId,
                                 @"Type" : @(type),
                                 @"ProductType": @(productType),
                                 @"OrderType" : @(orderType)};

    [self postWithURL:HTTPListString parameters:parameters success:^(NSDictionary *response) {
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

//- (void)loginFBWithFBEmail:(NSString *)email fbId:(NSString *)fbId phone:(NSString *)phone brithday:(NSString *)birthday name:(NSString *)name gender:(NSString *)gender imageURL:(NSString *)imageURL deviceToken:(NSString *)deviceToken device:(NSString *)device success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure {
//    NSDictionary *parameters = @{@"FBEmail" : email,
//                                 @"FBID" : fbId,
//                                 @"Phone" : phone,
//                                 @"Birthday" : birthday,
//                                 @"Name" : name,
//                                 @"Gender" : gender,
//                                 @"Image" : imageURL,
//                                 @"DeviceToken" : deviceToken,
//                                 @"Device" : device};
//
//    [self postWithURL:HTTPLoginFBURLString parameters:parameters success:^(NSDictionary *response) {
//        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
//        if (errorCode == 0) {
//            if (success) {
//                success(response);
//            }
//        }
//        else {
//            if (errorResponse) {
//                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
//            }
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

- (void)createArticleWithToken:(NSString *)token uId:(NSString *)uId shortTitle:(NSString *)shortTitle deInfo:(NSString *)deInfo tags:(NSArray *)tags num:(NSString *)num vaildHour:(NSString *)vaildHour price:(NSString *)price type:(NSString *)type success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{@"Token" : token,
                                 @"UID" : uId,
                                 @"ShortTitle" : !shortTitle ? @"": shortTitle ,
                                 @"DeInfo" : deInfo,
                                 @"Tags" : tags,
                                 @"Num" : num,
                                 @"VaildHour" : vaildHour,
                                 @"Price" : price,
                                 @"Type" : type};
    
    [self postWithURL:HTTPCreateArticleURLString parameters:parameters success:^(NSDictionary *response) {
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)uploadImagesWithPid:(NSString *)pId token:(NSString *)token uId:(NSString *)uId images:(NSArray *)images success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{@"Token" : token,
                                 @"UID" : uId};
    NSString *url = [NSString stringWithFormat:HTTPUploadImagesURLString, pId];
    [self POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i < images.count; i++) {
            UIImage *image = (UIImage *)images[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.0001);
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"Image[%d]", i] fileName:[NSString stringWithFormat:@"image%d.jpg", i] mimeType:@"image/jpeg"];
        }
    } success:^(NSURLSessionDataTask *task, NSDictionary *response) {
        response = [self handleDictionary:response];
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)like:(NSString *)uid token:(NSString *)token pid:(NSString *)pid success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure {
    NSDictionary *parameters = @{@"UID" : uid,
                                 @"Token" : token};
    
    [self postWithURL:[HTTPLikeString stringByAppendingString:pid] parameters:parameters success:^(NSDictionary *response) {
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)vote:(NSString *)uid token:(NSString *)token pid:(NSString *)pid option:(NSInteger)option success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure {
    NSDictionary *parameters = @{@"UID" : uid,
                                 @"Token" : token,
                                 @"Option": @(option)};
    NSString *url = [NSString stringWithFormat:HTTPVoteString, pid];

    [self postWithURL:url   parameters:parameters success:^(NSDictionary *response) {
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)message:(NSString *)uid token:(NSString *)token pid:(NSString *)pid time:(NSString *)time pageY:(NSInteger)pageY success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure {
    NSDictionary *parameters = @{@"UID" : uid,
                                 @"Token" : token,
                                 @"Time": time,
                                 @"PageY": @(pageY)};
    
    NSString *url = [NSString stringWithFormat:HTTPMessageString, pid];
    
    [self postWithURL:url   parameters:parameters success:^(NSDictionary *response) {
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)createMessageWithUID:(NSString *)uid token:(NSString *)token pid:(NSString *)pid time:(NSString *)time message:(NSString *)message isPrivate:(BOOL)isPrivate success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure {
    NSDictionary *parameters = @{@"UID" : uid,
                                 @"Token" : token,
                                 @"Message": message,
                                 @"Private": @(isPrivate),
                                 @"Time": time};
    
    NSString *url = [NSString stringWithFormat:HTTPCreateMessageString, pid];
    
    [self postWithURL:url   parameters:parameters success:^(NSDictionary *response) {
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)replyMessageWithUID:(NSString *)uid token:(NSString *)token mmid:(NSString *)mmid time:(NSString *)time pageY:(NSInteger)pageY success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure {
    
    NSDictionary *parameters = @{@"UID" : uid,
                                 @"Token" : token,
                                 @"PageY": @(pageY),
                                 @"Time": time};
    
    NSString *url = [NSString stringWithFormat:HTTPReplyMessageString, mmid];
    
    
    [self postWithURL:url parameters:parameters success:^(NSDictionary *response) {
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}



- (void)listDetialWithId:(NSString *)uid token:(NSString *)token pid:(NSString *)pid type:(NSString *)type success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure {
    NSDictionary *parameters = @{@"UID" : uid,
                                 @"Token" : token,
                                 @"Type": type };
    
    NSString *url = [NSString stringWithFormat:HTTPListDetailString, pid];
    
    [self postWithURL:url parameters:parameters success:^(NSDictionary *response) {
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


- (void)searchTag:(NSString *)tag success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure {
    
    NSDictionary *parameters = @{@"Tag": tag};
    [self GET:HTTPTagSearchString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [self handleDictionary:responseObject];
        NSInteger errorCode = [dic[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(dic);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


- (void)userProfileWithId:(NSString *)identifier success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure {
    NSString *url = [NSString stringWithFormat:HTTPUserProfileString, identifier];
    NSDictionary *parameters = @{@"UID": [UserInfo shareInstance].uId};
    [self POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [self handleDictionary:responseObject];
        NSInteger errorCode = [dic[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(dic[@"Data"]);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)followListWithId:(NSString *)identifier pageY:(NSInteger)count time:(NSString *)time success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure {
    NSString *url = [NSString stringWithFormat:HttpFollowListString, identifier];
    NSDictionary *parameters = @{@"UID": [UserInfo shareInstance].uId,
                                 @"PageY": @(count),
                                 @"Time": time};
    [self POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [self handleDictionary:responseObject];
        NSInteger errorCode = [dic[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(dic);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)beFollowListWithId:(NSString *)identifier pageY:(NSInteger)count time:(NSString *)time success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure {
    NSString *url = [NSString stringWithFormat:HttpBeFollowListString, identifier];
    NSDictionary *parameters = @{@"UID": [UserInfo shareInstance].uId,
                                 @"PageY": @(count),
                                 @"Time": time};
    [self POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [self handleDictionary:responseObject];
        NSInteger errorCode = [dic[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(dic);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)followUser:(NSString *)account token:(NSString *)token myId:(NSString *)identifier  success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{@"Token": token,
                                 @"UID": identifier};
    NSString *url = [NSString stringWithFormat:HttpFollowString, account];

    [self postWithURL:url parameters:parameters success:^(NSDictionary *response) {
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)userProfileInfo:(NSString *)uid success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void(^)(NSError *error))failure {
    NSString *url = [NSString stringWithFormat:HttpProfileInfoSetting, uid];
    [self GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [self handleDictionary:responseObject];
        NSInteger errorCode = [dic[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(dic);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)userProfileUpdateWithUserId:(NSString *)uId token:(NSString *)token userInfo:(NSDictionary *)userInfos  success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:@{@"Token": token}];
    [parameters addEntriesFromDictionary:userInfos];
    NSString *url = [NSString stringWithFormat:HTTPUserProfileUpdateString, uId];
    
    [self postWithURL:url parameters:parameters success:^(NSDictionary *response) {
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


- (void)userProfileImageUpdateWithUserId:(NSString *)uId token:(NSString *)token image:(UIImage *)image success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{@"Token": token};
    NSString *url = [NSString stringWithFormat:HTTPUserProfileImageUpdateString, uId];

    if (!image) {
        [self postWithURL:url parameters:parameters success:^(NSDictionary *response) {
            NSInteger errorCode = [response[@"ErrorCode"] integerValue];
            if (errorCode == 0) {
                if (success) {
                    success(response);
                }
            }
            else {
                if (errorResponse) {
                    errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
                }
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
    else {
        [self POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSData *imageData = UIImageJPEGRepresentation(image, 0.8f);;
            [formData appendPartWithFileData:imageData name:@"Image" fileName:@"image.jpg" mimeType:@"image/jpeg"];
        } success:^(NSURLSessionDataTask *task, NSDictionary *response) {
            response = [self handleDictionary:response];
            NSInteger errorCode = [response[@"ErrorCode"] integerValue];
            if (errorCode == 0) {
                if (success) {
                    success(response);
                }
            }
            else {
                if (errorResponse) {
                    errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
                }
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

- (void)getHotTagsWithPageX:(NSString *)pageX pageY:(NSString *)pageY success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{@"pageX" : pageX,
                                 @"pageY" : pageY};
    [self postWithURL:HTTPGetHotTagsURLString parameters:parameters success:^(NSDictionary *response) {
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


- (void)getWeekTagsWithPageX:(NSString *)pageX pageY:(NSString *)pageY success:(void (^)(NSDictionary *response))success errorResponse:(void (^)(NSString *errorMessage))errorResponse failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{@"pageX" : pageX,
                                 @"pageY" : pageY};
    [self postWithURL:HTTPGetWeekTagsURLString parameters:parameters success:^(NSDictionary *response) {
        NSInteger errorCode = [response[@"ErrorCode"] integerValue];
        if (errorCode == 0) {
            if (success) {
                success(response);
            }
        }
        else {
            if (errorResponse) {
                errorResponse([HTTPStatusCode getErrorMessageWithErrorCode:errorCode]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)postWithURL:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(NSDictionary *response))success failure:(void (^)(NSError *error))failure {
    [self POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        responseObject = [self handleDictionary:responseObject];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (NSDictionary *)handleDictionary:(NSDictionary *)dictionary {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];
    NSString *dicString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    dicString = [dicString stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];
    NSData *data = [dicString dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

@end
