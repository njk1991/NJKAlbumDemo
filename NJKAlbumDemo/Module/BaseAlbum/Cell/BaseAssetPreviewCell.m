//
//  BaseAssetPreviewCell.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "BaseAssetPreviewCell.h"
#import "VIPhotoView.h"

@interface BaseAssetPreviewCell()

@property (nonatomic, strong) VIPhotoView *photoView;

@end

@implementation BaseAssetPreviewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
    }
    return self;
}
#pragma mark - Setter & Getter

- (void)setContentImage:(UIImage *)contentImage {
    _contentImage = contentImage;
    [self.photoView removeFromSuperview];
    self.photoView = [[VIPhotoView alloc] initWithFrame:self.bounds andImage:contentImage];
    self.photoView.autoresizingMask = (1 << 6) -1;
    [self.contentView addSubview:self.photoView];
}

@end
