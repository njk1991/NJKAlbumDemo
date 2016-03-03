//
//  PickerNavigationController.h
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerNavigationController : UINavigationController

@property (nonatomic, assign) UIEdgeInsets contentViewInsets;
@property (nonatomic, assign, getter = isMultiPicker) BOOL multiPicker;
@property (nonatomic, assign) NSInteger maximumPickCount;
@property (nonatomic, strong) NSMutableArray *pickedImageArray;

@end
