//
//  PhotoScrollView.m
//  MyPhotoShow
//
//  Created by NEW on 15/12/14.
//  Copyright © 2015年 CCJ. All rights reserved.
//

#import "PhotoScrollView.h"

#define kMaxDragLength    (200)

#define kMaxToggleLength        (25)



@interface PhotoScrollView ()


@property (nonatomic, assign) CGPoint startPoint;

@property (nonatomic, assign) BOOL flipped;

@end

@implementation PhotoScrollView

- (id)initWithFrame:(CGRect)aFrame {
    if ((self = [super initWithFrame:aFrame])) {
        [self setShowsVerticalScrollIndicator:NO];
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}


- (id)initWithChildView:(UIView *)aChildView {
    if (self = [super init]) {
        [self setShowsVerticalScrollIndicator:NO];
        self.showsHorizontalScrollIndicator = NO;
        [self setChildView: aChildView];
    }
    return self;
}


- (id)initWithFrame:(CGRect)aFrame andChildView:(UIView *)aChildView  {
    if (self = [super initWithFrame:aFrame]) {
        [self setChildView: aChildView];
    }
    return self;
}



-(void)setChildView:(UIView *)aChildView {
    if (_childView != aChildView) {
        [_childView removeFromSuperview];
        _childView = aChildView;
        [super addSubview:_childView];
//        [self addgestureWithChildView];

        [self setContentOffset:CGPointZero];
    }
}

//-(void)addgestureWithChildView
//{
//    UIPanGestureRecognizer *aPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
//    aPanGesture.minimumNumberOfTouches=2;
//    aPanGesture.maximumNumberOfTouches=2;
//    aPanGesture.delegate = self;
//    [self addGestureRecognizer:aPanGesture];
//
//}
//
//
//- (void)panned:(UIPanGestureRecognizer *)panGesture
//{
//    
//    NSLog(@"拖动我");
//    if (panGesture.state == UIGestureRecognizerStateBegan)
//    {
//        _startPoint = panGesture.view.center;
//        _flipped = NO;
//        
//        if(_stopScrollView){
//        
//            _stopScrollView();
//        }
//    }
//    else if (panGesture.state == UIGestureRecognizerStateChanged)
//    {
//        CGPoint point = [panGesture translationInView:self];
//        
//        UIView *pannedView = panGesture.view;
//        
//        CGFloat distance = sqrtf(point.x * point.x + point.y * point.y);
//        
//        // control the position of the panned view
//        if (distance < kMaxDragLength)
//        {
//            // move the current selected view with the touched point
//            pannedView.center = CGPointMake(_startPoint.x + point.x, _startPoint.y + point.y);
//        }
//        else
//        {
//            float x = (point.x / distance) * kMaxDragLength;
//            float y = (point.y / distance) * kMaxDragLength;
//            
//            pannedView.center = CGPointMake(_startPoint.x + x, _startPoint.y + y);
//        }
//        
//        // control the postition of the other view
//        // if distance reach the threshold, bring the view behind to front and animate
//        if (distance > kMaxToggleLength && !_flipped)
//        {
//            _flipped = YES;
//            
////            [self increaseIndex];
////            
////            UIView *frontView = self.couple[_frontIndex];
////            [self bringViewToFrontAnimate:frontView];
//            
//        }
//    }
//    else if (panGesture.state == UIGestureRecognizerStateEnded)
//    {
//        // release the panned view and animate
//        
//        
//        if(_startScrollView){
//            _startScrollView();
//        }
//        
//        [UIView animateWithDuration:0.2
//                              delay:0
//                            options:UIViewAnimationOptionCurveEaseInOut
//                         animations:^{
//                             panGesture.view.center = _startPoint;
//                         }
//                         completion:^(BOOL finished) {
////                             [self setMultiImageViews];
//                         }];
//    }
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    
//    if([gestureRecognizer isKindOfClass:[UIGestureRecognizer class]]){
//        if(gestureRecognizer.view ==self){
//            
//            if(self.zoomScale>1){
//                return NO;
//            }else{
//                return YES;
//            }
//        }else{
//            return NO;
//        }
//    }else
//    {
//        return NO;
//    }
//    //UIScrollView 和 子View上的UIPanGestureRecognizer都会响应
////    return NO;//只响应子View上的UIPanGestureRecognizer
//}

#pragma mark UIScrollView


// Rather than the default behaviour of a {0,0} offset when an image is too small to fill the UIScrollView we're going to return an offset that centres the image in the UIScrollView instead.
- (void)setContentOffset:(CGPoint)anOffset {
    if(_childView != nil) {
        CGSize zoomViewSize = _childView.frame.size;
        CGSize scrollViewSize = self.bounds.size;
        
        if(zoomViewSize.width < scrollViewSize.width) {
            anOffset.x = -(scrollViewSize.width - zoomViewSize.width) / 2.0;
        }
        
        if(zoomViewSize.height < scrollViewSize.height) {
            anOffset.y = -(scrollViewSize.height - zoomViewSize.height) / 2.0;
        }
    }
    
    super.contentOffset = anOffset;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com