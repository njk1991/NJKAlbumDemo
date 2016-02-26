//
//  NJKAssetBrowserCell.h
//  NJKImagePickerDemo
//
//  Created by JiakaiNong on 16/2/18.
//  Copyright © 2016年 poco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VIPhotoView;

@interface NJKAssetBrowserCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *contentImage;
//@property (nonatomic, strong) UIImageView *contentImageView;
//@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) VIPhotoView *photoView;

@end
