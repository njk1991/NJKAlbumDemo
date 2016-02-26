//
//  BaseDataSource.h
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//typedef void(^CellConfigBlock)(id cell, id item);

@interface BaseDataSource : NSObject

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
//@property (nonatomic, copy) CellConfigBlock configBlock;

//- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier
//                           configBlock:(CellConfigBlock)configBlock;
- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
