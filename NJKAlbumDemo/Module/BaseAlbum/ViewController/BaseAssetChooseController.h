//
//  BaseAssetChooseController.h
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseAssetChooseController : BaseViewController

@property (nonatomic, strong) UICollectionViewFlowLayout *assetsFlowLayout;
@property (nonatomic, strong) UICollectionView *imageCollectionView;
@property (nonatomic, strong) NSMutableArray *assetArray;

@end
