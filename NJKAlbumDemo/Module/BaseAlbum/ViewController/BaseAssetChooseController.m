//
//  BaseAssetChooseController.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "BaseAssetChooseController.h"

@interface BaseAssetChooseController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation BaseAssetChooseController

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollToNewestItemEnable = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addSubview:self.imageCollectionView];
    [self initNavigationBar];
}

- (void)viewDidLayoutSubviews {
    self.imageCollectionView.frame = self.view.bounds;
    [self configCollectionViewInsets];
    [self scrollToNewestItemAnimated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self scrollToNewestItemAnimated:NO];
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

- (void)configCollectionViewInsets {
    UIEdgeInsets insets = [self viewInsets];
    self.imageCollectionView.contentInset = UIEdgeInsetsMake(insets.top, insets.left, insets.bottom, insets.right);
}

- (void)scrollToNewestItemAnimated:(BOOL)animated {
    if (self.isScrollToNewestItemEnable) {
        [self.imageCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.assetArray.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:animated];
    }
}

#pragma mark - UIBarButtonItem Action

- (void)rightBarButtonItemAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
}

#pragma mark - Setter & Getter

- (UICollectionViewFlowLayout *)assetsFlowLayout {
    if (!_assetsFlowLayout) {
        CGFloat navigationBarH = 0;
        CGFloat minimumSpacing = 2;
        CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 5 * minimumSpacing) * 0.25;
        
        if (self.navigationController.navigationBar) {
            navigationBarH = CGRectGetHeight(self.navigationController.navigationBar.frame);
        }
        
        UICollectionViewFlowLayout *assetsFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        assetsFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        assetsFlowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
        assetsFlowLayout.minimumInteritemSpacing = minimumSpacing;
        assetsFlowLayout.minimumLineSpacing = minimumSpacing;
        assetsFlowLayout.sectionInset = UIEdgeInsetsMake(navigationBarH + minimumSpacing, minimumSpacing, minimumSpacing, minimumSpacing);
        _assetsFlowLayout = assetsFlowLayout;
    }
    return _assetsFlowLayout;
}

- (UICollectionView *)imageCollectionView {
    if (!_imageCollectionView) {
        _imageCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.assetsFlowLayout];
        _imageCollectionView.backgroundColor = [UIColor clearColor];
        _imageCollectionView.alwaysBounceVertical = YES;
        _imageCollectionView.dataSource = self;
        _imageCollectionView.delegate = self;
    }
    return _imageCollectionView;
}

- (NSMutableArray *)assetArray {
    if (!_assetArray) {
        _assetArray = [@[] mutableCopy];
    }
    return _assetArray;
}

@end
