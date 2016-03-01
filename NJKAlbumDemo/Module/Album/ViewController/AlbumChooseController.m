/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The view controller displaying the root list of the app.
 */

#import "AlbumChooseController.h"
#import "AssetChooseController.h"
#import "AlbumCell.h"

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height
#define CELL_IDENTIFIER @"cellIdentifier"

@import Photos;


@interface AlbumChooseController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *groupArray;
@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation AlbumChooseController

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareForAssetGroup];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self deselectRow];
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

- (void)prepareForAssetGroup {

    switch ([PHPhotoLibrary authorizationStatus]) {
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusDenied:
        {
            [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"请在设备的\"设置-隐私-照片\"选项中，允许本程序访问你的手机相册"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
            break;
            
        default:
            break;
    }
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            [self fetchAlbum];
        }
    }];
    
}

- (void)fetchAlbum {
    
    [self fetchSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary];
    [self fetchSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumFavorites];
    [self fetchSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumRecentlyAdded];
    [self fetchSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumPanoramas];
    [self fetchSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumBursts];
    if (SYSTEM_VERSION >= 9.0) {
        [self fetchSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumSelfPortraits];
        [self fetchSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumScreenshots];
    }
    [self fetchTopLevelUserAlbums];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)fetchSmartAlbumWithSubtype:(PHAssetCollectionSubtype)subtype {
    PHFetchResult *collectionFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:subtype options:nil];
    PHAssetCollection *collection = collectionFetchResult[0];
    PHFetchResult *assetFetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    if (assetFetchResult.count) {
        [self.groupArray addObject:collection];
        NSLog(@"add");
    }
}

- (void)fetchTopLevelUserAlbums {
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    for (PHAssetCollection *collection in topLevelUserCollections) {
        PHFetchResult *assetFetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        if (assetFetchResult.count) {
            [self.groupArray addObject:collection];
            NSLog(@"add");
        }
    }
}

- (void)deselectRow {
    if (_tableView && _selectedIndexPath) {
        [self.tableView deselectRowAtIndexPath:self.selectedIndexPath animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupArray.count;
}

- (AlbumCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    PHAssetCollection *collection = self.groupArray[indexPath.row];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    PHAsset *asset = (PHAsset *)fetchResult[fetchResult.count - 1];
    
    PHImageRequestOptions *fetchingOptions = [[PHImageRequestOptions alloc] init];
    fetchingOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat dimension = 60.f;
    CGSize  size  = CGSizeMake(dimension * scale, dimension * scale);
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset
                                                      targetSize:size
                                                     contentMode:PHImageContentModeAspectFill
                                                         options:fetchingOptions
                                                   resultHandler:^(UIImage *result, NSDictionary *info)
     {
         [cell configCellWithCoverImage:result title:collection.localizedTitle imageCount:fetchResult.count];
     }];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PHAssetCollection *collection = self.groupArray[indexPath.row];
    
    AssetChooseController *assetGridViewController = [[AssetChooseController alloc] init];
    assetGridViewController.title = collection.localizedTitle;
    assetGridViewController.assetCollection = collection;
    [self.navigationController pushViewController:assetGridViewController animated:YES];
    
    self.selectedIndexPath = indexPath;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Setter & Getter

- (NSMutableArray *)groupArray {
    if (!_groupArray) {
        _groupArray = [@[] mutableCopy];
    }
    return _groupArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[AlbumCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
        UIView *hiddenView =[ [UIView alloc]init];
        hiddenView.backgroundColor = [UIColor clearColor];
        [_tableView setTableFooterView:hiddenView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
