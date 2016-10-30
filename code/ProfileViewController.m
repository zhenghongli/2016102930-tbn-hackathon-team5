//
//  ProfileViewController.m
//  HacktonProject
//
//  Created by I.M.A.C on 2015/11/14.
//  Copyright © 2015年 I.M.A.C. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileView.h"
#import "GenderTableViewCell.h"
#import "InputCell.h"
#import "BeaconSettingView.h"
#import "ImageTableViewCell.h"
#import "BeaconListViewCell.h"
#import "ProfileHeaderView.h"
#import "GPSModel.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource , UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak) ProfileView *profileView;
@property (nonatomic, strong) ProfileHeaderView *headerView;
@property (nonatomic, strong) NSArray *imageOfCellArray;
@property (nonatomic, strong) NSArray *placeholderOfCellArray;
@property (nonatomic, strong) BeaconSettingView *beaconSettingView;
@property (nonatomic, strong) NSString *currentMajorValueString;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.profileView = (ProfileView *)self.view;
    self.profileView.tableView.delegate = self;
    self.profileView.tableView.dataSource = self;
    self.profileView.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.headerView = [[ProfileHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) * 0.3f)];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
    [self.headerView.userHeaderImageView addGestureRecognizer:gesture];
    self.profileView.tableView.tableHeaderView = self.headerView;
    [self.headerView.backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.sumitButton addTarget:self action:@selector(submitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.imageOfCellArray = @[@"name", @"gender", @"birthday", @"email"];
    self.placeholderOfCellArray = @[@"Name", @"Gender", @"YYYY-MM-DD", @"Email"];

    // Do any additional setup after loading the view.
}

- (void)imageTapAction:(UIGestureRecognizer *)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Profile" message:@"請選擇圖片來源" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照", @"相簿", nil];
    alertView.tag = 1;
    [alertView show];
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

- (void)backButtonAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)submitButtonAction:(UIButton *)sender {
    NSMutableDictionary *md = [NSMutableDictionary dictionaryWithDictionary:[self getRegisterDic]];
    
    NSDictionary *newDic = @{@"UID": [UserInfo shareInstance].uId,
                             @"Name": md[@"Name"],
                             @"IbeaconUid": self.currentMajorValueString,
                             @"Birthday": md[@"YYYY-MM-DD"],
                             @"Sex": md[@"Gender"],
                             @"Email": md[@"Email"]};
    [[HTTPClient shareInstance] uploadProfile:newDic success:^(NSDictionary *response) {
        NSLog(@"%@", response);
    } errorResponse:^(NSString *errorMessage) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 120;
    } else {
        return 44;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 6) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 6) {
        return [GPSModel shareInstance].beaconArray.count;
    }
    if (section == 0) {
        return self.imageOfCellArray.count;
    }
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 6) {
        BeaconListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingBeaconListViewCellIdentifier"];
        if (!cell) {
            cell = [[BeaconListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingBeaconListViewCellIdentifier"];
        }
        cell.beaconNameLabel.text = [NSString stringWithFormat:@"%@", [GPSModel shareInstance].beaconArray[indexPath.row]];
        cell.selectedView.backgroundColor = ([[NSString stringWithFormat:@"%@", [GPSModel shareInstance].beaconArray[indexPath.row]] isEqualToString:self.currentMajorValueString]) ? [UIColor blueColor] : [UIColor clearColor];

        return cell;
        
    } else {
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 1:
                {
                    GenderTableViewCell *cell = (GenderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"GenderCell"];
                    if (!cell) {
                        cell = [[GenderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GenderCell"];
                    }
                    cell.imageName = self.imageOfCellArray[indexPath.row];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
                    break;
                default:
                {
                    InputCell *cell = (InputCell *)[tableView dequeueReusableCellWithIdentifier:@"InputCell"];
                    if (!cell) {
                        cell = [[InputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InputCell"];
                    }
                    cell.imageName = self.imageOfCellArray[indexPath.row];
                    cell.textField.placeholder = self.placeholderOfCellArray[indexPath.row];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    return cell;
                }
                    break;
            }
            
            
        } else if (indexPath.section == 1) {
            ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Beacon"];
            if (!cell) {
                cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Beacon"];
            }
            cell.customImageView.image = [UIImage imageNamed:@"ibeacon"];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(settingInBeaconAction)];
            cell.customImageView.userInteractionEnabled = YES;
            [cell.customImageView addGestureRecognizer:tapGesture];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
    }

    return [[InputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InputCell"];;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 6) {
        self.currentMajorValueString = [(BeaconListViewCell*)[tableView cellForRowAtIndexPath:indexPath] beaconNameLabel].text;
        [tableView reloadData];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.headerView.userHeaderImageView.image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)takePictureAction {
//    [self.maskView removeFromSuperview];
//    self.maskView = nil;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)openPhotoAction {
//    [self.maskView removeFromSuperview];
//    self.maskView = nil;
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate =self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void) settingInBeaconAction {
    self.beaconSettingView = [[BeaconSettingView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.beaconSettingView.beaconListView.delegate = self;
    self.beaconSettingView.beaconListView.dataSource = self;
    self.beaconSettingView.selectTitleLabel.text = @"設定Beacon";
    self.currentMajorValueString = [[NSUserDefaults standardUserDefaults] objectForKey:@"iBeacon"];
    [self.beaconSettingView.enterButton addTarget:self action:@selector(settingBeaconAction) forControlEvents:UIControlEventTouchUpInside];
    [self.beaconSettingView.refreshButton addTarget:self action:@selector(refreshBeaconListAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view.window addSubview:self.beaconSettingView];

}

- (void) settingBeaconAction {
    [[NSUserDefaults standardUserDefaults] setObject:self.currentMajorValueString forKey:@"iBeacon"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self.beaconSettingView removeFromSuperview];
}

- (void) refreshBeaconListAction {
    [[GPSModel shareInstance] refreshBeaconArray];
    [self.beaconSettingView.beaconListView reloadData];
}

- (NSDictionary *)getRegisterDic {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < self.imageOfCellArray.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        if ([[self.profileView.tableView cellForRowAtIndexPath:indexPath] class] == [InputCell class]) {
            InputCell *cell = (InputCell *)[self.profileView.tableView cellForRowAtIndexPath:indexPath];
            [dic setObject:cell.textField.text forKey:self.placeholderOfCellArray[i]];
        }
        else {
            GenderTableViewCell *cell = (GenderTableViewCell *)[self.profileView.tableView cellForRowAtIndexPath:indexPath];
            [dic setObject:@(!cell.selectdIndex) forKey:@"Gender"];
        }
    }
    return (NSDictionary *)dic;
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
