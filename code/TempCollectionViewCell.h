//
//  TempCollectionViewCell.h
//  CHunt
//
//  Created by I.M.A.C on 2015/7/2.
//  Copyright (c) 2015年 I.M.A.C. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TempCollectionViewCellDelegate <NSObject>
@required
- (void)changeData:(NSDictionary *)data index:(NSInteger)index;
@optional
- (void)isLikeChange:(NSDictionary *)respones tag:(NSInteger)tag;
@end

@interface TempCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSString *userImageFileName;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *actionName;
@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, strong) NSString *subDescriptionText;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic) NSInteger index;
@property (nonatomic) BOOL isLike;
@property (nonatomic) BOOL showAction;
@property (nonatomic, weak) id <TempCollectionViewCellDelegate> delegate;
@end
