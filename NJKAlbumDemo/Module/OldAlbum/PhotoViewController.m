//
//  PhotoViewController.m
//  AssetsLibraryDemo
//
//  Created by coderyi on 14-10-16.
//  Copyright (c) 2014年 coderyi. All rights reserved.
//

#import "PhotoViewController.h"

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height

@interface PhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionVIew;
@property (nonatomic, strong) NSMutableArray *imageArray;

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
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize=CGSizeMake(80.0f, 80.0f);
    
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical]; //控制滑动分页用
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionVIew = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -  64) collectionViewLayout:layout];
    [self.collectionVIew registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionVIew.backgroundColor = [UIColor clearColor];
    
    [self.collectionVIew setUserInteractionEnabled:YES];
    self.collectionVIew.dataSource = self;
    self.collectionVIew.delegate = self;
    [self.view addSubview:self.collectionVIew];
    self.imageArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    [_group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [self.imageArray addObject:result];
            //            NSLog(@"%@",result);
            [self.collectionVIew reloadData];
        }
    }];
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
}

#pragma mark collectionView
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.imageArray count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    [cell.contentView addSubview:iv];
    iv.image=[UIImage imageWithCGImage:((ALAsset *)[self.imageArray objectAtIndex:indexPath.row]).thumbnail];
    NSString *type=[((ALAsset *)[self.imageArray objectAtIndex:indexPath.row]) valueForProperty:ALAssetPropertyType];
    if ([type isEqualToString:@"ALAssetTypeVideo"]) {
        UIImageView *iv1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 15, 8)];
        [cell.contentView addSubview:iv1];
        iv1.image=[UIImage imageNamed:@"AssetsPickerVideo@2x"];
        UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(10, 55, 55, 15)];
        label1.textAlignment=NSTextAlignmentRight;
        label1.textColor=[UIColor whiteColor];
        label1.font=[UIFont systemFontOfSize:10];
        
        int time=[[((ALAsset *)[self.imageArray objectAtIndex:indexPath.row]) valueForProperty:ALAssetPropertyDuration] intValue];
       
        if (time/60<1) {
            NSString *timeString=[NSString stringWithFormat:@"%d",time];
            label1.text=timeString;
        }else if (time/3600<1){
            NSString *timeString=[NSString stringWithFormat:@"%d:%d",time/60,time%60];
            label1.text=timeString;
        }else{
            NSString *timeString=[NSString stringWithFormat:@"%d:%d:%d",time/3600,((time%3600)/60),time%3600%60];
            label1.text=timeString;
        }
      
        [cell.contentView addSubview:label1];
        
    }
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
}

@end
