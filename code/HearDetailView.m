//
//  HearDetailView.m
//  hackathon
//
//  Created by 陳泓諺 on 2015/11/15.
//  Copyright © 2015年 陳泓諺. All rights reserved.
//

#import "HearDetailView.h"
#import "UIColor+Decoder.h"
#import "CacheImage.h"
#import "HearDetailViewCell.h"

@interface HearDetailView ()

@property (nonatomic, strong) UIView *lineOne;
@property (nonatomic, strong) UIView *lineTwo;
@property (nonatomic, strong) UIView *lineThree;
@property (nonatomic, strong) UIView *classBackView;
@property (nonatomic, strong) UILabel *findLabelTwo;
@property (nonatomic, strong) UILabel *notFoundLabel;

@end

@implementation HearDetailView

- (instancetype) initWithFrame:(CGRect)frame itemCounr:(NSInteger)itemCount{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#FEFEFE"];
        
        self.titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) * 0.33)];
        self.titleImage.image = [UIImage imageNamed:@"333"];
        [self addSubview:self.titleImage];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetHeight(self.frame) * 0.22, CGRectGetWidth(self.frame) / 2,  30)];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#FEFEFE"];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:25];
        self.titleLabel.text = @"尋找MP3";
        [self addSubview:self.titleLabel];
        
        self.findLabelOne = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame) , CGRectGetWidth(self.frame) / 2,  30)];
        self.findLabelOne.textAlignment = NSTextAlignmentLeft;
        self.findLabelOne.textColor = [UIColor colorWithHexString:@"#FEFEFE"];
        self.findLabelOne.font = [UIFont systemFontOfSize:23];
        self.findLabelOne.text = @"0 finds";
        [self addSubview:self.findLabelOne];
        
        self.baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleImage.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(self.titleImage.frame) )];
        self.baseScrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.baseScrollView];
        
        
        self.userImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.05, 20 , 60, 60)];
        self.userImage.image = [UIImage imageNamed:@"yeng"];
        self.userImage.layer.borderWidth = 1;
        self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
        self.userImage.clipsToBounds = YES;
        [self.baseScrollView addSubview:self.userImage];
        
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userImage.frame) + 15, CGRectGetMidY(self.userImage.frame) - 30, CGRectGetWidth(self.frame) - CGRectGetWidth(self.userImage.frame), 30)];
        self.userNameLabel.textColor = [UIColor colorWithHexString:@"#3A2D32"];
        self.userNameLabel.textAlignment = NSTextAlignmentLeft;
        self.userNameLabel.font = [UIFont boldSystemFontOfSize:20];
        self.userNameLabel.text = @"@ March";
        [self.baseScrollView addSubview:self.userNameLabel];
        
        self.classBackView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userImage.frame) + 15, CGRectGetMaxY(self.userNameLabel.frame) + 5 , CGRectGetWidth(self.frame) * 0.28, 20)];
        self.classBackView.backgroundColor = [UIColor colorWithHexString:@"#F56967"];
        self.classBackView.layer.cornerRadius = 10;
        [self.baseScrollView addSubview:self.classBackView];
        
        self.classLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userImage.frame) + 15, CGRectGetMaxY(self.userNameLabel.frame) + 5, CGRectGetWidth(self.frame) * 0.28, 20)];
        self.classLabel.textColor = [UIColor colorWithHexString:@"#FEFEFE"];
        self.classLabel.textAlignment = NSTextAlignmentCenter;
        self.classLabel.font = [UIFont boldSystemFontOfSize:20];
        self.classLabel.text = @"pets";
        [self.baseScrollView addSubview:self.classLabel];
        
        self.lineOne = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userImage.frame), CGRectGetMaxY(self.userImage.frame) + 20, CGRectGetWidth(self.frame) * 0.87 , 2)];
        self.lineOne.backgroundColor =[UIColor colorWithHexString:@"#D8D8D8"];
        [self.baseScrollView addSubview:self.lineOne];
        
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.lineOne.frame) + 5, CGRectGetMaxY(self.lineOne.frame) + 5, CGRectGetWidth(self.frame) * 0.85, CGRectGetHeight(self.frame) * 0.3)];
        self.descriptionLabel.text = @"她是我的女朋友，我跟她在一起已經兩年多了，每次跟他牽手出門總是一直被看，我知道是我女朋友長得很可愛的關係，突然有一天他被綁架了，請大家幫幫我，她叫張楚珊，年紀一十八，身高有一六八，C罩杯，顏值爆表。";
//        self.descriptionLabel.text = @"我有一隻小毛驢 我從來也不騎有一天我心血來潮騎著去趕集我手裡拿著小皮鞭我心裡真得意不知怎麼嘩啦啦啦我摔了一身泥";
        self.descriptionLabel.textColor = [UIColor colorWithHexString:@"#3A2D32"];
        self.descriptionLabel.font = [UIFont systemFontOfSize:18];
        self.descriptionLabel.numberOfLines = 0;
        [self.baseScrollView addSubview:self.descriptionLabel];
    
        self.lineTwo = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userImage.frame), CGRectGetMaxY(self.descriptionLabel.frame) + 5, CGRectGetWidth(self.frame) * 0.87 , 2)];
        self.lineTwo.backgroundColor =[UIColor colorWithHexString:@"#D8D8D8"];
        [self.baseScrollView addSubview:self.lineTwo];
        
        self.findLabelTwo = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.descriptionLabel.frame), CGRectGetMaxY(self.lineTwo.frame) + 5 , CGRectGetWidth(self.frame) * 0.85, 30)];
        self.findLabelTwo.textColor = [UIColor colorWithHexString:@"#3A2D32"];
        self.findLabelTwo.text = @"Finds";
        self.findLabelTwo.font = [UIFont systemFontOfSize:20];
        [self.baseScrollView addSubview:self.findLabelTwo];
        
        self.layOut = [[UICollectionViewFlowLayout alloc] init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake( CGRectGetMinX(self.descriptionLabel.frame), CGRectGetMaxY(self.findLabelTwo.frame) + 5, CGRectGetWidth(self.frame) * 0.87, 350 * itemCount) collectionViewLayout:self.layOut];
        self.collectionView.scrollEnabled = NO;
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.collectionView registerClass:[HearDetailViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        [self.baseScrollView addSubview:self.collectionView];
        
        self.lineThree = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userImage.frame), CGRectGetMaxY(self.findLabelTwo.frame) + 5, CGRectGetWidth(self.frame) * 0.87 , 2)];
        self.lineThree.backgroundColor =[UIColor colorWithHexString:@"#D8D8D8"];
        [self.baseScrollView addSubview:self.lineThree];
        
        self.baseScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetMaxY(self.collectionView.frame) + 100 );
        
        if (itemCount == 0) {
            self.notFoundLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.descriptionLabel.frame), CGRectGetMaxY(self.lineThree.frame) + 5, CGRectGetWidth(self.frame) * 0.3, 30)];
            self.notFoundLabel.textColor = [UIColor colorWithHexString:@"#F56967"];
            self.notFoundLabel.text = @"Not Found";
            self.notFoundLabel.font = [UIFont systemFontOfSize:20];
            [self.baseScrollView addSubview:self.notFoundLabel];
            

        }
        

    }
    return self;
}

- (void)setImageString:(NSString *)imageString {
    _imageString = imageString;
    if ([_imageString isEqualToString:@""]) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [CacheImage loadImageWithImageUrl:_imageString type:@"" image:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.titleImage.alpha = 0.f;
            weakSelf.titleImage.image = image;
            [UIView animateWithDuration:0.5f animations:^{
                weakSelf.titleImage.alpha = 1.f;
            }];
        });
    }];
}
@end
