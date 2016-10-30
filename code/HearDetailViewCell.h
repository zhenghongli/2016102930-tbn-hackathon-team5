//
//  HearDetailViewCell.h
//  hackathon
//
//  Created by 陳泓諺 on 2015/11/15.
//  Copyright © 2015年 陳泓諺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface HearDetailViewCell : UICollectionViewCell


@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic ,strong) MKMapView *mapView;
@property (nonatomic ,strong) MKPointAnnotation *point;
@property (nonatomic, strong) UILabel * distanceLabel;
@property (nonatomic, strong) UILabel * distanceValueLabel;

@end
