//
//  UIColor+Decoder.m
//  TheHunt
//
//  Created by I.M.A.C on 2015/8/4.
//  Copyright (c) 2015年 HW. All rights reserved.
//

#import "UIColor+Decoder.h"

@implementation UIColor (Decoder)
+ (UIColor *)colorWithHexString:(NSString *)hexString {
    unsigned int hexInt = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    return [UIColor colorWithRed:((hexInt & 0xFF0000) >> 16)/255.0 green:((hexInt & 0xFF00) >> 8)/255.0 blue:(hexInt & 0xFF)/255.0 alpha:1.0f];
}
@end
