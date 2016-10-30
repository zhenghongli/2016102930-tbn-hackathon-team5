//
//  UIImage+Cache.m
//  QNAP
//
//  Created by I.M.A.C on 2015/7/15.
//  Copyright (c) 2015年 HW. All rights reserved.
//

#import "UIImage+Cache.h"

@implementation UIImage (Cache)
static NSCache *imgaeCache;

+ (void) addImageWithPath:(NSString *)imageURL image:(UIImage *)image{
    [imgaeCache setObject:image forKey:imageURL];
}

+ (UIImage *)getChacheImage:(NSString *)imageURL {
    UIImage *image = [imgaeCache objectForKey:imageURL];
    if (!image) {
        return nil;
//        image = [UIImage imageWithContentsOfFile:imageURL];
//        CGFloat factor = CGRectGetWidth([UIScreen mainScreen].bounds)/ 2.0 / image.size.width;
//        
//        UIImage *resizeImage = [image imageByScalingAndCroppingForSize:CGSizeMake(image.size.width * factor, image.size.height * factor)];
//        [imgaeCache setObject:resizeImage forKey:imageURL];
//        return resizeImage;
    }
    return image;
}


// 壓縮圖片
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    UIGraphicsEndImageContext();
    return newImage;
}

__attribute__((constructor))
static void init_imageCache() {
    imgaeCache = [[NSCache alloc] init];
}

@end
