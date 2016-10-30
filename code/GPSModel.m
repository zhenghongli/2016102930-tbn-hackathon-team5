//
//  GPSModel.m
//  GPSModel
//
//  Created by Francis on 2015/3/11.
//  Copyright (c) 2015年 Francis. All rights reserved.
//

#import "GPSModel.h"

static NSString * beaconUuIdentifier = @"46B9B470-D287-47D3-B5D2-40670096BB67";

@interface GPSModel()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) NSMutableArray *tempBeaconArray;
@property (nonatomic) BOOL didComeHome;
@property (nonatomic) BOOL didNotification;

@end

@implementation GPSModel

+ (GPSModel*) shareInstance {
    static GPSModel *gpsModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gpsModel = [[GPSModel alloc] init];
    });
    return gpsModel;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc]init];
        
        _locationManager.delegate = self;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.activityType = CLActivityTypeFitness;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [self.locationManager requestAlwaysAuthorization];
        }
        [self createBeaconRegion];
        [self locationStartUpdate];
    }
    return self;
}

- (void) createBeaconRegion {

    if (self.beaconRegion) {
        return;
    } else {
        NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:beaconUuIdentifier];
        
        self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:@"AllergyManIdentifier"];
        self.beaconRegion.notifyEntryStateOnDisplay= YES;
        if (self.beaconRegion) {
            [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
//            [self.locationManager startMonitoringForRegion:self.beaconRegion];
        }
        
    }
}

-(void) locationStartUpdate {
    [_locationManager startUpdatingLocation];
}

-(void) locationStopUpdate {
    [_locationManager stopUpdatingLocation];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *firstPlacemark=[placemarks lastObject];
//        NSLog(@"%@", firstPlacemark.subAdministrativeArea);
        if (firstPlacemark.subAdministrativeArea) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DidUpdateLocation" object:@{@"lat" : [NSNumber numberWithDouble:firstPlacemark.location.coordinate.latitude], @"lon" : [NSNumber numberWithDouble:firstPlacemark.location.coordinate.longitude], @"city" : firstPlacemark.subAdministrativeArea}];
        }
    }];
}

-(void) locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    NSLog(@"monitoring Error");
}

-(void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"didEnterRegion");
}

-(void) locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"didExitRegion");
}

- (void) locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    self.tempBeaconArray = [NSMutableArray array];
    long int nearDistance = 0;
    long int farDistance = 0;
    for (CLBeacon *beacon in beacons) {
        [self.tempBeaconArray addObject:[NSString stringWithFormat:@"%@-%@", beacon.major, beacon.minor]];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"iBeacon"] isEqualToString:[NSString stringWithFormat:@"%@-%@", beacon.major, beacon.minor]]) {
            nearDistance = labs(beacon.proximity);
        }
    }
    
    self.didComeHome = !(nearDistance > farDistance);
    
//    NSLog(@"%ld, %ld, %d, %d, %d", nearDistance, farDistance, self.didComeHome, [[[NSUserDefaults standardUserDefaults] objectForKey:@"OpenLeaveNotification"] isEqualToString:@"open"], self.didNotification);

    
    if (!self.didNotification && !self.didComeHome && [[[NSUserDefaults standardUserDefaults] objectForKey:@"OpenLeaveNotification"] isEqualToString:@"open"]) {
        UILocalNotification* notifyWarn = [[UILocalNotification alloc] init];
        notifyWarn.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
        notifyWarn.timeZone = [NSTimeZone defaultTimeZone];
        notifyWarn.repeatInterval = 0;
        notifyWarn.soundName = UILocalNotificationDefaultSoundName;
        notifyWarn.alertBody = @"注意！目前的空氣品質糟糕，請記得戴口罩";
        [[UIApplication sharedApplication] scheduleLocalNotification:notifyWarn];
        self.didNotification = YES;
    } else if (self.didComeHome) {
        self.didNotification = NO;
    }
}

- (void) refreshBeaconArray {
    self.beaconArray = self.tempBeaconArray;
}

@end
