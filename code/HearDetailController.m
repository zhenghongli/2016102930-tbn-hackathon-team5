//
//  HearDetailController.m
//  hackathon
//
//  Created by 陳泓諺 on 2015/11/15.
//  Copyright © 2015年 陳泓諺. All rights reserved.
//

#import "HearDetailController.h"
#import "HearDetailView.h"
#import "HearDetailViewCell.h"


@interface HearDetailController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *testArray;


@end

@implementation HearDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testArray = [NSMutableArray arrayWithObjects:@[@25.072375,@121.5163192], nil];
//    self.testArray = [NSMutableArray array];

    self.hearDetailView = [[HearDetailView alloc] initWithFrame:self.view.frame itemCounr:self.testArray.count];
    self.view = self.hearDetailView;
    self.hearDetailView.imageString = self.imageString;
    self.hearDetailView.collectionView.delegate = self;
    self.hearDetailView.collectionView.dataSource = self;
    self.hearDetailView.findLabelOne.text = [NSString stringWithFormat:@"%lufinds",(unsigned long)self.testArray.count];
    [self.hearDetailView.descriptionLabel sizeToFit];

    
}



- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.testArray.count;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cellIdentifier";
    HearDetailViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    NSLog(@"%f,%f", [self.testArray[indexPath.row][0]floatValue],[self.testArray[indexPath.row][1]floatValue]);
    CLLocationCoordinate2D pointLoc;
    MKCoordinateSpan span ;
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    pointLoc.latitude = [self.testArray[indexPath.row][0]floatValue];
    pointLoc.longitude = [self.testArray[indexPath.row][1]floatValue];
    cell.point = [[MKPointAnnotation alloc] init];
    [cell.point setCoordinate:pointLoc];
    [cell.mapView addAnnotation:cell.point];
    cell.mapView.region = MKCoordinateRegionMake(pointLoc, span);
    
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.hearDetailView.collectionView.frame)/self.testArray.count - 20);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
