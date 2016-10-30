//
//  MainViewController.m
//  HacktonProject
//
//  Created by I.M.A.C on 2015/11/14.
//  Copyright © 2015年 I.M.A.C. All rights reserved.
//

#import "MainViewController.h"
#import "MutipleColorView.h"
#import "ProfileViewController.h"
#import "PostController.h"
#import "HearViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    MutipleColorView *view = [[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil][0];
    view.frame = [UIScreen mainScreen].bounds ;
    [view setNeedsLayout];
    [view layoutIfNeeded];
    
    [view.blueButton addTarget:self action:@selector(profileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view.redButton addTarget:self action:@selector(postButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
    [view.yelloButton addTarget:self action:@selector(hearButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];

    // Do any additional setup after loading the view.
}

- (void)profileButtonAction:(UIButton *)sender {
    ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileView" bundle:nil];

    [self.navigationController pushViewController:profileViewController animated:YES];
}

- (void)postButtonAciton:(UIButton *)sender {
    PostController *postController = [[PostController alloc] init];
    [self.navigationController pushViewController:postController animated:YES];

}

- (void)hearButtonAction {
    HearViewController *hearController = [[HearViewController alloc] initWithNibName:@"HearView" bundle:nil];
    [self.navigationController pushViewController:hearController animated:YES];

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
