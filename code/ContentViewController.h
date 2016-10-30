//
//  ContentViewController.h
//  TestPage
//
//  Created by I.M.A.C on 2015/6/15.
//  Copyright (c) 2015年 I.M.A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"


@protocol ContentViewDelegate <NSObject>

- (void)scrollYOffset:(CGFloat)offset;

@end

@interface ContentViewController : UIViewController <UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic) NSInteger type;
@property (nonatomic, strong) NSString *searchId;
@property (nonatomic) NSInteger productType;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, weak) id <ContentViewDelegate> delegate;
@property (nonatomic) NSInteger columsCount;


@end
