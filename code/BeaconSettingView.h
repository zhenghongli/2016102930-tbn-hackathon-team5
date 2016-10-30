//
//  BeaconSettingView.h
//  HealthBankBook
//
//  Created by Francis on 2015/10/23.
//  Copyright © 2015年 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeaconSettingView : UIView

@property (nonatomic, strong) UIView *beaconSelectionView;
@property (nonatomic, strong) UILabel *selectTitleLabel;
@property (nonatomic, strong) UIButton *refreshButton;
@property (nonatomic, strong) UITableView *beaconListView;
@property (nonatomic, strong) UIButton *enterButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end
