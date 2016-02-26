//
//  NJKAssetBrowserController.m
//  NJKImagePickerDemo
//
//  Created by JiakaiNong on 16/2/16.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "NJKAssetBrowserController.h"
#import "ImageDataAPI.h"
#import "NJKAssetBrowserCell.h"

@interface NJKAssetBrowserController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableSet *visibleViews;
@property (nonatomic, strong) NSMutableSet *reusedViews;
@property (nonatomic, strong) UIScrollView *assetsScrollView;

@end

@implementation NJKAssetBrowserController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAssetsScrollView];
    [self showImageAtIndex:self.currentIndex];
}

//#pragma mark Init Views
//
//// 添加UIScrollView
//- (void)setupScrollView {
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    scrollView.pagingEnabled = YES;
//    scrollView.delegate = self;
//    scrollView.showsHorizontalScrollIndicator = NO;
//    scrollView.showsVerticalScrollIndicator = NO;
//    scrollView.contentSize = CGSizeMake(self.assetsArray.count * CGRectGetWidth(scrollView.frame), 0);
//    scrollView.contentOffset = CGPointMake(self.currentIndex * self.view.frame.size.width, 0);
//    [self.view addSubview:scrollView];
//    _scrollView = scrollView;
//    [self showImageAtIndex:self.currentIndex];
//}

- (void)initAssetsScrollView {
    self.assetsScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.assetsScrollView setBackgroundColor:[UIColor redColor]];
    [self.assetsScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.assetsScrollView setShowsVerticalScrollIndicator:NO];
    [self.assetsScrollView setShowsHorizontalScrollIndicator:NO];
    [self.assetsScrollView setBouncesZoom:NO];
    self.assetsScrollView.pagingEnabled = YES;
    self.assetsScrollView.bounces = NO;
    
    self.assetsScrollView.contentSize = CGSizeMake(self.assetsArray.count * CGRectGetWidth(_assetsScrollView.frame), 0);
    self.assetsScrollView.contentOffset = CGPointMake(self.currentIndex * CGRectGetWidth(_assetsScrollView.frame), 0);
    
    [self.view addSubview:self.assetsScrollView];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self showImages];
}

- (UIView *)viewForZoomingInScrollView:(NJKAssetBrowserCell *)scrollView {
    return scrollView.contentImageView;
}

#pragma mark - Private Method

- (void)showImages {
    
    // 获取当前处于显示范围内的图片的索引
    CGRect visibleBounds = self.assetsScrollView.bounds;
    CGFloat minX = CGRectGetMinX(visibleBounds);
    CGFloat maxX = CGRectGetMaxX(visibleBounds);
    CGFloat width = CGRectGetWidth(visibleBounds);
    
    NSInteger firstIndex = (NSInteger)floorf(minX / width);
    NSInteger lastIndex  = (NSInteger)floorf(maxX / width);
    
    // 处理越界的情况
    if (firstIndex < 0) {
        firstIndex = 0;
    }
    
    if (lastIndex >= [self.assetsArray count]) {
        lastIndex = [self.assetsArray count] - 1;
    }
    
    // 回收不再显示的ImageView
    NSInteger cellIndex = 0;
    for (NJKAssetBrowserCell *cell in self.visibleViews) {
        cellIndex = cell.tag;
        // 不在显示范围内
        if (cellIndex < firstIndex || cellIndex > lastIndex) {
            cell.contentImage = nil;
            [self.reusedViews addObject:cell];
            [cell removeFromSuperview];
        }
    }
    
    [self.visibleViews minusSet:self.reusedViews];
    
    // 是否需要显示新的视图
    for (NSInteger index = firstIndex; index <= lastIndex; index++) {
        BOOL isShow = NO;
        
        for (NJKAssetBrowserCell *cell in self.visibleViews) {
            if (cell.tag == index) {
                isShow = YES;
            }
        }
        
        if (!isShow) {
            [self showImageAtIndex:index];
        }
    }
}

// 显示一个图片view
- (void)showImageAtIndex:(NSInteger)index {
    
    NJKAssetBrowserCell *cell = [self.reusedViews anyObject];
    
    if (cell) {
        [self.reusedViews removeObject:cell];
    } else {
        cell = [[NJKAssetBrowserCell alloc] initWithFrame:self.assetsScrollView.bounds];
        cell.delegate = self;
    }
    
    CGRect cellFrame = self.assetsScrollView.bounds;
    cellFrame.origin.x = CGRectGetWidth(cellFrame) * index;
    cell.tag = index;
    cell.frame = cellFrame;
    //GCD
    AlbumObj *obj = self.assetsArray[index];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[ImageDataAPI sharedInstance] getImageForPhotoObj:obj
                                                      withSize:self.view.bounds.size
                                                    completion:^(BOOL ret, UIImage *image)
         {
             //         NSLog(@"%@",NSStringFromCGSize(cell.assetImageView.frame.size));
             dispatch_async(dispatch_get_main_queue(), ^{
                 cell.contentImage = image;
             });
         }];
    });
    
    [self.visibleViews addObject:cell];
    [self.assetsScrollView addSubview:cell];
}

#pragma mark - Setter & Getter

- (NSMutableSet *)visibleViews {
    if (_visibleViews == nil) {
        _visibleViews = [[NSMutableSet alloc] init];
    }
    return _visibleViews;
}

- (NSMutableSet *)reusedViews {
    if (_reusedViews == nil) {
        _reusedViews = [[NSMutableSet alloc] init];
    }
    return _reusedViews;
}

//- (UIScrollView *)assetsScrollView {
//    if (!_assetsScrollView) {
//        _assetsScrollView = [[UIScrollView alloc] init];
//        [_assetsScrollView setBackgroundColor:[UIColor redColor]];
//        [_assetsScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
//        [_assetsScrollView setShowsVerticalScrollIndicator:NO];
//        [_assetsScrollView setShowsHorizontalScrollIndicator:NO];
//        [_assetsScrollView setBouncesZoom:NO];
//        _assetsScrollView.pagingEnabled = YES;
//        _assetsScrollView.bounces = NO;
//        
//        _assetsScrollView.contentSize = CGSizeMake(self.assetsArray.count * CGRectGetWidth(_assetsScrollView.frame), 0);
//        _assetsScrollView.contentOffset = CGPointMake(self.currentIndex * CGRectGetWidth(_assetsScrollView.frame), 0);
//    }
//    return _assetsScrollView;
//}

@end

