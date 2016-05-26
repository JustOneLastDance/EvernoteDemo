//
//  EvernoteTransition.m
//  ImitateEvernote
//
//  Created by  justinchou on 16/5/26.
//  Copyright © 2016年  justinchou. All rights reserved.
//

#import "EvernoteTransition.h"
#import "JustinNoteViewController.h"
#import "JustinCollectionViewCell.h"

@interface EvernoteTransition() <UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate,NoteViewControllerDelegate>

@property (nonatomic, assign) BOOL isPresent;
@property (nonatomic, strong) JustinCollectionViewCell *selectedCell;
@property (nonatomic, strong) NSMutableArray *visibleCells;
@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, assign) CGRect finalFrame;
@property (nonatomic, strong) UICollectionViewController *panViewController;
@property (nonatomic, strong) UICollectionViewController *listViewController;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;

@end

@implementation EvernoteTransition

#pragma mark - animateTransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.interactionController;
}

#pragma mark - NoteViewControllerDelegate
- (void)didClickGoBack {
    
}

- (void)finishInteractive {
    [self.interactionController finishInteractiveTransition];
}

@end
