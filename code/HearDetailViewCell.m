//
//  HearDetailViewCell.m
//  hackathon
//
//  Created by 陳泓諺 on 2015/11/15.
//  Copyright © 2015年 陳泓諺. All rights reserved.
//

#import "HearDetailViewCell.h"
#import "UIColor+Decoder.h"

@implementation HearDetailViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , CGRectGetWidth(self.frame), 2)];
        self.line.backgroundColor =[UIColor colorWithHexString:@"#D8D8D8"];
        [self addSubview:self.line];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.line.frame) + 25, CGRectGetMinY(self.line.frame) + 5, CGRectGetWidth(self.frame) , 30)];
        self.dateLabel.textColor = [UIColor colorWithHexString:@"#3A2D32"];
        self.dateLabel.text = @"Date   2015-11-15  10:02";
        self.dateLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:self.dateLabel];
        
        self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.line.frame) + 25, CGRectGetMaxY(self.dateLabel.frame), CGRectGetWidth(self.frame) , 30)];
        self.locationLabel.textColor = [UIColor colorWithHexString:@"#3A2D32"];
        self.locationLabel.text = @"Location";
        self.locationLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:self.locationLabel];
        
        self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.locationLabel.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 120)];
        self.mapView.mapType = MKMapTypeStandard;
        self.mapView.showsUserLocation = YES;
        self.mapView.scrollEnabled = YES;
        self.mapView.zoomEnabled = YES;
        [self addSubview:self.mapView];
        
        self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.line.frame) + 25, CGRectGetMaxY(self.mapView.frame) + 10, CGRectGetWidth(self.frame) * 0.3, 30)];
        self.distanceLabel.textColor = [UIColor colorWithHexString:@"#3A2D32"];
        self.distanceLabel.text = @"Distance";
        self.distanceLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:self.distanceLabel];
        
        self.distanceValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.distanceLabel.frame) ,  CGRectGetMaxY(self.mapView.frame) + 10, CGRectGetWidth(self.frame) * 0.35, 30)];
        self.distanceValueLabel.textColor = [UIColor colorWithHexString:@"#F56967"];
        self.distanceValueLabel.text = @"3m";
        self.distanceValueLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:self.distanceValueLabel];

        
    }
    return self;
}

@end
