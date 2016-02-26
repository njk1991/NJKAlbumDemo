//
//  NSMutableAttributedString+Warp.h
//  NJKAttributedLabelDemo
//
//  Created by JiakaiNong on 16/2/3.
//  Copyright © 2016年 poco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Warp)

- (void)appendAttributedString:(NSAttributedString *)attrString shouldWrap:(BOOL)shouldWrap;

@end
