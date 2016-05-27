//
//  EvernoteTransition.h
//  ImitateEvernote
//
//  Created by  justinchou on 16/5/26.
//  Copyright © 2016年  justinchou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JustinCollectionViewCell;

@interface EvernoteTransition : NSObject

/// 转场动画准备参数
///
/// @param selectCell         被选中的cell
/// @param visibleCells       所有可见的cell
/// @param originFrame        原始frame
/// @param finalFrame         最终frame
/// @param panViewController  手势可拖动的vc
/// @param listViewController 列表vc
- (void)evernoteTransitionWithSelectCell:(JustinCollectionViewCell *)selectCell VisibleCells:(NSMutableArray *)visibleCells OriginalFrame:(CGRect)originalFrame FinalFrame:(CGRect)finalFrame PanViewController:(UIViewController *)panViewController AndListViewController:(UIViewController *)listViewController;

@end
