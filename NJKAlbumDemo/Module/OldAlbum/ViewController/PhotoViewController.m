//
//  PhotoViewController.m
//  AssetsLibraryDemo
//
//  Created by coderyi on 14-10-16.
//  Copyright (c) 2014年 coderyi. All rights reserved.
//

#import "PhotoViewController.h"
//#import "NJKImageCollectionViewCell.h"
#import "OldAssetCell.h"
#import "OldAssetPreviewController.h"
//#import "NJKAssetBrowserController.h"

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height
#define CELL_IDENTIFIER @"cellIdentifier"

@interface PhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

//@property (nonatomic, strong) UICollectionView *collectionVIew;
@property (nonatomic, strong) NSMutableArray *assetArray;
//@property (nonatomic, strong) UICollectionView *imageCollectionView;

@end

@implementation PhotoViewController

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //    适配iOS7导航栏
    //    if (SYSTEM_VERSION >= 7.0f) {
    //        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    //
    //    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareForAsset];
    
//    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
//    layout.itemSize=CGSizeMake(80.0f, 80.0f);
//    
//    [layout setScrollDirection:UICollectionViewScrollDirectionVertical]; //控制滑动分页用
//    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    self.collectionVIew = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -  64) collectionViewLayout:[self assetsFlowLayout]];
//    [self.collectionVIew registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//    self.collectionVIew.backgroundColor = [UIColor clearColor];
//    
//    [self.collectionVIew setUserInteractionEnabled:YES];
//    self.collectionVIew.dataSource = self;
//    self.collectionVIew.delegate = self;
//    [self.view addSubview:self.collectionVIew];
//    self.assetArray = [[NSMutableArray alloc] initWithCapacity:1];
    
//    [_group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//        if (result) {
//            [self.assetArray addObject:result];
//            //            NSLog(@"%@",result);
//            [self.imageCollectionView reloadData];
//        }
//    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.imageCollectionView registerClass:[OldAssetCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
    self.title = [self.group valueForProperty:ALAssetsGroupPropertyName];
}

//- (void)viewDidLayoutSubviews {
//    [self scrollToNewestItem];
//}

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

//- (void)initNavigationBar {
//    self.title = [self.group valueForProperty:ALAssetsGroupPropertyName];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
//}

- (void)prepareForAsset {
    [_group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [self.assetArray addObject:result];
            [self.imageCollectionView reloadData];
        }
    }];
}

//- (void)scrollToNewestItem {
//    [self.imageCollectionView setContentOffset:(self.imageCollectionView.contentSize.height > self.imageCollectionView.frame.size.height) ? CGPointMake(0, self.imageCollectionView.contentSize.height - self.imageCollectionView.frame.size.height) : CGPointZero animated:NO];
//}

#pragma mark - UICollectionViewDataSource

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0.0f;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0.0f;
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.assetArray count];
}

- (OldAssetCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OldAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    ALAsset *asset = self.assetArray[indexPath.row];
    UIImage *thumbnail = (asset.aspectRatioThumbnail == NULL) ? [UIImage imageWithCGImage:asset.thumbnail]: [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
//    [cell configCellWithImage:[UIImage imageWithCGImage:((ALAsset *)[self.assetArray objectAtIndex:indexPath.row]).thumbnail]];
    [cell configCellWithImage:thumbnail];
//    UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
//    [cell.contentView addSubview:iv];
//    iv.image=[UIImage imageWithCGImage:((ALAsset *)[self.assetArray objectAtIndex:indexPath.row]).thumbnail];
//    NSString *type=[((ALAsset *)[self.assetArray objectAtIndex:indexPath.row]) valueForProperty:ALAssetPropertyType];
//    if ([type isEqualToString:@"ALAssetTypeVideo"]) {
//        UIImageView *iv1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 15, 8)];
//        [cell.contentView addSubview:iv1];
//        iv1.image=[UIImage imageNamed:@"AssetsPickerVideo@2x"];
//        UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(10, 55, 55, 15)];
//        label1.textAlignment=NSTextAlignmentRight;
//        label1.textColor=[UIColor whiteColor];
//        label1.font=[UIFont systemFontOfSize:10];
//        
//        int time=[[((ALAsset *)[self.assetArray objectAtIndex:indexPath.row]) valueForProperty:ALAssetPropertyDuration] intValue];
//       
//        if (time/60<1) {
//            NSString *timeString=[NSString stringWithFormat:@"%d",time];
//            label1.text=timeString;
//        }else if (time/3600<1){
//            NSString *timeString=[NSString stringWithFormat:@"%d:%d",time/60,time%60];
//            label1.text=timeString;
//        }else{
//            NSString *timeString=[NSString stringWithFormat:@"%d:%d:%d",time/3600,((time%3600)/60),time%3600%60];
//            label1.text=timeString;
//        }
//      
//        [cell.contentView addSubview:label1];
//        
//    }
    
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

#pragma mark - Setter & Getter

- (NSMutableArray *)assetArray {
    if (!_assetArray) {
        _assetArray = [@[] mutableCopy];
    }
    return _assetArray;
}

//- (UICollectionViewFlowLayout *)assetsFlowLayout {
//    
//    CGFloat minimumSpacing = 2;
//    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 5 * minimumSpacing) * 0.25;
//    
//    UICollectionViewFlowLayout *assetsFlowLayout = [[UICollectionViewFlowLayout alloc] init];
//    assetsFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    assetsFlowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
//    assetsFlowLayout.minimumInteritemSpacing = minimumSpacing;
//    assetsFlowLayout.minimumLineSpacing = minimumSpacing;
//    assetsFlowLayout.sectionInset = UIEdgeInsetsMake(minimumSpacing, minimumSpacing, minimumSpacing, minimumSpacing);
//    return assetsFlowLayout;
//}
//
//- (UICollectionView *)imageCollectionView {
//    if (!_imageCollectionView) {
//        _imageCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[self assetsFlowLayout]];
//        [_imageCollectionView registerClass:[NJKImageCollectionViewCell class] forCellWithReuseIdentifier:REUSEIDENTIFIER];
//        _imageCollectionView.backgroundColor = [UIColor clearColor];
//        _imageCollectionView.dataSource = self;
//        _imageCollectionView.delegate = self;
//    }
//    return _imageCollectionView;
//}

@end
