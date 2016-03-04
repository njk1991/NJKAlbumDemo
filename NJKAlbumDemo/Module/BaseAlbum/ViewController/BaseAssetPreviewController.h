//
//  BaseAssetPreviewController.h
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class BaseAssetPreviewController;

@protocol BaseAssetPreviewControllerDelegate <NSObject>

- (void)previewController:(BaseAssetPreviewController *)controller didClickChooseButton:(UIButton *)sender ;

@end

@interface BaseAssetPreviewController : BaseViewController

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIImage *currentImage;
@property (nonatomic, strong) NSArray *assetArray;
@property (nonatomic, strong) UICollectionView *browserCollectionView;

@property (nonatomic, assign) id<BaseAssetPreviewControllerDelegate> delegate;

@end
