//
//  BaseDataSource.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "BaseDataSource.h"

@implementation BaseDataSource

//- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier
//                           configBlock:(CellConfigBlock)configBlock {
//    if (self = [super init]) {
//        self.cellIdentifier = cellIdentifier;
//        self.configBlock = [configBlock copy];
//        self.items = [@[] mutableCopy];
//    }
//    return self;
//}

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier {
    if (self = [super init]) {
        self.cellIdentifier = cellIdentifier;
        self.items = [@[] mutableCopy];
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[indexPath.row];
}

@end
