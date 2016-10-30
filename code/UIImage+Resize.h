//
//  UIImage+Resize.h
//  CHunt
//
//  Created by I.M.A.C on 2015/6/29.
//  Copyright (c) 2015年 I.M.A.C. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
- (UIImage*)scaleToSize:(CGSize)size;
@end
