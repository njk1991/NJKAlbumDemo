//
//  PhotoScrollView.h
//  MyPhotoShow
//
//  Created by NEW on 15/12/14.
//  Copyright © 2015年 CCJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoScrollView : UIScrollView<UIGestureRecognizerDelegate>


@property (nonatomic,strong) UIView *childView;


@property (nonatomic,copy) void (^stopScrollView) (void);

@property (nonatomic,copy) void (^startScrollView) (void);


- (id)initWithChildView:(UIView *)aChildView;

- (id)initWithFrame:(CGRect)aFrame andChildView:(UIView *)aChildView;




@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com