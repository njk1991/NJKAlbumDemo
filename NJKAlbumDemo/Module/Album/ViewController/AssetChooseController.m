/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A view controller displaying a grid of assets.
 */

#import "AssetChooseController.h"

#import "AssetCell.h"
#import "AssetPreviewController.h"
#import "AlbumNotification.h"

@import PhotosUI;

#define CELL_IDENTIFIER @"cellIdentifier"

@interface AssetChooseController () <AlbumNotificationPoster, AssetCellDelegate, AlbumNotificationPoster>
@property (nonatomic, strong) PHFetchResult *assetsFetchResults;
@property (nonatomic, strong) PHCachingImageManager *imageManager;
@property (nonatomic, strong) UIImage *pickedImage;
@property CGRect previousPreheatRect;

@end


@implementation AssetChooseController

static CGSize AssetGridThumbnailSize;

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetCachedAssets];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = self.assetCollection.localizedTitle;
    
    [self.imageCollectionView registerClass:[AssetCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cellSize = ((UICollectionViewFlowLayout *)self.assetsFlowLayout).itemSize;
    AssetGridThumbnailSize = CGSizeMake(cellSize.width * scale, cellSize.height * scale);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateCachedAssets];
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

- (AssetCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    cell.delegate = self;
    cell.tag = indexPath.row;
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    PHAsset *asset = self.assetsFetchResults[indexPath.item];
    [self.imageManager requestImageForAsset:asset
                                 targetSize:AssetGridThumbnailSize
                                contentMode:PHImageContentModeAspectFill
                                    options:options
                              resultHandler:^(UIImage *result, NSDictionary *info) {
                                  if (cell.tag == indexPath.row) {
                                      [cell configCellWithImage:result];
                                  }
                              }];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self handleImageWithIndexPath:indexPath];
}

#pragma mark - AssetCellDelegate

- (void)assetsCell:(BaseAssetCell *)cell didClickTopRightButton:(UIButton *)sender {
    AssetPreviewController *assetPreviewController = [[AssetPreviewController alloc] init];
    assetPreviewController.assetsFetchResults = self.assetsFetchResults;
    assetPreviewController.currentIndex = [self.imageCollectionView indexPathForCell:cell].row;
    [self.navigationController pushViewController:assetPreviewController animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    __weak __typeof(self)weakSelf = self;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        __strong __typeof(weakSelf)strongSelf = weakSelf;
//        [strongSelf updateCachedAssets];
//    });
    [self updateCachedAssets];
}

#pragma mark - AlbumNotificationPoster

- (void)postNotificationWithObject:(id)object {
    [[NSNotificationCenter defaultCenter] postNotificationName:ALBUM_DID_PICK_IMAGE_NOTIFICATION object:object];
}

#pragma mark - Private Method

- (NSArray *)indexPathsForElementsInRect:(CGRect)rect {
    NSArray *allLayoutAttributes = [self.imageCollectionView.collectionViewLayout layoutAttributesForElementsInRect:rect];
    if (allLayoutAttributes.count == 0) { return nil; }
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:allLayoutAttributes.count];
    for (UICollectionViewLayoutAttributes *layoutAttributes in allLayoutAttributes) {
        NSIndexPath *indexPath = layoutAttributes.indexPath;
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

- (void)handleImageWithIndexPath:(NSIndexPath *)indexPath {
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    [options setSynchronous:YES];
    PHAsset *asset = self.assetsFetchResults[indexPath.row];
    __weak __typeof(self)weakSelf = self;
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset
                                                      targetSize:CGSizeMake(SCREEN_WIDTH * SCREEN_SCALE, SCREEN_HEIGHT * SCREEN_SCALE)
                                                     contentMode:PHImageContentModeAspectFit
                                                         options:options
                                                   resultHandler:^(UIImage *result, NSDictionary *info)
     {
         __strong __typeof(weakSelf)strongSelf = weakSelf;
         [strongSelf postNotificationWithObject:result];
     }];
}

- (void)scrollToNewestItemAnimated:(BOOL)animated {
    if (self.isScrollToNewestItemEnable) {
        [self.imageCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.assetsFetchResults.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:animated];
    }
}

#pragma mark  Asset Caching

- (void)resetCachedAssets {
    [self.imageManager stopCachingImagesForAllAssets];
    self.previousPreheatRect = CGRectZero;
}

- (void)updateCachedAssets {
    
    BOOL isViewVisible = [self isViewLoaded] && [[self view] window] != nil;
    if (!isViewVisible) { return; }
    
    // The preheat window is twice the height of the visible rect.
    CGRect preheatRect = self.imageCollectionView.bounds;
    preheatRect = CGRectInset(preheatRect, 0.0f, -0.5f * CGRectGetHeight(preheatRect));
    
    /*
     Check if the collection view is showing an area that is significantly
     different to the last preheated area.
     */
    CGFloat delta = ABS(CGRectGetMidY(preheatRect) - CGRectGetMidY(self.previousPreheatRect));
    if (delta > CGRectGetHeight(self.imageCollectionView.bounds) / 2.0f) {
        
        // Compute the assets to start caching and to stop caching.
        NSMutableArray *addedIndexPaths = [NSMutableArray array];
        NSMutableArray *removedIndexPaths = [NSMutableArray array];
        
        __weak __typeof(self)weakSelf = self;
        [self computeDifferenceBetweenRect:self.previousPreheatRect andRect:preheatRect removedHandler:^(CGRect removedRect) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            NSArray *indexPaths = [strongSelf indexPathsForElementsInRect:removedRect];
            [removedIndexPaths addObjectsFromArray:indexPaths];
        } addedHandler:^(CGRect addedRect) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            NSArray *indexPaths = [strongSelf indexPathsForElementsInRect:addedRect];
            [addedIndexPaths addObjectsFromArray:indexPaths];
        }];
        
        NSArray *assetsToStartCaching = [self assetsAtIndexPaths:addedIndexPaths];
        NSArray *assetsToStopCaching = [self assetsAtIndexPaths:removedIndexPaths];
        
        // Update the assets the PHCachingImageManager is caching.
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.synchronous = YES;
            options.resizeMode = PHImageRequestOptionsResizeModeFast;
            
            [strongSelf.imageManager startCachingImagesForAssets:assetsToStartCaching
                                                targetSize:AssetGridThumbnailSize
                                               contentMode:PHImageContentModeAspectFill
                                                   options:options];
            [strongSelf.imageManager stopCachingImagesForAssets:assetsToStopCaching
                                               targetSize:AssetGridThumbnailSize
                                              contentMode:PHImageContentModeAspectFill
                                                  options:options];
        });
        
        
        // Store the preheat rect to compare against in the future.
        self.previousPreheatRect = preheatRect;
    }
    
//    BOOL isViewVisible = [self isViewLoaded] && [[self view] window] != nil;
//    if (!isViewVisible) { return; }
//
//    // The preheat window is twice the height of the visible rect.
//    CGRect preheatRect = self.imageCollectionView.bounds;
//    preheatRect = CGRectInset(preheatRect, 0.0f, -0.5f * CGRectGetHeight(preheatRect));
//    
//    /*
//     Check if the collection view is showing an area that is significantly
//     different to the last preheated area.
//     */
//    CGFloat delta = ABS(CGRectGetMidY(preheatRect) - CGRectGetMidY(self.previousPreheatRect));
//    if (delta > CGRectGetHeight(self.imageCollectionView.bounds) / 2.0f) {
//        
//        // Compute the assets to start caching and to stop caching.
//        NSMutableArray *addedIndexPaths = [NSMutableArray array];
//        NSMutableArray *removedIndexPaths = [NSMutableArray array];
//        
//        [self computeDifferenceBetweenRect:self.previousPreheatRect andRect:preheatRect removedHandler:^(CGRect removedRect) {
//            NSArray *indexPaths = [self indexPathsForElementsInRect:removedRect];
//            [removedIndexPaths addObjectsFromArray:indexPaths];
//        } addedHandler:^(CGRect addedRect) {
//            NSArray *indexPaths = [self indexPathsForElementsInRect:addedRect];
//            [addedIndexPaths addObjectsFromArray:indexPaths];
//        }];
//        
//        NSArray *assetsToStartCaching = [self assetsAtIndexPaths:addedIndexPaths];
//        NSArray *assetsToStopCaching = [self assetsAtIndexPaths:removedIndexPaths];
//        
//        // Update the assets the PHCachingImageManager is caching.
//        
//        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//        options.synchronous = YES;
//        options.resizeMode = PHImageRequestOptionsResizeModeFast;
//        
//        [self.imageManager startCachingImagesForAssets:assetsToStartCaching
//                                            targetSize:AssetGridThumbnailSize
//                                           contentMode:PHImageContentModeAspectFill
//                                               options:options];
//        [self.imageManager stopCachingImagesForAssets:assetsToStopCaching
//                                           targetSize:AssetGridThumbnailSize
//                                          contentMode:PHImageContentModeAspectFill
//                                              options:options];
//        
//        // Store the preheat rect to compare against in the future.
//        self.previousPreheatRect = preheatRect;
//    }
}

- (void)computeDifferenceBetweenRect:(CGRect)oldRect andRect:(CGRect)newRect removedHandler:(void (^)(CGRect removedRect))removedHandler addedHandler:(void (^)(CGRect addedRect))addedHandler {
    if (CGRectIntersectsRect(newRect, oldRect)) {
        CGFloat oldMaxY = CGRectGetMaxY(oldRect);
        CGFloat oldMinY = CGRectGetMinY(oldRect);
        CGFloat newMaxY = CGRectGetMaxY(newRect);
        CGFloat newMinY = CGRectGetMinY(newRect);
        
        if (newMaxY > oldMaxY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY));
            addedHandler(rectToAdd);
        }
        
        if (oldMinY > newMinY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY));
            addedHandler(rectToAdd);
        }
        
        if (newMaxY < oldMaxY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY));
            removedHandler(rectToRemove);
        }
        
        if (oldMinY < newMinY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY));
            removedHandler(rectToRemove);
        }
    } else {
        addedHandler(newRect);
        removedHandler(oldRect);
    }
}

- (NSArray *)assetsAtIndexPaths:(NSArray *)indexPaths {
    if (indexPaths.count == 0) { return nil; }
    
    NSMutableArray *assets = [NSMutableArray arrayWithCapacity:indexPaths.count];
    for (NSIndexPath *indexPath in indexPaths) {
        PHAsset *asset = self.assetsFetchResults[indexPath.item];
        [assets addObject:asset];
    }
    
    return assets;
}

#pragma mark - Setter & Getter

- (PHCachingImageManager *)imageManager {
    if (!_imageManager) {
        _imageManager = [[PHCachingImageManager alloc] init];
        _imageManager.allowsCachingHighQualityImages = NO;
    }
    return _imageManager;
}

- (PHFetchResult *)assetsFetchResults {
    if (!_assetsFetchResults) {
        _assetsFetchResults = [PHAsset fetchAssetsInAssetCollection:self.assetCollection options:nil];
    }
    return _assetsFetchResults;
}

@end
