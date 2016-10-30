//
//  BeaconSettingView.m
//  HealthBankBook
//
//  Created by Francis on 2015/10/23.
//  Copyright © 2015年 Francis. All rights reserved.
//

#import "BeaconSettingView.h"
#import "UIColor+CustomColor.h"

@interface BeaconSettingView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *topLineView;

@end

@implementation BeaconSettingView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        self.backgroundView.alpha = 0.5;
        [self addSubview:self.backgroundView];
        
        self.beaconSelectionView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.frame) - 100, CGRectGetMidY(self.frame) - 100, 200, 300)];
        self.beaconSelectionView.layer.cornerRadius = 5.0;
        self.beaconSelectionView.backgroundColor = [UIColor loginViewBackgroundColor];
        self.beaconSelectionView.layer.borderWidth = 2.0;
        self.beaconSelectionView.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:self.beaconSelectionView];
        
        self.enterButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.beaconSelectionView.frame) - 75, CGRectGetMaxY(self.beaconSelectionView.frame) - 50, 60, 40)];
        [self.enterButton setTitle:@"配對" forState:UIControlStateNormal];
        self.enterButton.backgroundColor = [UIColor contentBackgroundColor];
        self.enterButton.layer.cornerRadius = 5.0;
        self.enterButton.layer.borderColor = [UIColor whiteColor].CGColor;
        self.enterButton.layer.borderWidth = 2.0;
        [self addSubview:self.enterButton];
        
        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.beaconSelectionView.frame) + 15, CGRectGetMaxY(self.beaconSelectionView.frame) - 50, 60, 40)];
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        self.cancelButton.backgroundColor = [UIColor contentBackgroundColor];
        self.cancelButton.layer.cornerRadius = 5.0;
        self.cancelButton.layer.borderColor = [UIColor whiteColor].CGColor;
        self.cancelButton.layer.borderWidth = 2.0;
        [self.cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancelButton];
        
        self.selectTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, 50)];
        self.selectTitleLabel.textColor = [UIColor whiteColor];
        self.selectTitleLabel.font = [UIFont fontWithName:@"Ayuthaya" size:16];
        [self.beaconSelectionView addSubview:self.selectTitleLabel];
        
        self.topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 200, 2)];
        self.topLineView.backgroundColor = [UIColor whiteColor];
        [self.beaconSelectionView addSubview:self.topLineView];
        
        self.refreshButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.beaconSelectionView.frame) - 50, CGRectGetMinY(self.beaconSelectionView.frame) + 10, 30, 30)];
        [self.refreshButton addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
        [self.refreshButton setBackgroundImage:[UIImage imageNamed:@"SettingRefreshImage"] forState:UIControlStateNormal];
        [self addSubview:self.refreshButton];
        
        self.beaconListView = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.topLineView.frame), CGRectGetMaxY(self.selectTitleLabel.frame), CGRectGetWidth(self.topLineView.frame), 180)];
        self.beaconListView.backgroundColor = [UIColor clearColor];
        self.beaconListView.tag = 6;
        self.beaconListView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.beaconSelectionView addSubview:self.beaconListView];
        
        
    }
    return self;
}

- (void) refreshAction {
    [self.beaconListView reloadData];
}

- (void) cancelAction {
    [self removeFromSuperview];
}

@end
