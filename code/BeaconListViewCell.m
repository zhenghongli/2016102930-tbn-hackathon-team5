//
//  BeaconListViewCell.m
//  HealthBankBook
//
//  Created by Francis on 2015/10/23.
//  Copyright © 2015年 Francis. All rights reserved.
//

#import "BeaconListViewCell.h"

@interface BeaconListViewCell ()

@property (nonatomic, strong) UIView *districtView;

@end

@implementation BeaconListViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, CGRectGetWidth(self.frame), 35)];
        self.selectedView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.selectedView];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.districtView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame) - 2, CGRectGetWidth(self.frame), 2)];
        self.districtView.backgroundColor = [UIColor blackColor];
        self.districtView.alpha = 0.7;
        [self addSubview:self.districtView];
        
        self.beaconNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, CGRectGetWidth(self.frame) - 40, 48)];
        self.beaconNameLabel.textColor = [UIColor whiteColor];
        self.beaconNameLabel.backgroundColor = [UIColor clearColor];
        self.beaconNameLabel.font = [UIFont fontWithName:@"Ayuthaya" size:16];
        [self addSubview:self.beaconNameLabel];
        
    }
    return self;
}

@end
