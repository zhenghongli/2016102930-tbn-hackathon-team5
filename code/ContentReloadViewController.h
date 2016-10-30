//
//  ContentReloadViewController.h
//  TheHunt
//
//  Created by I.M.A.C on 2015/8/5.
//  Copyright (c) 2015年 HW. All rights reserved.
//

#import "ContentViewController.h"
#import "CarbonSwipeRefresh.h"

@interface ContentReloadViewController : ContentViewController
@property (nonatomic, strong) CarbonSwipeRefresh *refresh;
- (id)initWithType:(NSInteger)type productType:(NSInteger)productType searchId:(NSString *)searchId columsCount:(NSInteger)count;
@end
