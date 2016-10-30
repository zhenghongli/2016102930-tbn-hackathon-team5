//
//  InputCell.m
//  TheHunt
//
//  Created by nutc on 7/12/15.
//  Copyright (c) 2015 HW. All rights reserved.
//

#import "InputCell.h"

@interface InputCell() <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *leftImageView;

@end

@implementation InputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5.9f * W, 0, 10.0f * W, 10.0f * W)];
        self.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.leftImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.leftImageView];

        NSMutableArray *myConstraints = [NSMutableArray array];
        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[_leftImageView(40)]"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(_leftImageView)]];
        
        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[_leftImageView(40)]"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(_leftImageView)]];
        [self.contentView addConstraints:myConstraints];
//        self.leftImageView.backgroundColor = [UIColor redColor];
        
        self.textField = [[ValidatationTextFiled alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftImageView.frame) + 2 * W, 0, CGRectGetWidth(self.frame) - CGRectGetMaxX(self.leftImageView.frame) - CGRectGetHeight(self.frame) / 2.f, 10.0f * W)];
        self.textField.delegate =self;
        [self.contentView addSubview:self.textField];
        self.promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame), CGRectGetMaxY(self.textField.frame), CGRectGetWidth(self.textField.frame), 3.0f*W)];
        self.promptLabel.font = [UIFont systemFontOfSize:13];;
        self.promptLabel.textColor = [UIColor redColor];
//        self.promptLabel.text = @"12213";
        [self.contentView addSubview:self.promptLabel];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.leftImageView.image = [UIImage imageNamed:imageName];
}

@end
