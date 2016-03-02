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

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height
#define CELL_IDENTIFIER @"cellIdentifier"

@interface OldAssetChooseController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *assetArray;

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
    
    ALAsset *asset = self.assetArray[indexPath.row];
    UIImage *thumbnail = (asset.aspectRatioThumbnail == NULL) ? [UIImage imageWithCGImage:asset.thumbnail]: [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
    [cell configCellWithImage:thumbnail];
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    OldAssetPreviewController *assetPreviewController = [[OldAssetPreviewController alloc] init];
    assetPreviewController.assetArray = self.assetArray;
    assetPreviewController.currentIndex = indexPath.row;
    [self.navigationController pushViewController:assetPreviewController animated:YES];
}

#pragma mark - UIBarButtonItem Action

- (void)rightBarButtonItemAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
}

@end
