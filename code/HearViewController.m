//
//  HearViewController.m
//  HacktonProject
//
//  Created by I.M.A.C on 2015/11/15.
//  Copyright © 2015年 I.M.A.C. All rights reserved.
//

#import "CHTCollectionViewWaterfallHeader.h"
#import "CHTCollectionViewWaterfallFooter.h"
#import "HearViewController.h"
#import "HearDetailController.h"
#import "HearView.h"
#import "TempCollectionViewCell.h"


@interface HearViewController () <CHTCollectionViewDelegateWaterfallLayout, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation HearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [NSMutableArray array];
    HearView *hearView = (HearView *)[[NSBundle mainBundle] loadNibNamed:@"HearView" owner:self options:nil][0];
    self.view = hearView;
    hearView.collectionView.dataSource = self;
    hearView.collectionView.delegate = self;
    [hearView.backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [[HTTPClient shareInstance] productListWithType:@"Goods" success:^(NSDictionary *response) {
        self.data = [response copy];
        [hearView.collectionView reloadData];
        NSLog(@"%@",response);
    } errorResponse:^(NSString *errorMessage) {
        
    } failure:^(NSError *error) {
        
    }];
    // Do any additional setup after loading the view.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
    ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TempCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.descriptionText = self.data[indexPath.row][@"Description"];
    cell.showAction = YES;
    cell.userName = [self.data[indexPath.row][@"UID"] stringValue];
    cell.actionName = self.data[indexPath.row][@"Type"];
    NSString *imageString = self.data[indexPath.item][@"Image"];
    imageString = [imageString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    NSData *data = [imageString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingMutableContainers
                                                      error:nil];
    
    cell.imageName = json[0][@"Image"];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HearDetailController *detailView = [[HearDetailController alloc] init];
    NSString *imageString = self.data[indexPath.item][@"Image"];
    imageString = [imageString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    NSData *data = [imageString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingMutableContainers
                                                      error:nil];
    detailView.imageString = json[0][@"Image"];
    [self.navigationController pushViewController:detailView animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)/2.f, 200);
}

-(void)backButtonAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
