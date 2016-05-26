//
//  JustinCollectionViewFlowLayout.m
//  ImitateEvernote
//
//  Created by  justinchou on 16/5/24.
//  Copyright © 2016年  justinchou. All rights reserved.
//

#import "JustinCollectionViewFlowLayout.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

static const CGFloat horizonalPadding = 10;
static const CGFloat verticalPadding = 10;
static const CGFloat cellHeight = 45;
static const CGFloat springFactor = 10;

@implementation JustinCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    CGFloat cellWidth = SCREEN_WIDTH - 2*horizonalPadding;
    self.itemSize = CGSizeMake(cellWidth, cellHeight);
    self.headerReferenceSize = CGSizeMake(cellWidth, verticalPadding);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    CGFloat offsetY = self.collectionView.contentOffset.y;
    NSArray *attrArray = [super layoutAttributesForElementsInRect:rect];
    CGFloat collectionViewFrameHeight = self.collectionView.frame.size.height;
    CGFloat collectionViewContentHeight = self.collectionView.contentSize.height;
    CGFloat scrollViewContentInsetBottom = self.collectionView.contentInset.bottom;
    //底部偏移量
    CGFloat bottomOffSet = offsetY + collectionViewFrameHeight - collectionViewContentHeight - scrollViewContentInsetBottom;
    NSInteger numberOfItems = self.collectionView.numberOfSections;
    
    for (UICollectionViewLayoutAttributes *attr in attrArray) {
        if (attr.representedElementCategory == UICollectionElementCategoryCell) {
            CGRect cellRect = attr.frame;
            if (offsetY <= 0) {
                // 向下滑动
                CGFloat distance = fabs(offsetY) / springFactor;
                cellRect.origin.y += offsetY + distance * (CGFloat)(attr.indexPath.section + 1);
            } else if (bottomOffSet > 0) {
                // 向上滑动
                CGFloat distance = fabs(bottomOffSet) / springFactor;
                cellRect.origin.y += bottomOffSet - distance * (CGFloat)(numberOfItems - attr.indexPath.section);
            }
            
            // cell倾斜
//            CGFloat degrees = M_PI * (-14.0f/180.0f);
//            attr.transform = CGAffineTransformMakeRotation(degrees);
            attr.frame = cellRect;
        }
    }
    return attrArray.copy;
}

@end
