//
//  NoteViewController.m
//  ImitateEvernote
//
//  Created by  justinchou on 16/5/26.
//  Copyright © 2016年  justinchou. All rights reserved.
//

#import "JustinNoteViewController.h"

@interface JustinNoteViewController()

@property (weak, nonatomic) IBOutlet UIView *totalView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation JustinNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.totalView.layer.cornerRadius = 5.0;
    self.totalView.layer.masksToBounds = YES;
    self.totalView.backgroundColor = self.domainColor;
    self.titleLabel.text = self.titleName;
    self.textView.contentOffset = CGPointMake(0.0, 0.0);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.textView addGestureRecognizer:tap];

}

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    [self.textView endEditing:true];
}

- (IBAction)didClickButton {
    if ([self.noteVCDelegate respondsToSelector:@selector(didClickGoBack)]) {
        [self.noteVCDelegate didClickGoBack];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
