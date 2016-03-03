//
//  BaseAssetCell.h
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseAssetCell;

@protocol BaseAssetCellDelegate <NSObject>

- (void)assetsCell:(BaseAssetCell *)cell didClickTopRightButton:(UIButton *)sender ;

@end

@interface BaseAssetCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *assetImageView;
@property (nonatomic, assign) id<BaseAssetCellDelegate> delegate;

- (void)configCellWithImage:(UIImage *)image;

@end
