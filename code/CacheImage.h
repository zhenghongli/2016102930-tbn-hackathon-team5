//
//  CacheImage.h
//  TheHunt
//
//  Created by nutc on 8/19/15.
//  Copyright (c) 2015 HW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheImage : NSObject

+ (void)loadImageWithImageUrl:(NSString *)imageUrl type:(NSString *)type image:(void (^)(UIImage *image))image;
+ (void)removeHeaderFile;

@end
