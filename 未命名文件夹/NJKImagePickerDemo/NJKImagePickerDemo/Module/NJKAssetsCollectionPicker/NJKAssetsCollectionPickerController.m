//
//  NJKALAssetsLibraryPickerViewController.m
//  NJKImagePickerDemo
//
//  Created by JiakaiNong on 16/2/2.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "NJKAssetsCollectionPickerController.h"
//#import <AssetsLibrary/AssetsLibrary.h>
//#import "NJKImagePickerDataSource.h"
#import "NJKAssetsCollectionTableViewCell.h"
#import "NJKAssetPickerController.h"
#import "ImageDataAPI.h"

@interface NJKAssetsCollectionPickerController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *albumsArray;
@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NJKALAssetsDataSource *dataSource;

@end

static NSString * const kReuseIdentifier = @"kReuseIdentifier";

@implementation NJKAssetsCollectionPickerController

#pragma mark - UIViewController Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchingAlbum];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
}

#pragma mark - Private Methods

- (void)fetchingAlbum {
    if (![[ImageDataAPI sharedInstance] haveAccessToPhotos]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"请在设备的\"设置-隐私-照片\"选项中，允许本程序访问你的手机相册"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    __weak __typeof(self)weakSelf = self;
    [[ImageDataAPI sharedInstance] getAlbumsWithCompletion:^(BOOL ret, id obj) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           strongSelf.albumsArray = (NSMutableArray *)obj;
                           if (ret) {
                               [strongSelf.tableView reloadData];
                           }
                       });
    }];
}

- (void)configUI {
    self.title = @"AlbumPicker";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableView];
}

- (void)initTableView {
    [self.view addSubview:self.tableView];
    
    UIView *hiddenView =[ [UIView alloc]init];
    hiddenView.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:hiddenView];
    
    [self.tableView registerClass:[NJKAssetsCollectionTableViewCell class] forCellReuseIdentifier:kReuseIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albumsArray.count;
}

- (NJKAssetsCollectionTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NJKAssetsCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
//    NJKAssetsCollectionEntity *entity = self.albumsArray[indexPath.row];
//    [cell configCellWithEntity:entity];
    AlbumObj *object = self.albumsArray[indexPath.row];
    if (!object.posterImage) {
        [[ImageDataAPI sharedInstance] getPosterImageForAlbumObj:object completion:^(BOOL ret, id obj) {
            object.posterImage = (UIImage *)obj;
            [cell configCellWithCoverImage:object.posterImage title:object.name imageCount:object.count];
        }];
    } else {
        [cell configCellWithCoverImage:object.posterImage title:object.name imageCount:object.count];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NJKAssetPickerController *assetPickerController = [[NJKAssetPickerController alloc] init];
    assetPickerController.albumObj = self.albumsArray[indexPath.row];
    [self.navigationController pushViewController:assetPickerController animated:YES];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Setter & Getter

- (NSMutableArray *)albumsArray {
    if (!_albumsArray) {
        _albumsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _albumsArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
