//
//  SBTDataPreparerTableViewCell.m
//  SBTProject
//
//  Created by Sergey Altukhov on 30.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTDataPreparerTableViewCell.h"
#import <Masonry.h>


static CGFloat const SBTOffset = 10.0;
static CGFloat const SBTHeightImage = 50.0;
static CGFloat const SBTWidthImage = 50.0;


@implementation SBTDataPreparerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _iconImageView = [UIImageView new];
        [self.contentView addSubview:_iconImageView];
        
        _contentLabel = [UILabel new];
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        self.backgroundColor = UIColor.clearColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createConstraint];
    }
    return self;
}


#pragma mark - Table view cell view customization

- (void)createConstraint
{
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(SBTOffset * 2);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(SBTOffset * 2);
        make.height.mas_equalTo(SBTHeightImage);
        make.width.mas_equalTo(SBTWidthImage);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(SBTOffset * 2);
        make.left.mas_equalTo(_iconImageView.mas_right).with.offset(SBTOffset * 2);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset( - SBTOffset * 2);
    }];
}


#pragma mark - Table view cell for reusable

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.iconImageView.image = nil;
    self.contentLabel.text = @"";
}

@end
