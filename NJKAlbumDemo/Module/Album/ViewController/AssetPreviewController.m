//
//  AssetPreviewController.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "AssetPreviewController.h"
#import "AssetPreviewCell.h"

#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height
#define SCREEN_SCALE [UIScreen mainScreen].scale
#define CELL_IDENTIFIER @"cellIdentifier"

@interface AssetPreviewController ()

@end

@implementation AssetPreviewController

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.browserCollectionView registerClass:[AssetPreviewCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetsFetchResults.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (AssetPreviewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AssetPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
//    cell.contentView.alpha = 0;
    //    cell.contentScrollView.delegate = self;
    //    cell.contentImageView.alpha = 0;mu
//    AlbumObj *obj = self.assetArray[indexPath.row];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [[ImageDataAPI sharedInstance] getImageForPhotoObj:obj
//                                                  withSize:self.view.bounds.size
//                                                completion:^(BOOL ret, UIImage *image)
//         {
//             //         NSLog(@"%@",NSStringFromCGSize(cell.assetImageView.frame.size));
//             dispatch_async(dispatch_get_main_queue(), ^{
//                 cell.contentImage = image;
//                 //                 [cell.contentScrollView setZoomScale:cell.contentScrollView.minimumZoomScale];
//                 [UIView animateWithDuration:0.3 animations:^{
//                     cell.contentView.alpha = 1;
//                 }];
//             });
//         }];
//    });
//    NSInteger r = [UIScreen mainScreen].scale;
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    [options setSynchronous:NO]; // called exactly once
    
    PHAsset *asset = self.assetsFetchResults[indexPath.row];
    
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset
                            targetSize:CGSizeMake(SCREEN_WIDTH * SCREEN_SCALE, SCREEN_HEIGHT * SCREEN_SCALE)
                           contentMode:PHImageContentModeAspectFit
                               options:options
                         resultHandler:^(UIImage *result, NSDictionary *info)
     {
         cell.contentImage = result;
     }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
}

@end
