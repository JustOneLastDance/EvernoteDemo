//
//  CollectionViewCell.h
//  ImitateEvernote
//
//  Created by  justinchou on 16/5/26.
//  Copyright © 2016年  justinchou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JustinCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *titleLine;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelLeadCons;
@property (nonatomic, strong) NSLayoutConstraint *horizonalCons;

@end
