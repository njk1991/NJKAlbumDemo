//
//  BaseAlbumChooseController.h
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseAlbumChooseController : BaseViewController

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSMutableArray *groupArray;

@end
