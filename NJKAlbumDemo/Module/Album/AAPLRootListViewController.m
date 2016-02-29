/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The view controller displaying the root list of the app.
 */

#import "AAPLRootListViewController.h"

#import "AAPLAssetGridViewController.h"

#import "AlbumCell.h"

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height
#define CELL_IDENTIFIER @"cellIdentifier"

@import Photos;


//@interface AAPLRootListViewController () <PHPhotoLibraryChangeObserver>
@interface AAPLRootListViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
//@property (nonatomic, strong) NSArray *sectionFetchResults;
//@property (nonatomic, strong) NSArray *sectionLocalizedTitles;

//@property (nonatomic, strong) PHCachingImageManager *imageManager;
@property (nonatomic, strong) NSMutableArray *groupArray;
@property (nonatomic, strong) UITableView  *tableView;

@end

@implementation AAPLRootListViewController

//static NSString * const AllPhotosReuseIdentifier = @"AllPhotosCell";
//static NSString * const CollectionCellReuseIdentifier = @"CollectionCell";
//
//static NSString * const AllPhotosSegue = @"showAllPhotos";
//static NSString * const CollectionSegue = @"showCollection";

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareForAssetGroup];
    [self.view addSubview:self.tableView];
//    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
//    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

- (void)prepareForAssetGroup {
    
    // Create a PHFetchResult object for each section in the table view.
    
//    PHFetchResult *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    
//    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumMyPhotoStream options:nil];
//    
//    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    // Store the PHFetchResult objects and localized titles for each section.
//    self.sectionFetchResults = @[allPhotos, smartAlbums, topLevelUserCollections];
//    self.sectionLocalizedTitles = @[@"", NSLocalizedString(@"Smart Albums", @""), NSLocalizedString(@"Albums", @"")];
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
//    PHFetchOptions *creationDateAscendingOptions = [[PHFetchOptions alloc] init];
//    creationDateAscendingOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    
    [self fetchSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary];
//    [self fetchSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumFavorites];
//    [self fetchSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumRecentlyAdded];
//    [self fetchSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumPanoramas];
//    [self fetchSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumBursts];
//    if (SYSTEM_VERSION >= 9.0) {
//        [self fetchSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumSelfPortraits];
//        [self fetchSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumScreenshots];
//    }
//    [self fetchTopLevelUserAlbums];
    
}

- (void)fetchSmartAlbumWithSubtype:(PHAssetCollectionSubtype)subtype {
    PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:subtype options:nil];
    PHAssetCollection *collection = fetchResult[0];
    [self.groupArray addObject:collection];
    [self.tableView reloadData];
}

- (void)fetchTopLevelUserAlbums {
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    for (PHAssetCollection *collection in topLevelUserCollections) {
        [self.groupArray addObject:collection];
    }
    [self.tableView reloadData];
}

//#pragma mark - UIViewController

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    /*
//        Get the AAPLAssetGridViewController being pushed and the UITableViewCell
//        that triggered the segue.
//     */
//    if (![segue.destinationViewController isKindOfClass:[AAPLAssetGridViewController class]] || ![sender isKindOfClass:[UITableViewCell class]]) {
//        return;
//    }
//    
//    AAPLAssetGridViewController *assetGridViewController = segue.destinationViewController;
//    UITableViewCell *cell = sender;
//    
//    // Set the title of the AAPLAssetGridViewController.
//    assetGridViewController.title = cell.textLabel.text;
//
//    // Get the PHFetchResult for the selected section.
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    PHFetchResult *fetchResult = self.sectionFetchResults[indexPath.section];
//    
//    if ([segue.identifier isEqualToString:AllPhotosSegue]) {
//        assetGridViewController.assetsFetchResults = fetchResult;
//    } else if ([segue.identifier isEqualToString:CollectionSegue]) {
//        // Get the PHAssetCollection for the selected row.
//        PHCollection *collection = fetchResult[indexPath.row];
//        if (![collection isKindOfClass:[PHAssetCollection class]]) {
//            return;
//        }
//
//        // Configure the AAPLAssetGridViewController with the asset collection.
//        PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
//        PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
//
//        assetGridViewController.assetsFetchResults = assetsFetchResult;
//        assetGridViewController.assetCollection = assetCollection;
//    }
//}

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
//    PHAsset *asset = (PHAsset *)fetchResult[0];
    
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
    AAPLAssetGridViewController *assetGridViewController = [[AAPLAssetGridViewController alloc] init];
    PHAssetCollection *collection = self.groupArray[indexPath.row];
    
    // Set the title of the AAPLAssetGridViewController.
    assetGridViewController.title = collection.localizedTitle;
    
    // Get the PHFetchResult for the selected section.
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    PHFetchResult *fetchResult = self.sectionFetchResults[indexPath.section];
    
//    if ([segue.identifier isEqualToString:AllPhotosSegue]) {
//        assetGridViewController.assetsFetchResults = fetchResult;
//    } else if ([segue.identifier isEqualToString:CollectionSegue]) {
//        // Get the PHAssetCollection for the selected row.
//        PHCollection *collection = fetchResult[indexPath.row];
//        if (![collection isKindOfClass:[PHAssetCollection class]]) {
//            return;
//        }
//        
//        // Configure the AAPLAssetGridViewController with the asset collection.
//        PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
//        PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
//        
//        assetGridViewController.assetsFetchResults = assetsFetchResult;
//        assetGridViewController.assetCollection = assetCollection;
//    }
    assetGridViewController.assetCollection = collection;
    [self.navigationController pushViewController:assetGridViewController animated:YES];
}

//#pragma mark - PHPhotoLibraryChangeObserver
//
//- (void)photoLibraryDidChange:(PHChange *)changeInstance {
//    /*
//        Change notifications may be made on a background queue. Re-dispatch to the
//        main queue before acting on the change as we'll be updating the UI.
//     */
//    dispatch_async(dispatch_get_main_queue(), ^{
//        // Loop through the section fetch results, replacing any fetch results that have been updated.
//        NSMutableArray *updatedSectionFetchResults = [self.sectionFetchResults mutableCopy];
//        __block BOOL reloadRequired = NO;
//
//        [self.sectionFetchResults enumerateObjectsUsingBlock:^(PHFetchResult *collectionsFetchResult, NSUInteger index, BOOL *stop) {
//            PHFetchResultChangeDetails *changeDetails = [changeInstance changeDetailsForFetchResult:collectionsFetchResult];
//
//            if (changeDetails != nil) {
//                [updatedSectionFetchResults replaceObjectAtIndex:index withObject:[changeDetails fetchResultAfterChanges]];
//                reloadRequired = YES;
//            }
//        }];
//        
//        if (reloadRequired) {
//            self.sectionFetchResults = updatedSectionFetchResults;
//            [self.tableView reloadData];
//        }
//        
//    });
//}

//#pragma mark - Actions
//
//- (IBAction)handleAddButtonItem:(id)sender {
//    // Prompt user from new album title.
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"New Album", @"") message:nil preferredStyle:UIAlertControllerStyleAlert];
//
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder = NSLocalizedString(@"Album Name", @"");
//    }];
//
//    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"") style:UIAlertActionStyleCancel handler:NULL]];
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Create", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        UITextField *textField = alertController.textFields.firstObject;
//        NSString *title = textField.text;
//        if (title.length == 0) {
//            return;
//        }
//
//        // Create a new album with the title entered.
//        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//            [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
//        } completionHandler:^(BOOL success, NSError *error) {
//            if (!success) {
//                NSLog(@"Error creating album: %@", error);
//            }
//        }];
//    }]];
//    
//    [self presentViewController:alertController animated:YES completion:NULL];
//}

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

//- (PHCachingImageManager *)imageManager {
//    if (!_imageManager) {
//        _imageManager = [[PHCachingImageManager alloc] init];
//    }
//    return _imageManager;
//}

@end
