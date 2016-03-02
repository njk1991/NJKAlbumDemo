//
//  BaseViewController.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/3/1.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "BaseViewController.h"

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (SYSTEM_VERSION >= 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
