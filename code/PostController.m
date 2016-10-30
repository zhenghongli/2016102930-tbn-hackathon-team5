//
//  PostController.m
//  Post
//
//  Created by nutc on 2015/11/14.
//  Copyright © 2015年 HW. All rights reserved.
//

#import "PostController.h"
#import "PostView.h"
#import "PostTableViewFooter.h"
#import "PostTableViewCell.h"
#import <CoreLocation/CoreLocation.h>

#import "VisibilityPostTableViewCell.h"

@interface PostController () <UIAlertViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *location;
    CLGeocoder *geocoder;

}
@property (nonatomic, strong) NSArray *cellPlaceholderArray;
@property (nonatomic, strong) NSArray *cellImageArray;
@property (nonatomic, strong) UIButton *cameraButton;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation PostController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    self.cellPlaceholderArray = @[@"Thing type", @"Thing title", @"More details", @"UUID"];
    self.cellImageArray = @[@"ic_shopping_basket_black_48dp.png", @"ic_assignment_black_48dp", @"ic_dashboard_black_48dp", @"iBeacon123"];
    
    PostView *postView = (PostView *)[[[NSBundle mainBundle] loadNibNamed:@"PostView" owner:nil options:nil] lastObject];
    self.view = postView;
    [postView.backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.tableView = postView.tableView;
    postView.tableView.dataSource = self;
    
    PostTableViewFooter *postTableViewFooter = (PostTableViewFooter *)[[[NSBundle mainBundle] loadNibNamed:@"PostTableViewFooter" owner:nil options:nil] lastObject];
    [postView.tableView setTableFooterView:postTableViewFooter];
    [postTableViewFooter.cameraButton addTarget:self action:@selector(cameraAction) forControlEvents:UIControlEventTouchUpInside];
    self.cameraButton = postTableViewFooter.cameraButton;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadAction)];
    [postTableViewFooter.uploadImageView addGestureRecognizer:tapGesture];
    [postView.tableView registerNib:[UINib nibWithNibName:@"VisiblilityPostTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell2"];
    [postView.tableView registerNib:[UINib nibWithNibName:@"PostTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    //locationManager初始化
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    //設定需要重新定位的距離差距(0.01km)
    locationManager.distanceFilter = 10;
    
    //設定定位時的精準度
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    geocoder = [[CLGeocoder alloc] init];
}

- (void)backButtonAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)cameraAction {
    NSLog(@"cameraAction");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Profile" message:@"請選擇圖片來源" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照", @"相簿", nil];
    alertView.tag = 1;
    [alertView show];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self.cameraButton setImage:[info valueForKey:UIImagePickerControllerOriginalImage] forState:UIControlStateNormal] ;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)takePictureAction {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 0) {
        //        if (self.delegate && [self.delegate respondsToSelector:@selector(registerController:getEmail:)]) {
        //            NSString *email = ((UITextField *)self.textFields[0]).text;
        //            [self.delegate registerController:self getEmail:email];
        //        }
        //        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        if (buttonIndex == 1) {
            [self takePictureAction];
        }
        else if (buttonIndex == 2) {
            [self openPhotoAction];
        }
    }
}

- (void)openPhotoAction {
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate =self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)uploadAction {
    //【UID，Type，ShortTitle，Description，ProfileIbUid，PublicType，Image[]】

//    NSDictionary *dic = [self getRegisterDic];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
         if (error == nil && [placemarks count] > 0)
         {
             CLPlacemark *placemark = [placemarks lastObject];
             
             // strAdd -> take bydefault value nil
             NSString *strAdd = nil;
             
             if ([placemark.subThoroughfare length] != 0)
                 strAdd = placemark.subThoroughfare;
             
             if ([placemark.thoroughfare length] != 0)
             {
                 // strAdd -> store value of current location
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark thoroughfare]];
                 else
                 {
                     // strAdd -> store only this value,which is not null
                     strAdd = placemark.thoroughfare;
                 }
             }
             
             if ([placemark.postalCode length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark postalCode]];
                 else
                     strAdd = placemark.postalCode;
             }
             
             if ([placemark.locality length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark locality]];
                 else
                     strAdd = placemark.locality;
             }
             
             if ([placemark.administrativeArea length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark administrativeArea]];
                 else
                     strAdd = placemark.administrativeArea;
             }
             
             if ([placemark.country length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark country]];
                 else
                     strAdd = placemark.country;
             }
         }
     }];

    
//    NSMutableDictionary *md = [NSMutableDictionary dictionaryWithDictionary:@{@"strAccount": @"",
//                                                                              @"strPassword": @"Goods",
//                                                                              @"strAddr": dic[@"Thing title"],
//                                                                              @"Lon": @(location.coordinate.longitude),
//                                                                              @"Lat": @(location.coordinate.latitude),
//                                                                              @"SpCName": @"",
//                                                                              @"Title": @"",
//                                                                              @"": @"StartTime",
//                                                                              @"SurveyContent": @"",
//                                                                              @"strCity": @"",
//                                                                              @"strCityTown": @""
//                                                            }];
//    [[HTTPClient shareInstance] uploadArticleWithDic:md images:@[self.cameraButton.imageView.image] success:^(NSDictionary *response) {
//        NSLog(@"%@",response);
//    } errorResponse:^(NSString *errorMessage) {
//        
//    } failure:^(NSError *error) {
//        
//    }];
    NSLog(@"uploadAction");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellPlaceholderArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.cellPlaceholderArray.count) {
        VisibilityPostTableViewCell *cell = (VisibilityPostTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell2"];
        return cell;
    }
    
    PostTableViewCell *cell = (PostTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = (PostTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    }
    cell.frontImageView.image = [UIImage imageNamed:self.cellImageArray[indexPath.row]];
    cell.textField.placeholder = self.cellPlaceholderArray[indexPath.row];
    return cell;
}

- (NSDictionary *)getRegisterDic {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < self.cellImageArray.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        if ([[self.tableView cellForRowAtIndexPath:indexPath] class] == [PostTableViewCell class]) {
            PostTableViewCell *cell = (PostTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [dic setObject:cell.textField.text forKey:self.cellPlaceholderArray[i]];
        }
        else {
            VisibilityPostTableViewCell *cell = (VisibilityPostTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [dic setObject:@(cell.currentSelectedIndex == 0 ? YES : NO) forKey:@"Public"];
        }
    }
    return (NSDictionary *)dic;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *) oldLocation {
    location = newLocation;
//    longitudeLabel.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
//    
//    latitudeLabel.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
//    
//    altitudeLabel.text = [NSString stringWithFormat:@"%f", newLocation.altitude];
}

@end
