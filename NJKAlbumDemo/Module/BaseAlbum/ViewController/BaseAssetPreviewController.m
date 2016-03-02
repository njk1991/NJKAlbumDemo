//
//  BaseAssetPreviewController.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "BaseAssetPreviewController.h"

@interface BaseAssetPreviewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

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
    [self initNavigationBar];
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
    CGFloat pedding = 10;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setItemSize:CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [flowLayout setMinimumInteritemSpacing:0];
    [flowLayout setMinimumLineSpacing:0];
    [flowLayout setSectionInset:UIEdgeInsetsMake(pedding, 0, pedding, 0)];
    return flowLayout;
}

- (UICollectionView *)browserCollectionView {
    if (!_browserCollectionView) {
        _browserCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:[self flowLayout]];
        _browserCollectionView.dataSource = self;
        _browserCollectionView.delegate = self;
        _browserCollectionView.pagingEnabled = YES;
        _browserCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _browserCollectionView;
}

@end
