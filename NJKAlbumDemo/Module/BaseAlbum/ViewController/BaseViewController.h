//
//  BaseViewController.h
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/3/1.
//  Copyright © 2016年 poco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerNavigationController.h"

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height
#define SCREEN_SCALE [UIScreen mainScreen].scale

@interface BaseViewController : UIViewController

- (UIEdgeInsets)viewInsets;

@end
