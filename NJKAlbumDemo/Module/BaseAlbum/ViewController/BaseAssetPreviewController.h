//
//  BaseAssetPreviewController.h
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseAssetPreviewController : UIViewController

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *assetArray;
@property (nonatomic, strong) UICollectionView *browserCollectionView;

@end
