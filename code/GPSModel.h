//
//  GPSModel.h
//  GPSModel
//
//  Created by Francis on 2015/3/11.
//  Copyright (c) 2015年 Francis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>

@interface GPSModel : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) NSArray *beaconArray;

+ (GPSModel*) shareInstance;

- (void) createBeaconRegion;
- (void) locationStartUpdate;
- (void) locationStopUpdate;
- (void) refreshBeaconArray;

@end
