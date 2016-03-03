//
//  BaseAlbumChooseController.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "BaseAlbumChooseController.h"

@interface BaseAlbumChooseController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation BaseAlbumChooseController

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
//    self.tableView.frame = self.view.bounds;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initNavigationBar];
    [self configTableViewInsets];
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

- (void)configTableViewInsets {
    CGFloat navigationBarH = 0;
    if (self.navigationController.navigationBar) {
        navigationBarH = CGRectGetHeight(self.navigationController.navigationBar.frame);
    }
    UIEdgeInsets insets = [self viewInsets];
    self.tableView.contentInset = UIEdgeInsetsMake(navigationBarH + insets.top, insets.left, insets.bottom, insets.right);
}

#pragma mark - UIBarButtonItem Action

- (void)rightBarButtonItemAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        UIView *hiddenView =[ [UIView alloc]init];
        hiddenView.backgroundColor = [UIColor clearColor];
        [_tableView setTableFooterView:hiddenView];
        
    }
    return _tableView;
}

@end
