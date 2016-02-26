//
//  NJKALAssetsImagePickerViewController.m
//  NJKImagePickerDemo
//
//  Created by JiakaiNong on 16/2/4.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "NJKAssetPickerController.h"
//#import <AssetsLibrary/AssetsLibrary.h>
//#import "NJKImagePickerDataSource.h"
#import "NJKImageCollectionViewCell.h"
#import "NJKAssetBrowserController.h"
#import "AlbumObj.h"
#import "PhotoObj.h"
#import "ImageDataAPI.h"
#import "NJKImagePickerNotificationDefine.h"

@interface NJKAssetPickerController()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, assign, getter = shouldCellLoadingImage) BOOL cellLoadingImage;

@property (nonatomic, strong) UICollectionView *imageCollectionView;
@property (nonatomic, strong) NSMutableArray *assetsArray;
@property (nonatomic, strong) NSMutableArray *thumbnailsArray;
@property (nonatomic, strong) NSOperationQueue *fetchImageQueue;

@end

static NSString * const kReuseIdentifier = @"kReuseIdentifier";

@implementation NJKAssetPickerController

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAssets];
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSLog(@"Start");
}

- (void)viewDidLayoutSubviews {
    [self scrollToNewestItem];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.fetchImageQueue cancelAllOperations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
}

- (void)configUI {
    self.title = self.albumObj.name;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initImageCollectionView];
}

- (void)initImageCollectionView {
    [self.view addSubview:self.imageCollectionView];
    self.imageCollectionView.backgroundColor = [UIColor clearColor];
}

- (void)getAssets {
//    [[NJKImagePickerDataSource sharedInstance] getAssetsWithAlbumIndex:self.albumIndex block:^(id object, NSError *error, BOOL isDone) {
//        if (object && isDone) {
//            self.assetsArray = object;
//        }
//    }];
    __weak __typeof(self)weakSelf = self;
    [[ImageDataAPI sharedInstance] getPhotosWithGroup:self.albumObj completion:^(BOOL ret, id obj)
     {
         __strong __typeof(weakSelf)strongSelf = weakSelf;
         strongSelf.assetsArray = (NSMutableArray *)obj;
         // dispatch_async(dispatch_get_main_queue(), ^
         // {
//         [self.imageCollectionView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//         [self.collectView setContentInset:UIEdgeInsetsMake(0, 0, 65/**SIZE_FACTOR*/, 0)];
         [strongSelf.imageCollectionView reloadData];
         // dispatch_async(dispatch_get_main_queue(), ^
         // {
         if (!strongSelf.assetsArray.count)
         {
             if ([strongSelf.navigationController.visibleViewController isKindOfClass:[self class]])
             {
                 [strongSelf.navigationController popViewControllerAnimated:YES];
             }
             return; // empty album, return and do not need count label.
         }
         /*
          [self.collectView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:[self.dataSource.items count]-1
          inSection:0]
          atScrollPosition:UICollectionViewScrollPositionBottom
          animated:NO];
          */
         // });
         // });
     }];
}

- (void)scrollToNewestItem {
    [self.imageCollectionView setContentOffset:(self.imageCollectionView.contentSize.height > self.imageCollectionView.frame.size.height) ? CGPointMake(0, self.imageCollectionView.contentSize.height - self.imageCollectionView.frame.size.height) : CGPointZero animated:NO];
}

/**
 *  处理图片
 *
 *  @param image 所选图片的原图
 *
 *  @return 处理后外部Notification接收的图
 */
- (UIImage *)handleImage:(UIImage *)image {
    return image;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetsArray.count;
}

- (NJKImageCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NJKImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
//    [cell configCellWithAsset:self.assetsArray[indexPath.row]];
    cell.tag = indexPath.row;
    //添加选图Button
//    [self addPreviewButtonInCell:cell];
    PhotoObj *obj = self.assetsArray[indexPath.row];
    
    //Synchronouzed
//    [[ImageDataAPI sharedInstance] getThumbnailForAssetObj:obj
//                                                  withSize:cell.assetImageView.frame.size
//                                                completion:^(BOOL ret, UIImage *image)
//     {
//         if (cell.tag == indexPath.row) {
//             cell.assetImageView.image = image;
//         }
//     }];

    //NSOperationQueue
    NSBlockOperation *fetchOperation = [NSBlockOperation blockOperationWithBlock:^{
        if (![fetchOperation isCancelled]) {
            [[ImageDataAPI sharedInstance] getThumbnailForAssetObj:obj
                                                          withSize:cell.assetImageView.frame.size
                                                        completion:^(BOOL ret, UIImage *image)
             {
                 NSBlockOperation *setImageOperation = [NSBlockOperation blockOperationWithBlock:^{
                     if (cell.tag == indexPath.row) {
                         cell.assetImageView.image = image;
                     }
                 }];
                 [[NSOperationQueue mainQueue] addOperation:setImageOperation];
             }];
        }
    }];
    [self.fetchImageQueue addOperation:fetchOperation];
//    NSLog(@"%@ start", @(indexPath.row));
    
    return cell;
}

- (void)addPreviewButtonInCell:(NJKImageCollectionViewCell *)cell {
//        if ([object isKindOfClass:[UIButton class]]) {
//            UIButton *button = (UIButton *)object;
//            button.tag = cell.tag;
//        } else {
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            CGFloat buttonWidth = 21;
//            button.frame = CGRectMake(cell.contentView.frame.size.width - buttonWidth, 0, buttonWidth, buttonWidth);
//            button.backgroundColor = [UIColor redColor];
//            button.tag = cell.tag;
//            [button addTarget:self action:@selector(previewButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.contentView addSubview:button];
//        }
    UIButton *button = [self isClass:[UIButton class] inView:cell.contentView];
    if (button) {
        button.tag = cell.tag;
    } else {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat buttonWidth = 21;
        button.frame = CGRectMake(cell.contentView.frame.size.width - buttonWidth, 0, buttonWidth, buttonWidth);
        button.backgroundColor = [UIColor redColor];
        button.tag = cell.tag;
        [button addTarget:self action:@selector(previewButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
    }
}

#pragma mark - Private Methods

- (id)isClass:(Class)aClass inView:(UIView *)view {
    for (id object in [view subviews]) {
        if ([object isKindOfClass:aClass]) {
            return object;
        }
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NJKAssetBrowserController *assetsBrowserController = [[NJKAssetBrowserController alloc] init];
    assetsBrowserController.currentIndex = indexPath.row;
    assetsBrowserController.assetsArray = self.assetsArray;
    [self.navigationController pushViewController:assetsBrowserController animated:YES];
    
//    __weak __typeof(self)weakSelf = self;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        __strong __typeof(weakSelf)strongSelf = weakSelf;
//        [[ImageDataAPI sharedInstance] getImageForPhotoObj:strongSelf.assetsArray[indexPath.row]
//                                                  withSize:strongSelf.view.bounds.size
//                                                completion:^(BOOL ret, UIImage *image)
//         {
//             UIImage *handledImage = [strongSelf handleImage:image];
//             [[NSNotificationCenter defaultCenter] postNotificationName:kImagePickerDidPickImageNotification object:handledImage];
//         }];
//    });
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UICollectionView *)collectionView {
    NSLog(@"scrollViewWillBeginDragging");
}

- (void)scrollViewWillEndDragging:(UICollectionView *)collectionView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0) {
    NSLog(@"scrollViewWillEndDragging %@ %@",@([collectionView isDecelerating]), @(velocity.y));
}

#pragma mark - Actions

- (void)previewButtonDidClick:(UIButton *)previewButton {
    NJKAssetBrowserController *assetsBrowserController = [[NJKAssetBrowserController alloc] init];
    assetsBrowserController.currentIndex = previewButton.tag;
    assetsBrowserController.assetsArray = self.assetsArray;
    [self.navigationController pushViewController:assetsBrowserController animated:YES];
}

#pragma mark - Setter & Getter

- (NSMutableArray *)assetsArray {
    if (!_assetsArray) {
        _assetsArray = [[NSMutableArray alloc] init];
    }
    return _assetsArray;
}

- (UICollectionViewFlowLayout *)assetsFlowLayout {
    
    CGFloat minimumSpacing = 2;
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 5 * minimumSpacing) * 0.25;
    
    UICollectionViewFlowLayout *assetsFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    assetsFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    assetsFlowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    assetsFlowLayout.minimumInteritemSpacing = minimumSpacing;
    assetsFlowLayout.minimumLineSpacing = minimumSpacing;
    assetsFlowLayout.sectionInset = UIEdgeInsetsMake(minimumSpacing, minimumSpacing, minimumSpacing, minimumSpacing);
    return assetsFlowLayout;
}

- (UICollectionView *)imageCollectionView {
    if (!_imageCollectionView) {
        _imageCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[self assetsFlowLayout]];
        [_imageCollectionView registerClass:[NJKImageCollectionViewCell class] forCellWithReuseIdentifier:kReuseIdentifier];
        _imageCollectionView.dataSource = self;
        _imageCollectionView.delegate = self;
    }
    return _imageCollectionView;
}

- (NSOperationQueue *)fetchImageQueue {
    if (!_fetchImageQueue) {
        _fetchImageQueue = [[NSOperationQueue alloc] init];
        _fetchImageQueue.maxConcurrentOperationCount = 20;
    }
    return _fetchImageQueue;
}

@end
