//
//  ViewController.m
//  ImitateEvernote
//
//  Created by  justinchou on 16/5/24.
//  Copyright © 2016年  justinchou. All rights reserved.
//

#import "ViewController.h"
#import "JustinCollectionViewFlowLayout.h"
#import "JustinCollectionViewCell.h"
#import "JustinNoteViewController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

static const NSInteger rowNumber = 20;
static const CGFloat topPadding = 20;
static NSString *kReuseIdentiyID = @"kReuseIdentiyID";


@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
/// 渐变色
@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end
@implementation ViewController

#pragma maek - lazy loading
- (NSMutableArray *)colorArray {
    if (_colorArray == nil) {
        _colorArray = [NSMutableArray array];
        for (int i = 0; i < rowNumber; i++) {
//            UIColor *color = [UIColor colorWithHue:(100 + i*6) % 360 / 360 saturation:0.8 brightness:1.0 alpha:1.0];
            UIColor *color = [UIColor colorWithRed: i * 10/255.0 green:(255.0 - i*10)/255.0 blue:100.0/255.0 alpha:1.0];
            [_colorArray addObject:color];
        }
        
    }
    return _colorArray;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, topPadding, SCREEN_WIDTH, SCREEN_HEIGHT - topPadding) collectionViewLayout: [[JustinCollectionViewFlowLayout alloc] init]];
        
        _collectionView.backgroundColor = [UIColor colorWithRed:56.0/255.0 green:51.0/255.0 blue:76.0/255.0 alpha:1.0];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = false;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, topPadding, 0);
    }
    return _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:56.0/255.0 green:51.0/255.0 blue:76.0/255.0 alpha:1.0];
    [self.view addSubview:self.collectionView];
    UINib *nib = [UINib nibWithNibName:@"JustinCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:kReuseIdentiyID];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.colorArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JustinCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentiyID forIndexPath:indexPath];
    
    cell.backgroundColor = self.colorArray[indexPath.section];
    cell.titleLabel.text = [NSString stringWithFormat:@"HelloWorld + %ld", (indexPath.section + (long)1)];
    cell.backButton.alpha = 0.0;
    cell.textView.alpha = 0.0;
    cell.titleLine.alpha = 0.0;
    cell.tag = indexPath.section;
    
    return cell;
}

#pragma maek - UICollectionViewDelegate 
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JustinCollectionViewCell *cell = (JustinCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"evernote" bundle:nil];
    JustinNoteViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Note"];
    vc.domainColor = cell.backgroundColor;
    vc.titleName = cell.titleLabel.text;
    
    [self presentViewController:vc animated:true completion:nil];
    
}

@end
