/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A view controller displaying a grid of assets.
 */

#import "BaseAssetChooseController.h"

@import UIKit;
@import Photos;

@interface AAPLAssetGridViewController : BaseAssetChooseController

@property (nonatomic, strong) PHAssetCollection *assetCollection;

@end
