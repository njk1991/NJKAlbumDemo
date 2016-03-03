//
//  PickedImageCell.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/3/3.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "PickedImageCell.h"

@interface PickedImageCell()

@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PickedImageCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.deleteButton];
    }
    return self;
}

- (void)configCellWithImage:(UIImage *)image {
    self.imageView.image = image;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *result = [super hitTest:point withEvent:event];
    CGPoint hitPoint = [self.deleteButton convertPoint:point fromView:self];
    if ([self.deleteButton pointInside:hitPoint withEvent:event]) {
        return self.deleteButton;
    }
    return result;
}

#pragma mark - BaseAssetCellDelegate

- (void)deleteButtonDidClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(assetsCell:didClickDeleteButton:)]) {
        [self.delegate assetsCell:self didClickDeleteButton:sender];
    }
}

#pragma mark - Setter & Getter

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        CGFloat buttonWidth = 21;
        
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame = CGRectMake(0, 0, buttonWidth, buttonWidth);
        deleteButton.center = CGPointZero;
        [deleteButton setImage:[UIImage imageNamed:@"AlbumDeletePrune"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"AlbumDeletePrune_hover"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton = deleteButton;
    }
    return _deleteButton;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        
//        _imageView.backgroundColor = [UIColor blackColor];
        _imageView.layer.cornerRadius = 3;
        _imageView.layer.borderWidth = 0;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

@end
