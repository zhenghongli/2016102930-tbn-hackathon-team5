//
//  HearDetailView.h
//  hackathon
//
//  Created by 陳泓諺 on 2015/11/15.
//  Copyright © 2015年 陳泓諺. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HearDetailView : UIView
@property (nonatomic, strong) NSString *imageString;
@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIScrollView *baseScrollView;
@property (nonatomic, strong) UIImageView *userImage;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *findLabelOne;
@property (nonatomic, strong) UILabel *classLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layOut;
- (instancetype) initWithFrame:(CGRect)frame itemCounr:(NSInteger)itemCount;

@end
