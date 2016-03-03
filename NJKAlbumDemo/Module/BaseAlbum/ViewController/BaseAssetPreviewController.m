//
//  BaseAssetPreviewController.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "BaseAssetPreviewController.h"

@interface BaseAssetPreviewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *chooseButton;

@end

@implementation BaseAssetPreviewController

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addSubview:self.browserCollectionView];
    [self.view addSubview:self.chooseButton];
//    [self initNavigationBar];
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
    [self.browserCollectionView scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
}

- (void)initNavigationBar {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
}

#pragma mark - UIBarButtonItem Action

- (void)rightBarButtonItemAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollView subviews][0];
}

#pragma mark - Setter & Getter

- (UICollectionViewFlowLayout *)flowLayout {
    UIEdgeInsets insets = [self viewInsets];
    CGFloat pedding = 0;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setItemSize:CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - (insets.top + insets.bottom) - (2 * pedding))];
    [flowLayout setMinimumInteritemSpacing:0];
    [flowLayout setMinimumLineSpacing:0];
    [flowLayout setSectionInset:UIEdgeInsetsMake(pedding, 0, pedding, 0)];
    return flowLayout;
}

- (UICollectionView *)browserCollectionView {
    if (!_browserCollectionView) {
        _browserCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:[self flowLayout]];
        _browserCollectionView.backgroundColor = [UIColor clearColor];
        _browserCollectionView.dataSource = self;
        _browserCollectionView.delegate = self;
        _browserCollectionView.pagingEnabled = YES;
        _browserCollectionView.showsHorizontalScrollIndicator = NO;
        
        UIEdgeInsets insets = [self viewInsets];
        _browserCollectionView.contentInset = UIEdgeInsetsMake(insets.top, insets.left, insets.bottom, insets.right);
    }
    return _browserCollectionView;
}

- (UIButton *)chooseButton {
    if (!_chooseButton) {
        CGFloat buttonWidth = 50;
        CGFloat rightInset = 8;
        CGFloat bottomInset = 19;
        
        UIEdgeInsets insets = [self viewInsets];
        
        UIButton *chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        chooseButton.frame = CGRectMake(self.view.bounds.size.width - (rightInset + buttonWidth), self.view.bounds.size.height - (bottomInset + buttonWidth + insets.bottom), buttonWidth, buttonWidth);
        [chooseButton setImage:[UIImage imageNamed:@"AlbumChoosePlus"] forState:UIControlStateNormal];
        [chooseButton setImage:[UIImage imageNamed:@"AlbumChoosePlus_hover"] forState:UIControlStateHighlighted];
        _chooseButton = chooseButton;
    }
    return _chooseButton;
}

@end
