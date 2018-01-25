//
//  SBTCryptocurrencyDescriptionTableViewCell.m
//  SBTProject
//
//  Created by Sergey Altukhov on 16.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTCryptocurrencyDescriptionTableViewCell.h"
#import <Masonry.h>


static CGFloat const SBTOffset = 10.0;
static CGFloat const SBTWidthNameDescriptionLabel = 95.0;


@implementation SBTCryptocurrencyDescriptionTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _nameDescriptionLabel = [UILabel new];
        [self.contentView addSubview:_nameDescriptionLabel];
        
        _contentDescriptionLabel = [UILabel new];
        [self.contentView addSubview:_contentDescriptionLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createConstraints];
    }
    return self;
}

- (void)createConstraints
{
    [_nameDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(SBTOffset);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(SBTOffset*3);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-SBTOffset);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(SBTWidthNameDescriptionLabel);
    }];
    [_contentDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameDescriptionLabel.mas_right);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
}

@end
