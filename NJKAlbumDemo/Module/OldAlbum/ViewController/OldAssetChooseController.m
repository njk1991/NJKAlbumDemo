//
//  PhotoViewController.m
//  AssetsLibraryDemo
//
//  Created by coderyi on 14-10-16.
//  Copyright (c) 2014年 coderyi. All rights reserved.
//

#import "OldAssetChooseController.h"
#import "OldAssetCell.h"
#import "OldAssetPreviewController.h"
#import "AlbumNotification.h"

#define CELL_IDENTIFIER @"cellIdentifier"

@interface OldAssetChooseController ()<UICollectionViewDataSource, UICollectionViewDelegate, OldAssetCellDelegate, AlbumNotificationPoster>

//@property (nonatomic, strong) NSMutableArray *assetArray;

@end

@implementation OldAssetChooseController

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self prepareForAsset];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.imageCollectionView registerClass:[OldAssetCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
    self.title = [self.group valueForProperty:ALAssetsGroupPropertyName];
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

- (void)prepareForAsset {
    [_group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [self.assetArray addObject:result];
            [self.imageCollectionView reloadData];
        }
    }];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.assetArray count];
}

- (OldAssetCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OldAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    cell.delegate = self;
    
    ALAsset *asset = self.assetArray[indexPath.row];
    UIImage *thumbnail = (asset.aspectRatioThumbnail == NULL) ? [UIImage imageWithCGImage:asset.thumbnail]: [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
    [cell configCellWithImage:thumbnail];
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self handleImageWithIndexPath:indexPath];
}

#pragma mark - OldAssetCellDelegate

- (void)assetsCell:(BaseAssetCell *)cell didClickTopRightButton:(UIButton *)sender {
    OldAssetPreviewController *assetPreviewController = [[OldAssetPreviewController alloc] init];
    assetPreviewController.assetArray = self.assetArray;
    assetPreviewController.currentIndex = [self.imageCollectionView indexPathForCell:cell].row;
    [self.navigationController pushViewController:assetPreviewController animated:YES];
}

#pragma mark - AlbumNotificationPoster

- (void)postNotificationWithObject:(id)object {
    [[NSNotificationCenter defaultCenter] postNotificationName:ALBUM_DID_PICK_IMAGE_NOTIFICATION object:object];
}

#pragma mark - UIBarButtonItem Action

- (void)rightBarButtonItemAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
}

#pragma mark - Private Method

- (void)handleImageWithIndexPath:(NSIndexPath *)indexPath {
    ALAssetRepresentation *assetRep = [self.assetArray[indexPath.row] defaultRepresentation];
    
    CGImageRef currentImageRef = [assetRep fullResolutionImage];
    
    UIImage *image = [UIImage imageWithCGImage:currentImageRef
                                         scale:1.0
                                   orientation:(UIImageOrientation)[assetRep orientation]];
    [self postNotificationWithObject:image];
}

@end
