//
//  UIImage+Maker.m
//  TheHunt
//
//  Created by I.M.A.C on 2015/7/27.
//  Copyright (c) 2015年 HW. All rights reserved.
//

#import "UIImage+Maker.h"

@implementation UIImage (Maker)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 44.0f, 44.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
