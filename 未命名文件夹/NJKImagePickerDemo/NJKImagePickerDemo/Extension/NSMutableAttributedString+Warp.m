//
//  NSMutableAttributedString+Warp.m
//  NJKAttributedLabelDemo
//
//  Created by JiakaiNong on 16/2/3.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "NSMutableAttributedString+Warp.h"

@implementation NSMutableAttributedString (Warp)

- (void)appendAttributedString:(NSAttributedString *)attrString shouldWrap:(BOOL)shouldWrap {
    if (shouldWrap) {
        [self appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];
    }
    [self appendAttributedString:attrString];
}

@end
