//
//  DemoListViewController.m
//  AssetsLibraryDemo
//
//  Created by coderyi on 14-10-16.
//  Copyright (c) 2014年 coderyi. All rights reserved.
//

#import "OldAlbumChooseController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "OldAssetChooseController.h"
#import "OldAlbumCell.h"

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height
#define CELL_IDENTIFIER @"cellIdentifier"

@interface OldAlbumChooseController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation OldAlbumChooseController

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareForAssetGroup];
    [self.tableView registerClass:[OldAlbumCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
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
    
    switch ([ALAssetsLibrary authorizationStatus]) {
        case ALAuthorizationStatusRestricted:
        case ALAuthorizationStatusDenied:
        {
            [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"请在设备的\"设置-隐私-照片\"选项中，允许本程序访问你的手机相册"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
            break;
            
        default:
            break;
    }
    
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            if (group.numberOfAssets > 0) {
                // 把相册储存到数组中，方便后面展示相册时使用
                [self.groupArray insertObject:group atIndex:0];
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

- (void)deselectRow {
    if (self.tableView && _selectedIndexPath) {
        [self.tableView deselectRowAtIndexPath:self.selectedIndexPath animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupArray.count;
}

- (OldAlbumCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OldAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    [cell configCellWithCoverImage:[UIImage imageWithCGImage:((ALAssetsGroup *)[self.groupArray objectAtIndex:indexPath.row]).posterImage]
                             title:[((ALAssetsGroup *)[self.groupArray objectAtIndex:indexPath.row]) valueForProperty:ALAssetsGroupPropertyName]
                        imageCount:[((ALAssetsGroup *)[self.groupArray objectAtIndex:indexPath.row]) numberOfAssets]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OldAssetChooseController *viewController = [[OldAssetChooseController alloc] init];
    viewController.group = ((ALAssetsGroup *)[self.groupArray objectAtIndex:indexPath.row]);
    [self.navigationController pushViewController:viewController animated:YES];
    self.selectedIndexPath = indexPath;
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

- (ALAssetsLibrary *)assetsLibrary {
    if (!_assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}

@end
