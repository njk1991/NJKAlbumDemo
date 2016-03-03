//
//  PickerNavigationController.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "PickerNavigationController.h"
#import "BaseViewController.h"
#import "PickedImageCell.h"
#import "AlbumNotification.h"
#import "UIImageViewButton.h"
#import "UIColor+Additions.h"
//#import "UIImage+Resize.h"

#define BOTTOM_VIEW_HEIGHT 142
#define INFO_VIEW_HEIGHT 49
#define COLLECTION_VIEW_HEIGHT 93
#define CELL_IDENTIFIER @"cellIdentifier"

@interface PickerNavigationController () <AlbumNotificationReciever, UICollectionViewDataSource, UICollectionViewDelegate, PickedImageCellDelegate>

@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *pickedCountLabel;
@property (nonatomic, strong) UICollectionView *pickedImageCollectionView;

@end

@implementation PickerNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        [self addNotification];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isMultiPicker) {
        [self.view addSubview:self.bottomView];
        [self.bottomView addSubview:self.infoView];
        [self.bottomView addSubview:self.pickedImageCollectionView];
        [self.infoView addSubview:[self tipLabel]];
        [self.infoView addSubview:[self nextStepButton]];
    }
}

- (void)dealloc {
    [self removeNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pickedImageArray.count;
//    return 5;
}

- (PickedImageCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PickedImageCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    cell.delegate = self;
    [cell configCellWithImage:self.pickedImageArray[indexPath.row]];
    return cell;
}

#pragma mark - AlbumNotificationReciever

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRecieveImageNotification:) name:ALBUM_DID_PICK_IMAGE_NOTIFICATION object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALBUM_DID_PICK_IMAGE_NOTIFICATION object:nil];
}

#pragma mark - Reciever Action

- (void)didRecieveImageNotification:(NSNotification *)notification {
    UIImage *image = notification.object;
    if (self.isMultiPicker) {
        if (self.pickedImageArray.count < self.maximumPickCount) {
            [self.pickedImageArray addObject:image];
            self.pickedCountLabel.text = [NSString stringWithFormat:@"%@",@(self.pickedImageArray.count)];
            [self.pickedImageCollectionView reloadData];
            NSLog(@"%@",self.pickedImageArray);
        }
    } else {
        NSLog(@"%@",image);
    }
}

#pragma mark - PickedImageCellDelegate

- (void)assetsCell:(PickedImageCell *)cell didClickDeleteButton:(UIButton *)sender {
    NSIndexPath *indexPath = [self.pickedImageCollectionView indexPathForCell:cell];
    NSInteger index = indexPath.row;
    [self.pickedImageArray removeObjectAtIndex:index];
    [self.pickedImageCollectionView reloadData];
}

#pragma mark - Action

- (void)nextStepAction:(id)sender {
    NSLog(@"%@",self.pickedImageArray);
}

#pragma mark - Setter & Getter

- (UICollectionViewFlowLayout *)assetsFlowLayout {
    CGFloat navigationBarH = 0;
    CGFloat minimumInteritemSpacing = 0;
    CGFloat minimumLineSpacing = 10;
    CGFloat itemWidth = 78.5;
    CGFloat topInset = 9.5;
    CGFloat bottomInset = 5;
    
    if (self.navigationController.navigationBar) {
        navigationBarH = CGRectGetHeight(self.navigationController.navigationBar.frame);
    }
    
    UICollectionViewFlowLayout *assetsFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    assetsFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    assetsFlowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    assetsFlowLayout.minimumInteritemSpacing = minimumInteritemSpacing;
    assetsFlowLayout.minimumLineSpacing = minimumLineSpacing;
    assetsFlowLayout.sectionInset = UIEdgeInsetsMake(topInset, minimumLineSpacing, bottomInset, minimumLineSpacing);
    return assetsFlowLayout;
}

- (UICollectionView *)pickedImageCollectionView {
    if (!_pickedImageCollectionView) {
        _pickedImageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, BOTTOM_VIEW_HEIGHT - COLLECTION_VIEW_HEIGHT, SCREEN_WIDTH, COLLECTION_VIEW_HEIGHT) collectionViewLayout:[self assetsFlowLayout]];
        [_pickedImageCollectionView registerClass:[PickedImageCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
        _pickedImageCollectionView.backgroundColor = [UIColor clearColor];
        _pickedImageCollectionView.clipsToBounds = NO;
        _pickedImageCollectionView.alwaysBounceHorizontal = YES;
        _pickedImageCollectionView.showsHorizontalScrollIndicator = NO;
        _pickedImageCollectionView.dataSource = self;
        _pickedImageCollectionView.delegate = self;
    }
    return _pickedImageCollectionView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - BOTTOM_VIEW_HEIGHT, SCREEN_WIDTH, BOTTOM_VIEW_HEIGHT)];
        _bottomView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"AlbumBottomBar"]];
        self.contentViewInsets = UIEdgeInsetsMake(0, 0, BOTTOM_VIEW_HEIGHT, 0);
    }
    return _bottomView;
}

- (UIView *)infoView {
    if (!_infoView) {
        _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, INFO_VIEW_HEIGHT)];
    }
    return _infoView;
}

- (UILabel *)tipLabel {
    CGFloat leftInset = 10;
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftInset, 0, SCREEN_WIDTH / 2, INFO_VIEW_HEIGHT)];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.text = [NSString stringWithFormat:@"最多%@张都能拼哦",@(self.maximumPickCount)];
    return tipLabel;
}

- (UIImageViewButton *)nextStepButton {
    
    CGFloat nextStepButtonWidth = 84;
    CGFloat nextStepButtonHeight = 30;
    CGFloat rightInset = 9;
    
    UIImageViewButton *nextStepButton = [[UIImageViewButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - (nextStepButtonWidth + rightInset), (INFO_VIEW_HEIGHT - nextStepButtonHeight) / 2, nextStepButtonWidth, nextStepButtonHeight)];
    nextStepButton.backgroundColor = [UIColor clearColor];
    
    UIImageView *nextStepImageView = [[UIImageView alloc] initWithFrame:nextStepButton.bounds];
    [nextStepImageView setImage:[UIImage imageNamed:@"AlbumNextStep"]];
    [nextStepImageView setHighlightedImage:[UIImage imageNamed:@"AlbumNextStep_hover"]];
    [nextStepButton addImageView:nextStepImageView];
    
    CGPoint nextStepLabelCenter = CGPointMake(nextStepButtonWidth / 2 - 13, nextStepButtonHeight / 2);
    UILabel *nextStepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, nextStepButtonWidth, nextStepButtonHeight)];
    [nextStepLabel setBackgroundColor:[UIColor greenColor]];
    nextStepLabel.text = @"下一步";
    [nextStepLabel setTextColor:[UIColor whiteColor]];
    [nextStepLabel setHighlightedTextColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]];
    [nextStepLabel setFont:[UIFont systemFontOfSize:15]];
    [nextStepLabel sizeToFit];
    nextStepLabel.center = nextStepLabelCenter;
    [nextStepButton addLableText:nextStepLabel];
    
    CGPoint pickedCountLabelCenter = CGPointMake(nextStepButtonWidth / 2 + 27, nextStepButtonHeight / 2);
    self.pickedCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, nextStepButtonHeight, nextStepButtonHeight)];
    self.pickedCountLabel.center = pickedCountLabelCenter;
    self.pickedCountLabel.text = @"0";
    self.pickedCountLabel.textColor = [UIColor colorWithRGBHexString:@"f5808e"];
    [self.pickedCountLabel setTextAlignment:NSTextAlignmentCenter];
    [self.pickedCountLabel setBackgroundColor:[UIColor redColor]];
    [self.pickedCountLabel setFont:[UIFont systemFontOfSize:15]];
    [nextStepButton addLableText:self.pickedCountLabel];
    
    [nextStepButton addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    return nextStepButton;
}

- (NSMutableArray *)pickedImageArray {
    if (!_pickedImageArray) {
        _pickedImageArray = [[NSMutableArray alloc] initWithCapacity:self.maximumPickCount];
    }
    return _pickedImageArray;
}

@end
