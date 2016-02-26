//
//  DemoListViewController.m
//  AssetsLibraryDemo
//
//  Created by coderyi on 14-10-16.
//  Copyright (c) 2014年 coderyi. All rights reserved.
//

#import "PhotoListViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoViewController.h"
#import "OldAlbumCell.h"

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height
#define CELL_IDENTIFIER @"cellIdentifier"

@interface PhotoListViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *groupArray;
@property (nonatomic, strong) UITableView  *tableView;

@end

@implementation PhotoListViewController

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareForAssetGroup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addSubview:self.tableView];
    [self initNavigationBar];
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

- (void)initNavigationBar {
    self.title = @"相簿";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
}

- (void)prepareForAssetGroup {
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            if (group.numberOfAssets > 0) {
                // 把相册储存到数组中，方便后面展示相册时使用
                [self.groupArray addObject:group];
            }
        } else {
            if ([self.groupArray count] > 0) {
                // 把所有的相册储存完毕，可以展示相册列表
                [self.tableView reloadData];
            } else {
                // 没有任何有资源的相册，输出提示
            }
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"Group not found!\n");
    }];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%@",self.groupArray);
    return self.groupArray.count;
}

- (OldAlbumCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OldAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
//    cell.textLabel.text = [((ALAssetsGroup *)[self.groupArray objectAtIndex:indexPath.row]) valueForProperty:ALAssetsGroupPropertyName];
//    cell.imageView.image = [UIImage imageWithCGImage:((ALAssetsGroup *)[self.groupArray objectAtIndex:indexPath.row]).posterImage];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",[((ALAssetsGroup *)[self.groupArray objectAtIndex:indexPath.row]) numberOfAssets]];
    [cell configCellWithCoverImage:[UIImage imageWithCGImage:((ALAssetsGroup *)[self.groupArray objectAtIndex:indexPath.row]).posterImage]
                             title:[((ALAssetsGroup *)[self.groupArray objectAtIndex:indexPath.row]) valueForProperty:ALAssetsGroupPropertyName]
                        imageCount:[((ALAssetsGroup *)[self.groupArray objectAtIndex:indexPath.row]) numberOfAssets]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotoViewController *vc=[[PhotoViewController alloc] init];
    vc.group=((ALAssetsGroup *)[self.groupArray objectAtIndex:indexPath.section]);
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:^{
            nil;
        }];
    }
}

#pragma mark - UIBarButtonItem Action

- (void)rightBarButtonItemAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
}

#pragma mark - Setter & Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        [_tableView registerClass:[OldAlbumCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (ALAssetsLibrary *)assetsLibrary {
    if (!_assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}

- (NSMutableArray *)groupArray {
    if (!_groupArray) {
        _groupArray = [[NSMutableArray alloc] init];
    }
    return _groupArray;
}

@end
