//
//  NJKAssetBrowserCell.m
//  NJKImagePickerDemo
//
//  Created by JiakaiNong on 16/2/17.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "NJKAssetBrowserCell.h"

@interface NJKAssetBrowserCell()

@end

@implementation NJKAssetBrowserCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.maximumZoomScale = 3.0f;
        self.minimumZoomScale = 1.0f;
        self.bouncesZoom = YES;
        [self setZoomScale:self.minimumZoomScale animated:YES];
        [self initContentImageView];
    }
    return self;
}

- (void)initContentImageView {
    self.contentImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.contentImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.contentImageView.userInteractionEnabled = YES;
    [self addSubview:self.contentImageView];
}

#pragma mark - Setter & Getter

- (void)setContentImage:(UIImage *)contentImage {
    if (_contentImage == contentImage) {
        return;
    }
    _contentImage = contentImage;
    self.contentImageView.image = contentImage;
    [self setContentOffset:CGPointZero];
}

//- (UIImageView *)contentImageView {
//    if (!_contentImageView) {
//        _contentImageView = [[UIImageView alloc] init];
//        _contentImageView.userInteractionEnabled = YES;
//    }
//    return _contentImageView;
//}

- (void)setContentOffset:(CGPoint)anOffset {
    if(self.contentImageView) {
        CGSize zoomViewSize = self.contentImageView.frame.size;
        CGSize scrollViewSize = self.bounds.size;
        
        if(zoomViewSize.width < scrollViewSize.width) {
            anOffset.x = -(scrollViewSize.width - zoomViewSize.width) / 2.0;
        }
        
        if(zoomViewSize.height < scrollViewSize.height) {
            anOffset.y = -(scrollViewSize.height - zoomViewSize.height) / 2.0;
        }
    }
    //此处从super改成self
    super.contentOffset = anOffset;
}

//- (instancetype)init {
//    if (self = [super init]) {
//        self.clipsToBounds = YES;
//        self.showsHorizontalScrollIndicator = NO;
//        self.showsVerticalScrollIndicator = NO;
//        self.minimumZoomScale = 0.1;
//        self.maximumZoomScale = 3;
//        [self initImageView];
//    }
//    return self;
//}
//
//- (void)initImageView {
//    self.imageView = [[UIImageView alloc] init];
//    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.imageView.backgroundColor = [UIColor blackColor];
//    self.imageView.userInteractionEnabled = YES;
//    [self addSubview:self.imageView];
//}
//
//- (void)setImage:(UIImage *)image {
//    _image = image;
//    self.contentSize = self.bounds.size;
//    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//    self.imageView.image = image;
//    NSLog(@"%@",NSStringFromCGRect(self.frame));
//    NSLog(@"%@",NSStringFromCGSize(self.contentSize));
//    NSLog(@"%@",NSStringFromCGRect(self.imageView.frame));
//}
//
//- (void)setFrame:(CGRect)frame {
//    [super setFrame:frame];
//    self.imageView.frame = self.bounds;
//}

@end
