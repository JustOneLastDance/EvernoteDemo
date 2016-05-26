//
//  NoteViewController.h
//  ImitateEvernote
//
//  Created by  justinchou on 16/5/26.
//  Copyright © 2016年  justinchou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoteViewControllerDelegate <NSObject>
@optional
- (void)didClickGoBack;

@end

@interface JustinNoteViewController : UIViewController

@property (nonatomic, weak) id<NoteViewControllerDelegate> noteVCDelegate;

@property (nonatomic, strong) UIColor *domainColor;
@property (nonatomic, copy) NSString *titleName;

@end
