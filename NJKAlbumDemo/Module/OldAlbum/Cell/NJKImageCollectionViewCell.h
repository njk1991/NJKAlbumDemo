//
//  NJKImageCollectionViewCell.h
//  NJKImagePickerDemo
//
//  Created by JiakaiNong on 16/2/4.
//  Copyright © 2016年 poco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAsset;

@interface NJKImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *assetImageView;

- (void)configCellWithImage:(UIImage *)image;

@end
