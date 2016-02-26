//
//  NJKAlbumTableViewCell.h
//  NJKImagePickerDemo
//
//  Created by JiakaiNong on 16/2/3.
//  Copyright © 2016年 poco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAssetsGroup;
@class NJKAssetsCollectionEntity;

@interface NJKAssetsCollectionTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *coverImageView;

- (void)configCellWithCoverImage:(UIImage *)coverImage
                           title:(NSString *)title
                      imageCount:(NSInteger)imageCount;
//- (void)configCellWithAssetsGroup:(ALAssetsGroup *)assetsGroup;
//- (void)configCellWithEntity:(NJKAssetsCollectionEntity *)entity;

@end
