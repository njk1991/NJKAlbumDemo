//
//  BaseAlbumCell.h
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseAlbumCell : UITableViewCell

@property (nonatomic, strong) UIImageView *coverImageView;

- (void)configCellWithCoverImage:(UIImage *)coverImage
                           title:(NSString *)title
                      imageCount:(NSInteger)imageCount;

@end
