//
//  NJKImagePickerNavigationController.m
//  NJKImagePickerDemo
//
//  Created by JiakaiNong on 16/2/16.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "NJKImagePickerNavigationController.h"
#import "NJKAssetsCollectionPickerController.h"
#import "NJKImagePickerNotificationDefine.h"

@implementation NJKImagePickerNavigationController

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imagePickerDidPickImageNotification:) name:kImagePickerDidPickImageNotification object:nil];
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

#pragma mark - Notifications

- (void)imagePickerDidPickImageNotification:(NSNotification *)notification {
    id object = [notification object];
    if ([object isKindOfClass:[UIImage class]]) {
        UIImage *image = (UIImage *)object;
        NSLog(@"%@",NSStringFromCGSize(image.size));
    } else {
        NSLog(@"Wrong type");
    }
}

@end
