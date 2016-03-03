//
//  UIImageViewButton.m
//  puzzleApp
//
//  Created by lihuan on 14-7-7.
//  Copyright (c) 2014年 Allen Chen. All rights reserved.
//

#import "UIImageViewButton.h"

@implementation UIImageViewButton
@synthesize highlighted = _highlighted ;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _highlighted = NO ;
        // Initialization code
    }
    return self;
}

-(void)addImageView:(UIImageView*)addImageView{
    addImageView.highlighted = _highlighted ;
    addImageView.tag = 88 ;
    [self addSubview:addImageView];
}

-(void)addLableText:(UILabel*)label{
    label.highlighted = _highlighted ;
    label.tag = 99 ;
    [label setBackgroundColor:[UIColor clearColor]];
    [self addSubview:label];
}

-(void)setHighlighted:(BOOL)highlighted{
    _highlighted = highlighted ;
    for (UIImageView *tmp in self.subviews) {
        if (tmp.tag == 88) {
            tmp.highlighted = _highlighted ;
        }
    }
    for (UILabel *tmp in self.subviews) {
        if (tmp.tag == 99) {
            tmp.highlighted = _highlighted ;
        }
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
