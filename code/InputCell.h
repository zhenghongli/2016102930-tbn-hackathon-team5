//
//  InputCell.h
//  TheHunt
//
//  Created by nutc on 7/12/15.
//  Copyright (c) 2015 HW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ValidatationTextFiled.h"

@interface InputCell : UITableViewCell

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) ValidatationTextFiled *textField;
@property (nonatomic) BOOL isRequest;

@end
