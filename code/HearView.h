//
//  PostView.h
//  Post
//
//  Created by nutc on 2015/11/14.
//  Copyright © 2015年 HW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"

@interface HearView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end
