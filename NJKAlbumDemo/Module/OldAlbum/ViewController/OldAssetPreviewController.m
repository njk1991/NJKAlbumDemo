//
//  OldAssetPreviewController.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/29.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "OldAssetPreviewController.h"
#import "OldAssetPreviewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define CELL_IDENTIFIER @"cellIdentifier"

@interface OldAssetPreviewController ()

@end

@implementation OldAssetPreviewController

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.browserCollectionView registerClass:[OldAssetPreviewCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
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
    return self.assetArray.count;
}

- (OldAssetPreviewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OldAssetPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    ALAssetRepresentation *assetRep = [self.assetArray[indexPath.row] defaultRepresentation];
    
    CGImageRef currentImageRef = [assetRep fullResolutionImage];
    
    UIImage *image = [UIImage imageWithCGImage:currentImageRef
                                         scale:1.0
                                   orientation:(UIImageOrientation)[assetRep orientation]];
    self.currentImage = image;
    cell.contentImage = image;
    return cell;
}

@end
