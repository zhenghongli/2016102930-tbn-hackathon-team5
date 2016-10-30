//
//  TempCollectionViewCell.m
//  CHunt
//
//  Created by I.M.A.C on 2015/7/2.
//  Copyright (c) 2015年 I.M.A.C. All rights reserved.
//

#import "TempCollectionViewCell.h"
#import "UIColor+Decoder.h"
#import "NSString+Hashes.h"
#import <CommonCrypto/CommonDigest.h>
#import "CacheImage.h"

@interface TempCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *actionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UIImageView *starImage;
@property (weak, nonatomic) IBOutlet UIView *likeContext;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *subDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *maskView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *actionTypeLabelWitdh;

@end

@implementation TempCollectionViewCell





- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) return nil;
    self.backgroundColor = [UIColor whiteColor];
    self.imageView.userInteractionEnabled = YES;
    self.starImage.userInteractionEnabled = YES;
    self.userImageView.userInteractionEnabled = YES;
    self.actionLabel.hidden = self.showAction;

    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(1,3);
    self.layer.shadowOpacity = 0.1;
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
//    NSLog(@"%@", NSStringFromCGRect(self.frame));

    return self;
}



- (void)prepareForReuse {
    [super prepareForReuse];
    self.userImageFileName = @"";
    self.userName = @"";
    self.imageView.image = nil;
    self.imageName = @"";
    self.descriptionText = @"";
    self.subDescriptionText = @"";
    self.actionLabel.hidden = self.showAction;
    self.index = -1;

    
}


- (void)setShowAction:(BOOL)showAction {
    _showAction = showAction;
    self.actionLabel.hidden = showAction;
}

- (void)setUserImageFileName:(NSString *)userImageFileName {
    _userImageFileName = [userImageFileName copy];
    if ([_userImageFileName isEqualToString:@""]) {
        UIImage *image = [UIImage imageNamed:@"ic_profile_grey"];
        self.userImageView.image = image;
        return;
    }
    
    __weak typeof(self) weakSelf =  self;
    [CacheImage loadImageWithImageUrl:userImageFileName type:@"_header" image:^(UIImage *image) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        //        strongSelf.userImageView.image = image;
        
//        UIGraphicsBeginImageContextWithOptions(strongSelf.userImageView.bounds.size, NO, 0);
//        [image drawInRect:strongSelf.userImageView.bounds];
        CGFloat width = 40 * [UIScreen mainScreen].scale;
        image = [image scaleToSize:CGSizeMake(width, width)];
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            strongSelf.userImageView.image = image;
        });
    }];
    
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:userImageFileName]];
//    
//    UIImage *image = [UIImage imageWithData:data];
//    self.userImageView.image = image;
}



- (void)setUserName:(NSString *)userName {
    _userName = [userName copy];
    
    self.nameLabel.text  =  [NSString stringWithFormat:@"@%@", _userName];
}

- (void)setActionName:(NSString *)actionName {
    _actionName = [actionName copy];
    self.actionLabel.layer.cornerRadius = 8.0f;
    self.actionLabel.textAlignment = NSTextAlignmentCenter;
    NSString *actionString;
    if ([actionName isEqualToString:@"0"]) {
        self.actionLabel.backgroundColor = [UIColor colorWithHexString:@"#ffe9c3"];
        actionString = @"哪裡買";
    } else if ([actionName isEqualToString:@"1"]) {
        self.actionLabel.backgroundColor = [UIColor colorWithHexString:@"#fac9c8"];
        actionString = @"新鮮貨";
    } else if ([actionName isEqualToString:@"2"]) {
        self.actionLabel.backgroundColor = [UIColor colorWithHexString:@"#dbc6e0"]; //fac9c8
        actionString = @"分享";
    } else if ([actionName isEqualToString:@"3"]) {
        self.actionLabel.backgroundColor = [UIColor colorWithHexString:@"#c1e6ec"];
        actionString = @"意見區";
    } else if ([actionName isEqualToString:@"4"]) {
        self.actionLabel.backgroundColor = [UIColor colorWithHexString:@"#c1e6ec"];
        actionString = @"意見區";
    } else {
        actionString = @"";
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:actionString];
    
    float spacing = 1.0f;
    [attributedString addAttribute:NSKernAttributeName
                             value:@(spacing)
                             range:NSMakeRange(0, [actionString length])];
    self.actionLabel.attributedText = attributedString;
    self.actionLabel.clipsToBounds = YES;
    self.actionLabel.textAlignment = NSTextAlignmentCenter;
    self.actionLabel.text = _actionName;
//    self.actionLabel.text  = actionName;

}

- (void)setImageName:(NSString *)imageName {
    _imageName = [imageName copy];
    if ([_imageName isEqualToString:@""]) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [CacheImage loadImageWithImageUrl:imageName type:@"" image:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.imageView.alpha = 0.f;
            weakSelf.imageView.image = image;
            [UIView animateWithDuration:0.5f animations:^{
                weakSelf.imageView.alpha = 1.f;
            }];
        });
    }];

}

- (NSString *)getSmallImageUrl:(NSString *)url {
    if ([url rangeOfString:@"merge"].location == NSNotFound) {
        NSRange range = [url rangeOfString:@"." options:NSBackwardsSearch];
        NSLog(@"%@", [url stringByReplacingCharactersInRange:range withString:@"_s."]);
        return [url stringByReplacingCharactersInRange:range withString:@"_s."];
    }
    else {
        return url;
    }
}

- (void)setDescriptionText:(NSString *)descriptionText {
    _descriptionText = [descriptionText copy];
    self.descriptionLabel.text = _descriptionText;
    self.descriptionLabel.textColor = [UIColor whiteColor];
    
}

- (void)setSubDescriptionText:(NSString *)subDescriptionText {
    _subDescriptionText = [subDescriptionText copy];
    NSScanner *scanner = [NSScanner scannerWithString:_subDescriptionText];
    BOOL isNumeric = [scanner scanInteger:NULL] && [scanner isAtEnd];
    if (isNumeric) {
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *myNumber = [f numberFromString:_subDescriptionText];
        if ([myNumber integerValue] < 1000) {
            self.subDescriptionLabel.text = [myNumber stringValue];
        } else {
            self.subDescriptionLabel.text = @"999+";
        }

    }
    
}

- (void)setIsLike:(BOOL)isLike {
    _isLike = isLike;
    if (_isLike) {
        self.starImage.image  = [UIImage imageNamed:@"ic_light_like"];
    } else {
        self.starImage.image  = [UIImage imageNamed:@"ic_light_unlike"];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapStarImage:)];
    tap.numberOfTouchesRequired = 1;
    [self.likeContext addGestureRecognizer:tap];
//    [self.starImage addGestureRecognizer:tap];
    

    [self.contentView addSubview:self.userImageView];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.maskView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.actionLabel];

    [self.contentView addSubview:self.descriptionLabel];
    [self.contentView addSubview:self.subDescriptionLabel];
    [self.contentView addSubview:self.starImage];
    [self.contentView addSubview:self.likeContext];
    

//    self.userImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width / 2.0f;
    self.userImageView.clipsToBounds = YES;
    self.userImageView.layer.masksToBounds = YES;
    self.actionTypeLabelWitdh.constant = W * 25;

}


- (void)tapStarImage:(UITapGestureRecognizer *)sender {
    NSNumber *number =[[NSNumberFormatter alloc] numberFromString:self.subDescriptionLabel.text];
    self.subDescriptionLabel.text = [NSString stringWithFormat:@"%ld", number.integerValue + (self.isLike ? -1 : 1)];
    self.isLike = !self.isLike;

}

- (void)updateData:(NSDictionary *)dictionary {
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeData:index:)]) {
        [self.delegate changeData:dictionary index:self.index];
    }
}


@end
