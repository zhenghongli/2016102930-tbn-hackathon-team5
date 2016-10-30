//
//  ContentReloadViewController.m
//  TheHunt
//
//  Created by I.M.A.C on 2015/8/5.
//  Copyright (c) 2015年 HW. All rights reserved.
//

#import "ContentReloadViewController.h"


@interface ContentReloadViewController ()
{
    
}
@property (nonatomic, strong) UILabel *remindLabel;
@end


@implementation ContentReloadViewController

- (id)init {
    self = [super init];
    if (self) {
        self.refresh = [[CarbonSwipeRefresh alloc] initWithScrollView:self.collectionView];
        [self.refresh setColors:@[[UIColor blueColor], [UIColor redColor], [UIColor orangeColor], [UIColor greenColor]]];
        [self.view addSubview:self.refresh];
        [self.refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];

    }
    return self;
}

- (id)initWithType:(NSInteger)type productType:(NSInteger)productType searchId:(NSString *)searchId columsCount:(NSInteger)count{
    self = [super init];
    if (self) {
        self.productType = productType;
        self.searchId = searchId;
        self.type = type;
        self.data = [[NSMutableArray alloc] init];
        self.columsCount = count;
        [self.view addSubview:self.collectionView];
        self.refresh = [[CarbonSwipeRefresh alloc] initWithScrollView:self.collectionView];
        [self.refresh setMarginTop:0];
        [self.refresh setColors:@[[UIColor blueColor], [UIColor redColor], [UIColor orangeColor], [UIColor greenColor]]];
        [self.view addSubview:self.refresh];
        [self.refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    typeof(self) __weak weakSelf = self;
//    [[HTTPClient shareInstance] listWithUID:[UserInfo shareInstance].uId token:[UserInfo shareInstance].token type:self.type productType:self.productType searchID:self.searchId time:@"" page:5 orderType:2 success:^(NSDictionary *response) {
//        typeof(weakSelf) __strong strongSelf = weakSelf;
//
//        NSLog(@"%@", response);
//        [strongSelf.data removeAllObjects];
//        [strongSelf.data addObjectsFromArray:[response[@"Data"] copy]];
//        if (strongSelf.data.count == 0) {
//            if (self.remindLabel) {
//                [self.remindLabel removeFromSuperview];
//                self.remindLabel.textAlignment = NSTextAlignmentCenter;
//                self.remindLabel.center = CGPointMake(self.remindLabel.center.x, CGRectGetMidY(self.collectionView.bounds));
//                self.remindLabel.text = @"無資料";
//                self.remindLabel.textColor  = [UIColor grayColor];
//                [self.collectionView addSubview:self.remindLabel];
//            } else {
//                self.remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 50)];
//                self.remindLabel.textAlignment = NSTextAlignmentCenter;
//                self.remindLabel.center = CGPointMake(self.remindLabel.center.x, CGRectGetMidY([UIScreen mainScreen].bounds));
//                self.remindLabel.text = @"無資料";
//                self.remindLabel.textColor  = [UIColor grayColor];
//                [self.collectionView addSubview:self.remindLabel];
//            }
//        } else {
//            if (self.remindLabel) {
//                [self.remindLabel removeFromSuperview];
//            }
//        }
//        [strongSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
//    } errorResponse:^(NSString *errorMessage) {
//        NSLog(@"%@", errorMessage);
//    } failure:^(NSError *error) {
//        
//    }];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    typeof(self) __weak weakSelf = self;
//    [[HTTPClient shareInstance] listWithUID:[UserInfo shareInstance].uId token:[UserInfo shareInstance].token type:self.type time:@"" page:5 orderType:2 success:^(NSDictionary *response) {
//        NSLog(@"%@", response);
//        [self.data removeAllObjects];
//        [weakSelf.data addObjectsFromArray:[response[@"Data"] copy]];
//        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
//    } errorResponse:^(NSString *errorMessage) {
//        NSLog(@"%@", errorMessage);
//    } failure:^(NSError *error) {
//        
//    }];
}

- (void)refresh:(id)sender {
    typeof(self) __weak weakSelf = self;
//    [[HTTPClient shareInstance] listWithUID:[UserInfo shareInstance].uId token:[UserInfo shareInstance].token type:self.type productType:self.productType searchID:self.searchId time:@"" page:5 orderType:2 success:^(NSDictionary *response) {
//        typeof(weakSelf) __strong strongSelf = weakSelf;
//        NSLog(@"%@", response);
//        [strongSelf.data removeAllObjects];
//        [strongSelf.data addObjectsFromArray:[response[@"Data"] copy]];
//        if (strongSelf.data.count == 0) {
//            if (self.remindLabel) {
//                [self.remindLabel removeFromSuperview];
//                self.remindLabel.textAlignment = NSTextAlignmentCenter;
//                self.remindLabel.center = CGPointMake(self.remindLabel.center.x, CGRectGetMidY([UIScreen mainScreen].bounds));
//                self.remindLabel.text = @"無資料";
//                self.remindLabel.textColor  = [UIColor grayColor];
//                [self.collectionView addSubview:self.remindLabel];
//            } else {
//                self.remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 50)];
//                self.remindLabel.textAlignment = NSTextAlignmentCenter;
//                self.remindLabel.center = CGPointMake(self.remindLabel.center.x, CGRectGetMidY([UIScreen mainScreen].bounds));
//                self.remindLabel.text = @"無資料";
//                self.remindLabel.textColor  = [UIColor grayColor];
//                [self.collectionView addSubview:self.remindLabel];
//            }
//        } else {
//            if (self.remindLabel) {
//                [self.remindLabel removeFromSuperview];
//            }
//        }
//        [strongSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
//        [strongSelf endRefreshing];
//    } errorResponse:^(NSString *errorMessage) {
//        NSLog(@"%@", errorMessage);
//        [weakSelf endRefreshing];
//    } failure:^(NSError *error) {
//        [weakSelf endRefreshing];
//    }];
}

- (void)endRefreshing {
    [self.refresh endRefreshing];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
}
@end
