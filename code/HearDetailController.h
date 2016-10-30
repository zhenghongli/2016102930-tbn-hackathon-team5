//
//  HearDetailController.h
//  hackathon
//
//  Created by 陳泓諺 on 2015/11/15.
//  Copyright © 2015年 陳泓諺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class HearDetailView;

@interface HearDetailController : UIViewController

@property (nonatomic ,strong) HearDetailView *hearDetailView;
@property (nonatomic, strong) NSString *imageString;
@end
