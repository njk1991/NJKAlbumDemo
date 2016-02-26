//
//  PhotoBrowserScrollView.h
//  MyPhotoShow
//
//  Created by NEW on 15/12/14.
//  Copyright © 2015年 CCJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoBrowserScrollView : UIScrollView


@property (nonatomic,strong) NSArray *arrayUrl;

@property (nonatomic,assign) int currenIndex;

@property (nonatomic,copy) void (^imageClickBlock) (void);

@property (nonatomic,copy) void (^zoomChange) (CGFloat currentZoom);

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com