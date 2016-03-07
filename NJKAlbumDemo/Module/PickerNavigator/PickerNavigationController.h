//
//  PickerNavigationController.h
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickerNavigationController;

@protocol PickerNavigationControllerDelegate <NSObject, UINavigationControllerDelegate>

- (void)pickerNavigationController:(PickerNavigationController *)controller didSelectImage:(UIImage *)image;
- (void)pickerNavigationController:(PickerNavigationController *)controller didSelectImagesWithArray:(NSArray *)array;

@end

@interface PickerNavigationController : UINavigationController

@property (nonatomic, assign) UIEdgeInsets contentViewInsets;
@property (nonatomic, assign, getter = isMultiPicker) BOOL multiPicker;
@property (nonatomic, assign) NSInteger maximumPickCount;
@property (nonatomic, strong) NSMutableArray *pickedImageArray;

@property (nonatomic, assign) id<PickerNavigationControllerDelegate> pickerDelegate;

- (instancetype)initWithPickerDelegate:(id<PickerNavigationControllerDelegate>)delegate maximumPickCount:(NSInteger)count multiPicker:(BOOL)isMultiPicker;

@end
