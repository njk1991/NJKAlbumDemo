//
//  BaseViewController.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/3/1.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    if (SYSTEM_VERSION >= 7.0f) {
//        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
//    }
    [self initBackground];
    [self initTopBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initBackground {
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImageView.image = [UIImage imageNamed:@"ShareBackgroundImage.jpg"];
    [self.view addSubview:backgroundImageView];
}

- (void)initTopBar {
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                           UITextAttributeTextColor : [UIColor whiteColor],
                                                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero]
                                                           }];
    if (SYSTEM_VERSION >= 7.0) {
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ShareTopBarBackgroundImage"] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }else{
        [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
