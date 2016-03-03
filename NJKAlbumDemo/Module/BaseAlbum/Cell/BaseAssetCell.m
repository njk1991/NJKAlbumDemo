//
//  BaseAssetCell.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "BaseAssetCell.h"

@interface BaseAssetCell()

@property (nonatomic, strong) UIButton *topRightButton;

@end

@implementation BaseAssetCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.assetImageView];
        [self.contentView addSubview:self.topRightButton];
    }
    return self;
}

- (void)configCellWithImage:(UIImage *)image {
    self.assetImageView.image = image;
}

#pragma mark - BaseAssetCellDelegate

- (void)topRightButtonDidClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(assetsCell:didClickTopRightButton:)]) {
        [self.delegate assetsCell:self didClickTopRightButton:sender];
    }
}

#pragma mark - Setter & Getter

- (UIButton *)topRightButton {
    if (!_topRightButton) {
        CGFloat buttonWidth = 30;
        CGFloat pedding = 3;
        
        UIButton *topRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        topRightButton.frame = CGRectMake(self.contentView.frame.size.width - (pedding + buttonWidth), pedding, buttonWidth, buttonWidth);
        [topRightButton setImage:[UIImage imageNamed:@"AlbumMagnifyImage"] forState:UIControlStateNormal];
        [topRightButton addTarget:self action:@selector(topRightButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        _topRightButton = topRightButton;
    }
    return _topRightButton;
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
