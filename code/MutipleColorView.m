//
//  MutipleColorView.m
//  HacktonProject
//
//  Created by I.M.A.C on 2015/11/14.
//  Copyright © 2015年 I.M.A.C. All rights reserved.
//

#import "MutipleColorView.h"

@interface MutipleColorView ()
{
    CGFloat height;
}

@property (nonatomic, strong) UIImageView *seeImageView;
@end

@implementation MutipleColorView


- (void)awakeFromNib {
    [super awakeFromNib];
    self.isOpen = YES;
    
    CGFloat scale = 0;
    
    UIImage *image = [UIImage imageNamed:@"Profile"];
    scale = image.size.width / image.size.height;
    UIImageView *profileImageView = [[UIImageView alloc]initWithImage:image];
    [self.blueButton addSubview:profileImageView];
    [profileImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSMutableArray *myConstraints = [NSMutableArray array];
    [myConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[profileImageView(44)]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(profileImageView)]];
    
    [myConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[profileImageView(45)]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(profileImageView)]];
    NSLayoutConstraint *myConstraint;
    myConstraint = [NSLayoutConstraint constraintWithItem:profileImageView attribute:NSLayoutAttributeCenterY
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:[profileImageView superview] attribute:NSLayoutAttributeCenterY
                                               multiplier:1.0f constant:-0.0f];
    [myConstraints addObject:myConstraint];
    [self.blueButton addConstraints:myConstraints];
    
    
    UILabel *postImageView = [[UILabel alloc] init];
    postImageView.text = @"上傳資料";
    postImageView.textAlignment = NSTextAlignmentCenter;
    postImageView.textColor = [UIColor whiteColor];
    [postImageView sizeToFit];
    [self.redButton addSubview:postImageView];
    [postImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    myConstraints = [NSMutableArray array];
    [myConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:[postImageView(100)]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(postImageView)]];
    [myConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[postImageView(57)]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(postImageView)]];
    myConstraint = [NSLayoutConstraint constraintWithItem:postImageView attribute:NSLayoutAttributeCenterY
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:[postImageView superview] attribute:NSLayoutAttributeCenterY
                                               multiplier:1.0f constant:-0.0f];
    [myConstraints addObject:myConstraint];
    
    myConstraint = [NSLayoutConstraint constraintWithItem:postImageView attribute:NSLayoutAttributeCenterX
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:[postImageView superview] attribute:NSLayoutAttributeCenterX
                                               multiplier:1.0f constant:-0.0f];
    [myConstraints addObject:myConstraint];
    
    [self.redButton addConstraints:myConstraints];
    
    
    UILabel *hearImageView = [[UILabel alloc] init];
    hearImageView.text = @"檢視資料";
    hearImageView.textAlignment = NSTextAlignmentCenter;
    hearImageView.textColor = [UIColor whiteColor];
    [hearImageView sizeToFit];
    [self.yelloButton addSubview:hearImageView];
    [hearImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    myConstraints = [NSMutableArray array];
    [myConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:[hearImageView(100)]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(hearImageView)]];
    [myConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[hearImageView(57)]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(hearImageView)]];
    myConstraint = [NSLayoutConstraint constraintWithItem:hearImageView attribute:NSLayoutAttributeCenterY
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:[hearImageView superview] attribute:NSLayoutAttributeCenterY
                                               multiplier:1.0f constant:-0.0f];
    [myConstraints addObject:myConstraint];
    
    myConstraint = [NSLayoutConstraint constraintWithItem:hearImageView attribute:NSLayoutAttributeCenterX
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:[hearImageView superview] attribute:NSLayoutAttributeCenterX
                                               multiplier:1.0f constant:-0.0f];
    [myConstraints addObject:myConstraint];
    
    [self.yelloButton addConstraints:myConstraints];
    
    
    UILabel *settingImageView = [[UILabel alloc] init];
    settingImageView.text = @"歷史紀錄";
    settingImageView.textAlignment = NSTextAlignmentCenter;
    settingImageView.textColor = [UIColor whiteColor];
    [settingImageView sizeToFit];
    [self.greenButton addSubview:settingImageView];
    [settingImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    myConstraints = [NSMutableArray array];
    [myConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:[settingImageView(100)]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(settingImageView)]];
    [myConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[settingImageView(57)]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(settingImageView)]];
    myConstraint = [NSLayoutConstraint constraintWithItem:settingImageView attribute:NSLayoutAttributeCenterY
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:[settingImageView superview] attribute:NSLayoutAttributeCenterY
                                               multiplier:1.0f constant:-0.0f];
    [myConstraints addObject:myConstraint];
    
    myConstraint = [NSLayoutConstraint constraintWithItem:settingImageView attribute:NSLayoutAttributeCenterX
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:[settingImageView superview] attribute:NSLayoutAttributeCenterX
                                               multiplier:1.0f constant:-0.0f];
    [myConstraints addObject:myConstraint];
    
    [self.greenButton addConstraints:myConstraints];
    
    
    UIImageView *seeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"see"]];
    self.seeImageView = seeImageView;
    [self.purpleButton addSubview:seeImageView];
    [seeImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    myConstraints = [NSMutableArray array];
    [myConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:[seeImageView(44)]-20-|"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(seeImageView)]];
    
    [myConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[seeImageView(50)]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(seeImageView)]];
    myConstraint = [NSLayoutConstraint constraintWithItem:seeImageView attribute:NSLayoutAttributeCenterY
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:[seeImageView superview] attribute:NSLayoutAttributeCenterY
                                               multiplier:1.0f constant:-0.0f];
    [myConstraints addObject:myConstraint];
    [self.purpleButton addConstraints:myConstraints];
    
    
    [self.purpleButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)buttonAction:(UIButton *)sender {
    self.isOpen = !self.isOpen;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.backgroundColor = [UIColor lightGrayColor];
    height = ceil(CGRectGetHeight([UIScreen mainScreen].bounds) / 4.0F)  ;
    CGFloat dobuleHeight = height * 2.0f;
    self.purpleHeightConstraint.constant = height;
    self.blueHeightConstraint.constant = height;
    self.redHeightConstraint.constant = self.yelloHeightConstraint.constant = self.greenHeightConstraint.constant = dobuleHeight;
    self.redTopConstraint.constant = -height;
    self.yelloTopConstraint.constant = self.greenTopConstraint.constant = -height;


    
}

- (void)setIsOpen:(BOOL)isOpen {
    _isOpen = isOpen;
    self.seeImageView.image = _isOpen ? [UIImage imageNamed:@"see"] : [UIImage imageNamed:@"off_see"];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
