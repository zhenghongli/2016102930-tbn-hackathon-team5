//
//  PostView.m
//  Post
//
//  Created by nutc on 2015/11/14.
//  Copyright © 2015年 HW. All rights reserved.
//

#import "HearView.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallFooter.h"
#import "CHTCollectionViewWaterfallHeader.h"

@interface HearView()

@property (nonatomic, weak) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeightConstraint;

@end

@implementation HearView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headerHeightConstraint.constant = CGRectGetHeight([UIScreen mainScreen].bounds) * 0.25f;
    self.shadowView.backgroundColor = [UIColor whiteColor];
    self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, 1);
    self.shadowView.layer.shadowRadius = 1;
    self.shadowView.layer.shadowOpacity = 0.5;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.collectionView];
    
    NSMutableArray *myConstraints = [NSMutableArray array];
    [myConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_collectionView]-0-|"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(_collectionView)]];
    

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.shadowView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.collectionView.superview
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:0]];
    
    [self addConstraints:myConstraints];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.headerHeight = 0;
        layout.columnCount = 2;
        layout.footerHeight = 0;
        CGFloat onepWidth = CGRectGetWidth([UIScreen mainScreen].bounds) / 100.0;
        layout.sectionInset = UIEdgeInsetsMake(onepWidth, onepWidth, onepWidth, onepWidth);
        layout.minimumColumnSpacing = onepWidth * 2;
        layout.minimumInteritemSpacing = onepWidth * 2;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil]forCellWithReuseIdentifier:@"Cell"];
        [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                   withReuseIdentifier:@"Header"];
        [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                   withReuseIdentifier:@"Footer"];
        
        _collectionView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        _collectionView.alwaysBounceVertical = YES;
        
    }
    return _collectionView;
}

@end
