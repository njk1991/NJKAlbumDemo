//
//  NJKAssetBrowserCell.m
//  NJKImagePickerDemo
//
//  Created by JiakaiNong on 16/2/18.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "NJKAssetBrowserCell.h"
#import "VIPhotoView.h"

@interface NJKAssetBrowserCell()

@end

@implementation NJKAssetBrowserCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
    }
    return self;
}

//- (void)willMoveToSuperview:(UIView *)newSuperview {
//    if (newSuperview) {
////        [self.contentView addSubview:self.contentScrollView];
////        [self.contentScrollView addSubview:self.contentImageView];
//    }
//}

//- (void)resizeViews {
//    [self.contentImageView sizeToFit];
//    
//    CGFloat widthScale = CGRectGetWidth(self.frame) / self.contentImage.size.width;
//    CGFloat heightScale = CGRectGetHeight(self.frame) / self.contentImage.size.height;
//    CGFloat minimumZoomScale = widthScale < heightScale ? widthScale : heightScale;
//    CGFloat maximumZoomScale = minimumZoomScale * 3;
//    
//    self.contentScrollView.maximumZoomScale = maximumZoomScale;
//    self.contentScrollView.minimumZoomScale = minimumZoomScale;
////    [self.contentScrollView setZoomScale:minimumZoomScale animated:NO];
//}

//- (void)fadeInContentView {
//    [UIView animateWithDuration:0.3 animations:^{
//        self.contentView.alpha = 1;
//    }];
//}

#pragma mark - Setter & Getter

- (void)setContentImage:(UIImage *)contentImage {
    _contentImage = contentImage;
//    NSLog(@"%@",NSStringFromCGSize(contentImage.size));
//    self.contentImageView.image = contentImage;
//    [self resizeViews];
//    self.contentImageView.alpha = 0;
//    [UIView animateWithDuration:0.3 animations:^{
//        self.contentImageView.alpha = 1;
//    }];
    [self.photoView removeFromSuperview];
    self.photoView = [[VIPhotoView alloc] initWithFrame:self.bounds andImage:contentImage];
    self.photoView.autoresizingMask = (1 << 6) -1;
    [self.contentView addSubview:self.photoView];
//    [self fadeInContentView];
}

//- (UIScrollView *)contentScrollView {
//    if (!_contentScrollView) {
//        _contentScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
//        _contentScrollView.userInteractionEnabled = YES;
////        _contentScrollView.maximumZoomScale = 3.0f;
////        _contentScrollView.minimumZoomScale = 1.0f;
//        _contentScrollView.bouncesZoom = YES;
////        [_contentScrollView setZoomScale:1.0f animated:YES];
//    }
//    return _contentScrollView;
//}
//
//- (UIImageView *)contentImageView {
//    if (!_contentImageView) {
//        _contentImageView = [[UIImageView alloc] initWithFrame:self.bounds];
//        _contentImageView.backgroundColor = [UIColor lightGrayColor];
//        _contentImageView.contentMode = UIViewContentModeScaleAspectFit;
//        _contentImageView.clipsToBounds = YES;
//    }
//    return _contentImageView;
//}

@end
