//
//  ContentViewController.m
//  TestPage
//
//  Created by I.M.A.C on 2015/6/15.
//  Copyright (c) 2015年 I.M.A.C. All rights reserved.
//



#import "ContentViewController.h"
#import "TempCollectionViewCell.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "CHTCollectionViewWaterfallFooter.h"
//#import "ProductController.h"
#import "CarbonSwipeRefresh.h"
#import "NSString+Hashes.h"
//#import "MultipleGradientView.h"


#define CELL_COUNT 30
#define CELL_IDENTIFIER @"WaterfallCell"
#define HEADER_IDENTIFIER @"WaterfallHeader"
#define FOOTER_IDENTIFIER @"WaterfallFooter"


@interface ContentViewController () <TempCollectionViewCellDelegate>
{
    CarbonSwipeRefresh *refresh;
}
@property (nonatomic, strong) NSMutableArray *cellSizes;
@property CGFloat cellWidth;
@property CGFloat preY;
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic) NSInteger didUpdateIndex;
@end

@implementation ContentViewController

#pragma mark - Accessors

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.headerHeight = 0;
        layout.columnCount = self.columsCount;
        layout.footerHeight = 0;
        CGFloat onepWidth = CGRectGetWidth([UIScreen mainScreen].bounds) / 100.0;
        layout.sectionInset = UIEdgeInsetsMake(onepWidth, onepWidth, onepWidth, onepWidth);
        layout.minimumColumnSpacing = onepWidth * 2;
        layout.minimumInteritemSpacing = onepWidth * 2;
//        layout.minimumContentHeight = [UIScreen mainScreen].bounds.size.height;
        self.cellWidth = CGRectGetWidth([UIScreen mainScreen].bounds)/self.columsCount ;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil]forCellWithReuseIdentifier:CELL_IDENTIFIER];
        [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                   withReuseIdentifier:HEADER_IDENTIFIER];
        [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                   withReuseIdentifier:FOOTER_IDENTIFIER];
        
        _collectionView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        _collectionView.alwaysBounceVertical = YES;
        

    }
    return _collectionView;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.isDragging) {
        if (scrollView.contentOffset.y  < 0 || scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height) {
            return;
        }
        CGFloat offset = self.preY - scrollView.contentOffset.y;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"YOFFSET" object:@(offset)];
        self.preY = scrollView.contentOffset.y;
    }
}

- (NSMutableArray *)cellSizes {
    _cellSizes = [NSMutableArray array];
    if (self.data != nil) {
        for (NSInteger i = 0; i < self.data.count; i++) {
            NSString *imageString = self.data[i][@"Images"];
            imageString = [imageString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
            NSData *data = [imageString dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
            CGSize size;
            if ([json.lastObject[@"Width"] floatValue] < self.cellWidth) {
                size = CGSizeMake(self.cellWidth, [json.lastObject[@"Height"] floatValue]);
            } else {
                CGFloat f = self.cellWidth / [json.lastObject[@"Width"] floatValue]  ;
                size = CGSizeMake(self.cellWidth, [json.lastObject[@"Height"] floatValue] * f + 44);
            }
            
            _cellSizes[i] = [NSValue valueWithCGSize:size];
        }
    }
    return _cellSizes;
}


#pragma mark - Life Cycle

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    
}

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
//    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (!self.data)
        return 0;
    return self.data.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TempCollectionViewCell *cell =
    (TempCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                                forIndexPath:indexPath];
    
    NSString *imageString = self.data[indexPath.item][@"Images"];
    imageString = [imageString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    NSData *data = [imageString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingMutableContainers
                                                      error:nil];

        cell.showAction = NO;
    
    
    if ([self.data[indexPath.item][@"Type"] integerValue] <= 2) {
        cell.imageName = json[0][@"Image"];
    }
    else {
        cell.imageName = json.lastObject[@"Image"];
    }
    cell.userInteractionEnabled = YES;
    cell.userImageFileName = self.data[indexPath.item][@"UserImage"];
    cell.userName = self.data[indexPath.item][@"UserName"];
    cell.actionName = [NSString stringWithFormat:@"%ld", [self.data[indexPath.item][@"Type"] integerValue]] ;
    cell.descriptionText = self.data[indexPath.item][@"ShortTitle"];
    cell.isLike = ((NSNumber *)self.data[indexPath.item][@"IsLike"]).boolValue;
    cell.subDescriptionText = [NSString stringWithFormat:@"%@", self.data[indexPath.item][@"LikeNum" ]];
    cell.tag = [self.data[indexPath.item][@"PID"] integerValue];
    cell.index = indexPath.item;
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    

    
//    cell.clipsToBounds = NO;
//    cell.tag = indexPath.item;
    cell.delegate = self;
//
    
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"indexPath: %d",indexPath.item);
    typeof(self) __weak weakSelf = self;
    if([indexPath item] == self.data.count-1) {
        self.didUpdateIndex = self.data.count - 1;
        NSLog(@"%@", self.data[indexPath.item][@"CreateTime"]);
//        [[HTTPClient shareInstance] listWithUID:[UserInfo shareInstance].uId token:[UserInfo shareInstance].token type:self.type productType:self.productType searchID:self.searchId time:self.data[indexPath.item][@"CreateTime"] page:5 orderType:1 success:^(NSDictionary *response) {
//            typeof(weakSelf) __strong strongSelf = self;
//            if (self.data) {
//                NSInteger index = self.data.count ;
//                [strongSelf.data addObjectsFromArray:[response[@"Data"] copy]];
//                NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
//                for (NSInteger i = index; i < self.data.count; i++) {
//                    [arrayWithIndexPaths addObject:[NSIndexPath indexPathForItem:i
//                                                                      inSection:0]];
//                }
//                [strongSelf.collectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
//            }
//        } errorResponse:^(NSString *errorMessage) {
//            
//        } failure:^(NSError *error) {
//            
//        }];
        
    } else if (indexPath.item < self.currentIndex && indexPath.item < self.didUpdateIndex-1) {
//        NSLog(@"%@",self.data[indexPath.item+1][@"CreateTime"]);
//        [[HTTPClient shareInstance] listWithUID:[UserInfo shareInstance].uId.integerValue token:[UserInfo shareInstance].token type:self.type time:self.data[indexPath.item+1][@"CreateTime"] page:INT32_MAX orderType:0 success:^(NSDictionary *response) {
////            NSLog(@"%@",response[@"Data"]);
//            if (self.data) {
//                NSUInteger count = ((NSArray *)response[@"Data"]).count;
////                NSLog(@"data count: %d",count);
//                self.didUpdateIndex = indexPath.item - ((NSArray *)response[@"Data"]).count;
//                
//                for (int i = 0; i < (count >= 10 ? 10:count); ++i) {
//                    NSInteger index = indexPath.item - i;
////                    NSLog(@"id = %@", self.data[index][@"CreateTime"]);
////                    NSLog(@"re = %@", ((NSArray *)response[@"Data"])[count-i-1][@"CreateTime"]);
//                    
//                    [self.data replaceObjectAtIndex:indexPath.item-i withObject:[((NSArray *)response[@"Data"])[count-i-1] copy]];
//                }
//                [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
//
//            }
//        } errorResponse:^(NSString *errorMessage) {
//            
//        } failure:^(NSError *error) {
//            
//        }];
    }
    self.currentIndex = indexPath.item;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:HEADER_IDENTIFIER
                                                                 forIndexPath:indexPath];
    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:FOOTER_IDENTIFIER
                                                                 forIndexPath:indexPath];
    }
    
    return reusableView;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    ProductController *productController = [[ProductController alloc] initWithData:@{@"Data" :self.data[indexPath.item]} ];
//    NSLog(@"%@", NSStringFromCGSize([self.cellSizes[indexPath.item] CGSizeValue]));
//    productController.index = indexPath.item;
//    productController.delegate = self;
//    [self presentViewController:productController animated:YES completion:nil];
}

- (void)showAlertViewWithMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Catchy" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellSizes[indexPath.item] CGSizeValue];
}

#pragma mark - TempCollectionViewCell Delegate
- (void)changeData:(NSDictionary *)data index:(NSInteger)index {
    if (index != -1) {
        NSMutableDictionary *newDictionary =[NSMutableDictionary dictionaryWithDictionary:self.data[index]];
        if (data[@"LikeNum"]) {
            newDictionary[@"LikeNum"] = data[@"LikeNum"];
        }
        if (data[@"isLike"]) {
            newDictionary[@"IsLike"] = data[@"isLike"]  ;
        }
        if (data[@"VoteNum"]) {
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:self.data[index][@"vote_num"]];
            for (NSString *key in [data[@"VoteNum"] allKeys]) {
                tempDic[key] = data[@"VoteNum"][key];
            }
            newDictionary[@"vote_num"] = tempDic;
        }
        if (data[@"IsVote"]) {
            newDictionary[@"IsVote"] = data[@"IsVote"];
        }
        self.data[index] = newDictionary;
        [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
    } else {
        NSLog(@"Error : Index is -1");
    }
}

@end
