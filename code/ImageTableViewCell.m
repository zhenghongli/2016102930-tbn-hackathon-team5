//
//  ImageTableViewCell.m
//  HacktonProject
//
//  Created by I.M.A.C on 2015/11/15.
//  Copyright © 2015年 I.M.A.C. All rights reserved.
//

#import "ImageTableViewCell.h"

@implementation ImageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.customImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        [self.contentView addSubview:self.customImageView];
        self.customImageView.userInteractionEnabled = YES;
        self.customImageView.translatesAutoresizingMaskIntoConstraints = NO;
        NSMutableArray *myConstraints = [NSMutableArray array];
        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_customImageView(88)]"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(_customImageView)]];
        
        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_customImageView(88)]"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(_customImageView)]];
        NSLayoutConstraint *myConstraint;
        myConstraint = [NSLayoutConstraint constraintWithItem:_customImageView attribute:NSLayoutAttributeCenterY
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:[_customImageView superview] attribute:NSLayoutAttributeCenterY
                                                   multiplier:1.0f constant:-0.0f];
        [myConstraints addObject:myConstraint];
        
        myConstraint = [NSLayoutConstraint constraintWithItem:_customImageView attribute:NSLayoutAttributeCenterX
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:[_customImageView superview] attribute:NSLayoutAttributeCenterX
                                                   multiplier:1.0f constant:-0.0f];
        [myConstraints addObject:myConstraint];
        
        [self addConstraints:myConstraints];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
