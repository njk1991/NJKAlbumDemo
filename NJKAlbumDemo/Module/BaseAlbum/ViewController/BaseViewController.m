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
    
    CALayer *blackMaskLayer = [CALayer layer];
    blackMaskLayer.frame = backgroundImageView.bounds;
    blackMaskLayer.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
    [backgroundImageView.layer addSublayer:blackMaskLayer];
    
    UIImageView *blurBackgroundImageView = [[UIImageView alloc] initWithFrame:backgroundImageView.bounds];
    blurBackgroundImageView.image = self.blurBackgroundImage;
    [backgroundImageView addSubview:blurBackgroundImageView];
}

- (void)initTopBar {
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName : [UIColor whiteColor],
                                                           NSShadowAttributeName : shadow
                                                           }];
    if (SYSTEM_VERSION >= 7.0) {
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ShareTopBarBackgroundImage"] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }else{
        [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    }
}

- (UIEdgeInsets)viewInsets {
    PickerNavigationController *navigationController = (PickerNavigationController *)self.navigationController;
    return navigationController.contentViewInsets;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
