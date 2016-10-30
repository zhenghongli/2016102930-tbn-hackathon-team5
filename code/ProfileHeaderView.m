//
//  ProfileHeaderView.m
//  HacktonProject
//
//  Created by I.M.A.C on 2015/11/15.
//  Copyright © 2015年 I.M.A.C. All rights reserved.
//

#import "ProfileHeaderView.h"
#import "UIColor+Decoder.h"
@implementation ProfileHeaderView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(8, 22, 33, 33)];
        [self.backButton setImage:[UIImage imageNamed:@"Back Arrow"] forState:UIControlStateNormal];
        [self addSubview:self.backButton];
        
        [self.backButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSMutableArray *myConstraints = [NSMutableArray array];
        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_backButton(33)]"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(_backButton)]];
        
        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-22-[_backButton(33)]"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(_backButton)]];
        [self addConstraints:myConstraints];
        
        
        self.sumitButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.bounds)-44-8, 22, 33, 33)];
        [self.sumitButton setImage:[UIImage imageNamed:@"checkmark"] forState:UIControlStateNormal];
        [self addSubview:self.sumitButton];
        
        [self.sumitButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        myConstraints = [NSMutableArray array];
        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_sumitButton(33)]-8-|"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(_sumitButton)]];
        
        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-22-[_sumitButton(33)]"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(_sumitButton)]];
        [self addConstraints:myConstraints];
        
        
        
        self.userHeaderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Username"]];
        self.userHeaderImageView.userInteractionEnabled = YES;
        [self addSubview:self.userHeaderImageView];
        
        [self.userHeaderImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        myConstraints = [NSMutableArray array];
        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[_userHeaderImageView(%.0f)]", ceil(0.41f * CGRectGetHeight(frame))]
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(_userHeaderImageView)]];
        
        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[_userHeaderImageView(%.0f)]", ceil(0.41f * CGRectGetHeight(frame))]
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(_userHeaderImageView)]];
        NSLayoutConstraint *myConstraint;

        myConstraint = [NSLayoutConstraint constraintWithItem:_userHeaderImageView attribute:NSLayoutAttributeCenterY
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:[_userHeaderImageView superview] attribute:NSLayoutAttributeCenterY
                                                   multiplier:1.0f constant:-0.0f];
        [myConstraints addObject:myConstraint];
        
        myConstraint = [NSLayoutConstraint constraintWithItem:_userHeaderImageView attribute:NSLayoutAttributeCenterX
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:[_userHeaderImageView superview] attribute:NSLayoutAttributeCenterX
                                                   multiplier:1.0f constant:-0.0f];
        [myConstraints addObject:myConstraint];

        [self addConstraints:myConstraints];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.text = @"Profile";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:label];
        
        myConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:[label superview] attribute:NSLayoutAttributeCenterX
                                                   multiplier:1.0f constant:-0.0f];
        [self addConstraint:myConstraint];
        myConstraints = [NSMutableArray array];
        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label(33)]-|"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(label)]];
        [self addConstraints:myConstraints];
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
        
        self.userHeaderImageView.layer.cornerRadius = CGRectGetWidth(self.userHeaderImageView.frame) / 2.0f;
        self.userHeaderImageView.layer.masksToBounds = YES;
        self.userHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.backgroundColor = [UIColor colorWithHexString:@"#3AD6ED"];
        
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:shadowView];
        shadowView.translatesAutoresizingMaskIntoConstraints = NO;
        myConstraints = [NSMutableArray array];
        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:[shadowView(5)]-0-|"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(shadowView)]];
        [self addConstraints:myConstraints];
        
        myConstraints = [NSMutableArray array];
        [myConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[shadowView]-0-|"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(shadowView)]];
        shadowView.backgroundColor = [UIColor whiteColor];
        shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        shadowView.layer.shadowOffset = CGSizeMake(0, 1);
        shadowView.layer.shadowRadius = 1;
        shadowView.layer.shadowOpacity = 0.5;
        [self addConstraints:myConstraints];

        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
