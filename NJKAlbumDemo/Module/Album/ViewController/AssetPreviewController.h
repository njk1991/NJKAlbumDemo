//
//  AssetPreviewController.h
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "BaseAssetPreviewController.h"

@interface AssetPreviewController : BaseAssetPreviewController

@property (nonatomic, strong) PHFetchResult *assetsFetchResults;

@end
