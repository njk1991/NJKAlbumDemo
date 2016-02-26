//
//  NJKAssetBrowserController.m
//  NJKImagePickerDemo
//
//  Created by JiakaiNong on 16/2/18.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "NJKAssetBrowserController.h"
#import "NJKAssetBrowserCell.h"
#import "ImageDataAPI.h"

@interface NJKAssetBrowserController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *browserCollectionView;

@end

@implementation NJKAssetBrowserController

static NSString * const kReuseIdentifier = @"kReuseIdentifier";

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBrowserCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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

#pragma mark - Init Method

- (void)initBrowserCollectionView {
    
    CGFloat pedding = 10;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setItemSize:CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [flowLayout setMinimumInteritemSpacing:0];
    [flowLayout setMinimumLineSpacing:0];
    [flowLayout setSectionInset:UIEdgeInsetsMake(pedding, 0, pedding, 0)];
    
    
    self.browserCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.browserCollectionView.dataSource = self;
    self.browserCollectionView.delegate = self;
    self.browserCollectionView.pagingEnabled = YES;
    self.browserCollectionView.showsHorizontalScrollIndicator = NO;
    [self.browserCollectionView registerClass:[NJKAssetBrowserCell class] forCellWithReuseIdentifier:kReuseIdentifier];
    
    
    [self.view addSubview:self.browserCollectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetsArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NJKAssetBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
    cell.contentView.alpha = 0;
//    cell.contentScrollView.delegate = self;
//    cell.contentImageView.alpha = 0;mu
    AlbumObj *obj = self.assetsArray[indexPath.row];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[ImageDataAPI sharedInstance] getImageForPhotoObj:obj
                                                  withSize:self.view.bounds.size
                                                completion:^(BOOL ret, UIImage *image)
         {
             //         NSLog(@"%@",NSStringFromCGSize(cell.assetImageView.frame.size));
             dispatch_async(dispatch_get_main_queue(), ^{
                 cell.contentImage = image;
//                 [cell.contentScrollView setZoomScale:cell.contentScrollView.minimumZoomScale];
                 [UIView animateWithDuration:0.3 animations:^{
                     cell.contentView.alpha = 1;
                 }];
             });
         }];
    });
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollView subviews][0];
}

@end
