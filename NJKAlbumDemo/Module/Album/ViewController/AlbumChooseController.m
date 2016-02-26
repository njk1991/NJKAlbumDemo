//
//  AlbumChooseController.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "AlbumChooseController.h"
//#import "PHSourceManager.h"
#import "AlbumChooseDataShource.h"

@interface AlbumChooseController ()<UIAlertViewDelegate, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *albumsArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AlbumChooseDataShource *dataSource;

@end

@implementation AlbumChooseController

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
//    if ([PHSourceManager haveAccessToPhotos]) {
//        [self prepareForAlbums];
//    } else {
//        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有创建相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//    }
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

- (void)prepareForAlbums {
//    [PHSourceManager getAlbumsWithCompletion:^(BOOL ret, NSMutableArray *resultArray) {
//        if (ret) {
//            self.albumsArray = resultArray;
//        }
//    }];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:^{
            nil;
        }];
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
        _tableView.dataSource = self.dataSource;
    }
    return _tableView;
}

- (AlbumChooseDataShource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[AlbumChooseDataShource alloc] initWithCellIdentifier:@"cellIdentifier"];
    }
    return _dataSource;
}

@end
