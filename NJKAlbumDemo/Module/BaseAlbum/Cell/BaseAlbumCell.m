//
//  BaseAlbumCell.m
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/2/25.
//  Copyright © 2016年 poco. All rights reserved.
//

#import "BaseAlbumCell.h"

@interface BaseAlbumCell()

@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation BaseAlbumCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.coverImageView];
    [self addSubview:self.detailLabel];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)configCellWithCoverImage:(UIImage *)coverImage
                           title:(NSString *)title
                      imageCount:(NSInteger)imageCount {
    self.coverImageView.image = coverImage;
    self.albumTitle = title;
    
    NSMutableAttributedString *detailAttributedString = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]}];
    if (imageCount) {
        [detailAttributedString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];
        [detailAttributedString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", @(imageCount)] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14] , NSForegroundColorAttributeName : [UIColor grayColor]}]];
    }
    self.detailLabel.attributedText = detailAttributedString;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self refreshCellItemsFrame];
}

- (void)refreshCellItemsFrame {
    
    CGFloat imageViewPedding = 10;
    CGFloat imageViewWidth = self.frame.size.height - 2 * imageViewPedding;
    self.coverImageView.frame = CGRectMake(imageViewPedding, imageViewPedding, imageViewWidth, imageViewWidth);
    
    CGFloat detailLabelPedding = 19;
    self.detailLabel.frame = self.contentView.bounds;
    [self.detailLabel sizeToFit];
    self.detailLabel.frame = CGRectMake(CGRectGetMaxY(self.coverImageView.frame) + detailLabelPedding, (CGRectGetHeight(self.frame) - CGRectGetHeight(self.detailLabel.frame)) * 0.5, CGRectGetWidth(self.detailLabel.frame), CGRectGetHeight(self.detailLabel.frame));
}

#pragma mark - Setter & Getter

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _coverImageView;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}


@end
