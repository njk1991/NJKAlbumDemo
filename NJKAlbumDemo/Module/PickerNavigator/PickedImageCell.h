//
//  PickedImageCell.h
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/3/3.
//  Copyright © 2016年 poco. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>

@class PickedImageCell;

@protocol PickedImageCellDelegate <NSObject>

- (void)assetsCell:(PickedImageCell *)cell didClickDeleteButton:(UIButton *)sender ;

@end

@interface PickedImageCell : UICollectionViewCell

@property (nonatomic, assign) id<PickedImageCellDelegate> delegate;

- (void)configCellWithImage:(UIImage *)image;

@end