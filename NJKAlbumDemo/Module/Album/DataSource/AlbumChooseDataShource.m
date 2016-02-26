//
//  AlbumChooseDataShource.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "AlbumChooseDataShource.h"
#import "AlbumCell.h"
//#import "PHSourceManager.h"

@implementation AlbumChooseDataShource

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self initCellConfigBlock];
//    }
//    return self;
//}

- (void)initCellConfigBlock {
//    self.configBlock = ^CellConfigBlock
//    self.configBlock = ^(AlbumCell *cell, AlbumObj *group)
//    {
//        if (nil == group.posterImage)
//        {
//            NSInteger cTag = cell.tag; // to determin if cell is reused
//            
//            [[ImageDataAPI sharedInstance] getPosterImageForAlbumObj:group
//                                                          completion:^(BOOL ret, id obj)
//             {
//                 group.posterImage = (UIImage *)obj;
//                 
//                 if (cell.tag == cTag) [cell configureWithAlbumObj:group];
//             }];
//        }
//        else
//        {
//            [cell configureWithAlbumObj:group];
//        }
//    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
//    PHAsset *asset = [self itemAtIndexPath:indexPath];
    return cell;
}

@end
