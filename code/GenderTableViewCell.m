//
//  GenderTableViewCell.m
//  TheHunt
//
//  Created by nutc on 7/27/15.
//  Copyright (c) 2015 HW. All rights reserved.
//

#import "GenderTableViewCell.h"

@interface GenderTableViewCell()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIButton *maleButton;
@property (nonatomic, strong) UIButton *femaleButton;

@end

@implementation GenderTableViewCell

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
        UIImageView *maleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5.9f * W, 0, 10.0f * W, 10.0f * W)];
        maleImageView.image = [UIImage imageNamed:@"ic_dark_high_male"];
        maleImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:maleImageView];

        
        

        self.selectdIndex = 0;
        self.maleButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(maleImageView.frame) + 2.f * W, 1.25f * W, 30.f * W, 38)];
        self.maleButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.maleButton.layer.borderWidth = 1.f;
        [self.maleButton setTitle:@"male" forState:UIControlStateNormal];
        [self.maleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.maleButton setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [self.maleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.maleButton setBackgroundImage:[self createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
        self.maleButton.selected = YES;
        [self.maleButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.maleButton];
        
        myConstraints = [NSMutableArray array];
        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-16-[_maleButton(%.0f)]", CGRectGetMaxX(maleImageView.frame) + 2.f * W]
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(_maleButton)]];
        [self.contentView addConstraints:myConstraints];

        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[_maleButton(38)]"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(_maleButton)]];
        [self.contentView addConstraints:myConstraints];
        
        
        
        UIImageView *femaleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.maleButton.frame) + 5.9f * W, 0, 10.0f * W, 10.0f * W)];
        femaleImageView.image = [UIImage imageNamed:@"ic_dark_high_female"];
        femaleImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:femaleImageView];
        
        self.femaleButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(femaleImageView.frame) + 2.f * W, 1.25f * W, 30.f * W, 38)];
        self.femaleButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.femaleButton.layer.borderWidth = 1.f;
        [self.femaleButton setTitle:@"female" forState:UIControlStateNormal];
        [self.femaleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.femaleButton setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [self.femaleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.femaleButton setBackgroundImage:[self createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
        self.femaleButton.tag = 1;
        [self.femaleButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.femaleButton];
        myConstraints = [NSMutableArray array];
        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-16-[_femaleButton(%.0f)]", CGRectGetMaxX(femaleImageView.frame) + 2.f * W]
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(_femaleButton)]];
        [self.contentView addConstraints:myConstraints];
        
        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[_femaleButton(38)]"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(_femaleButton)]];
        [self.contentView addConstraints:myConstraints];
        
    }
    return self;
}

- (void)buttonAction:(UIButton *)sender {
    self.maleButton.selected = (BOOL)!sender.tag;
    self.femaleButton.selected = (BOOL)sender.tag;
    self.selectdIndex = sender.tag;
}

- (void)setSelectdIndex:(NSInteger)selectdIndex {
    _selectdIndex = selectdIndex;
    if (selectdIndex == 0) {
        self.maleButton.selected = YES;
        self.femaleButton.selected = NO;
    } else {
        self.maleButton.selected =  NO;
        self.femaleButton.selected = YES;
    }
}

- (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.leftImageView.image = [UIImage imageNamed:imageName];
}

@end
