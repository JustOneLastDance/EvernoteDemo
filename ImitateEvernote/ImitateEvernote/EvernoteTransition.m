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
@property (nonatomic, assign) CGRect originalFrame;
@property (nonatomic, assign) CGRect finalFrame;
@property (nonatomic, strong) UIViewController *panViewController;
@property (nonatomic, strong) UIViewController *listViewController;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;

@end

@implementation EvernoteTransition
/// 初始化参数
///
/// @return 对象EvernoteTransition
- (instancetype)init {
    self = [super init];
    self.isPresent = true;
    self.originalFrame = CGRectZero;
    self.finalFrame = CGRectZero;
    self.panViewController = [[UIViewController alloc] init];
    self.listViewController = [[UIViewController alloc] init];
    self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    return self;
}

- (void)evernoteTransitionWithSelectCell:(JustinCollectionViewCell *)selectCell VisibleCells:(NSMutableArray *)visibleCells OriginalFrame:(CGRect)originalFrame FinalFrame:(CGRect)finalFrame PanViewController:(UIViewController *)panViewController AndListViewController:(UIViewController *)listViewController {
    
    self.selectedCell = selectCell;
    self.visibleCells = visibleCells;
    self.originalFrame = originalFrame;
    self.finalFrame = finalFrame;
    self.panViewController = panViewController;
    self.listViewController = listViewController;
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    pan.edges = UIRectEdgeLeft;
    [self.panViewController.view addGestureRecognizer:pan];
}

#pragma mark - animateTransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *nextVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [transitionContext containerView].backgroundColor = [UIColor colorWithRed:56.0/255.0 green:51.0/255.0 blue:76.0/255.0 alpha:1.0];
    self.selectedCell.frame = self.isPresent ? self.originalFrame : self.finalFrame;
    UIView *addView = nextVC.view;
    addView.hidden = self.isPresent ? true : false;
    [[transitionContext containerView] addSubview:addView];
    
    NSLayoutConstraint *removeCons = self.isPresent ? self.selectedCell.labelLeadCons : self.selectedCell.horizonalCons;
    NSLayoutConstraint *addCons = self.isPresent ? self.selectedCell.horizonalCons : self.selectedCell.labelLeadCons;
    [self.selectedCell removeConstraint:removeCons];
    [self.selectedCell addConstraint:addCons];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        for (JustinCollectionViewCell *visibleCell in self.visibleCells) {
            if (visibleCell != self.selectedCell) {
                CGRect frame = visibleCell.frame;
                if (visibleCell.tag < self.selectedCell.tag) {
                    CGFloat yDistance = self.originalFrame.origin.y - self.finalFrame.origin.y + 30;
                    CGFloat yUpdate = self.isPresent ? yDistance : -yDistance;
                    frame.origin.y -= yUpdate;
                } else if (visibleCell.tag > self.selectedCell.tag) {
                    CGFloat yDistance = CGRectGetMaxY(self.finalFrame) - CGRectGetMaxY(self.originalFrame) + 30;
                    CGFloat yUpdate = self.isPresent ? yDistance : -yDistance;
                    frame.origin.y += yUpdate;
                }
                visibleCell.frame = frame;
                visibleCell.transform = self.isPresent ? CGAffineTransformMakeScale(0.8, 1.0) : CGAffineTransformIdentity;
            }
        }
        
        self.selectedCell.backButton.alpha = self.isPresent ? 1.0 : 0.0;
        self.selectedCell.titleLine.alpha = self.isPresent ? 1.0 : 0.0;
        self.selectedCell.textView.alpha = self.isPresent ? 1.0 : 0.0;
        self.selectedCell.frame = self.isPresent ? self.finalFrame : self.originalFrame;
        [self.selectedCell layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        addView.hidden = false;
        [transitionContext completeTransition:true];
    }];
    
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

- (void)handlePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer {
    UIView *view = self.panViewController.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self.panViewController dismissViewControllerAnimated:true completion:nil];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        CGFloat percentage = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:percentage];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:view].x > 0) {
            [self finishInteractive];
        } else {
            [self.interactionController cancelInteractiveTransition];
            [self.listViewController presentViewController:self.panViewController animated:false completion:nil];
        }
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
}

#pragma mark - NoteViewControllerDelegate
- (void)didClickGoBack {
    [self.panViewController dismissViewControllerAnimated:true completion:nil];
    [self finishInteractive];
}

- (void)finishInteractive {
    [self.interactionController finishInteractiveTransition];
    self.selectedCell.textView.scrollEnabled = true;
}

@end
