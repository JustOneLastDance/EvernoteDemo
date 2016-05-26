//
//  CollectionViewCell.m
//  ImitateEvernote
//
//  Created by  justinchou on 16/5/26.
//  Copyright © 2016年  justinchou. All rights reserved.
//

#import "JustinCollectionViewCell.h"

@interface JustinCollectionViewCell()

@end

@implementation JustinCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    self.horizonalCons = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
}

@end
