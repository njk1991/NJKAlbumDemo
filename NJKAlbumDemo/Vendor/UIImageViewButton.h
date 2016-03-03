//
//  UIImageViewButton.h
//  puzzleApp
//
//  Created by lihuan on 14-7-7.
//  Copyright (c) 2014年 Allen Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageViewButton : UIButton{
    BOOL _highlighted;
}
-(void)addImageView:(UIImageView*)addImageView;
-(void)addLableText:(UILabel*)label;
-(void)setHighlighted:(BOOL)highlighted;
@property (nonatomic, assign) BOOL highlighted;

@end
