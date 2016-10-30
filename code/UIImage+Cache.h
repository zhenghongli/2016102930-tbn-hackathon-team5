//
//  UIImage+Cache.h
//  QNAP
//
//  Created by I.M.A.C on 2015/7/15.
//  Copyright (c) 2015年 HW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Cache)
+ (UIImage *)getChacheImage:(NSString *)imageURL;
+ (void) addImageWithPath:(NSString *)imageURL image:(UIImage *)image;

@end
