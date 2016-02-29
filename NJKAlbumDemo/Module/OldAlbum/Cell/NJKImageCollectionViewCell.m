//
//  NJKImageCollectionViewCell.m
//  NJKImagePickerDemo
//
//  Created by JiakaiNong on 16/2/4.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "NJKImageCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface NJKImageCollectionViewCell()

@end

@implementation NJKImageCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.assetImageView];
    }
    return self;
}

- (void)configCellWithImage:(UIImage *)image {
    self.assetImageView.image = image;
}

- (UIImageView *)assetImageView {
    if (!_assetImageView) {
        _assetImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _assetImageView.contentMode = UIViewContentModeScaleAspectFill;
        _assetImageView.clipsToBounds = YES;
    }
    return _assetImageView;
}

@end
