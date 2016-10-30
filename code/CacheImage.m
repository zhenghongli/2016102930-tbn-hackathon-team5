//
//  CacheImage.m
//  TheHunt
//
//  Created by nutc on 8/19/15.
//  Copyright (c) 2015 HW. All rights reserved.
//

#import "CacheImage.h"
#import "NSString+Hashes.h"
@import ImageIO;

@implementation CacheImage

+ (void)loadImageWithImageUrl:(NSString *)imageUrl type:(NSString *)type image:(void (^)(UIImage *image))image {
//    NSLog(@"%@", imageUrl);
    dispatch_queue_t defualt = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSString *cachedFolderPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(defualt, ^{
        if (![[NSFileManager defaultManager] fileExistsAtPath:[cachedFolderPath stringByAppendingPathComponent:[imageUrl.sha1 stringByAppendingString:type]]]) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            NSString *cachedImagePath = [cachedFolderPath stringByAppendingPathComponent:[imageUrl.sha1 stringByAppendingString:type]];
            [data writeToFile:cachedImagePath atomically:YES];
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, defualt,^{
        if ([[NSFileManager defaultManager] fileExistsAtPath:[cachedFolderPath stringByAppendingPathComponent:[imageUrl.sha1 stringByAppendingString:type]]]) {
            NSString *cachedImagePath = [cachedFolderPath stringByAppendingPathComponent:[imageUrl.sha1 stringByAppendingString:type]];
            NSData *data = [NSData dataWithContentsOfFile:cachedImagePath];
            NSLog(@"%d", data.length);
            if (image) {
//                image([UIImage imageWithData:data]);
                NSURL *imageURL = [NSURL fileURLWithPath:cachedImagePath];
                NSDictionary *options = @{(__bridge id) kCGImageSourceShouldCache: @YES};
                CGImageSourceRef source = CGImageSourceCreateWithURL((__bridge CFURLRef)imageURL, NULL);
                CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, 0, (__bridge CFDictionaryRef)options);
                UIImage *cimage = [UIImage imageWithCGImage:imageRef];
                image(cimage);
                
                CGImageRelease(imageRef);
                CFRelease(source);
            }
        }
    });
}

+ (void)removeHeaderFile {
    NSFileManager  *manager = [NSFileManager defaultManager];
    NSString *cachedFolderPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    // grab all the files in the documents dir
    NSArray *allFiles = [manager contentsOfDirectoryAtPath:cachedFolderPath error:nil];
    
    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '_header'"];
    NSArray *headerFiles = [allFiles filteredArrayUsingPredicate:fltr];
    
    // use fast enumeration to iterate the array and delete the files
    for (NSString *headerFile in headerFiles)
    {
        NSError *error = nil;
        [manager removeItemAtPath:[cachedFolderPath stringByAppendingPathComponent:headerFile] error:&error];
        NSAssert(!error, @"Assertion: header file deletion shall never throw an error.");
    }
    
}

@end
