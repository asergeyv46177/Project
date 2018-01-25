//
//  SBTNewsTableViewCell.m
//  SBTProject
//
//  Created by Sergey Altukhov on 17.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTNewsTableViewCell.h"
#import <Masonry.h>


static CGFloat const SBTOffset = 10.0;
static CGFloat const SBTHeightSeparator = 2.0;


@implementation SBTNewsTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _publishedNewsLabel = [UILabel new];
        _publishedNewsLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_publishedNewsLabel];
        
        _titleNewsLabel = [UILabel new];
        _titleNewsLabel.numberOfLines = 0;
        _titleNewsLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
        [self.contentView addSubview:_titleNewsLabel];
        
        _descriptionNewsLabel = [UILabel new];
        _descriptionNewsLabel.numberOfLines = 0;
        _descriptionNewsLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_descriptionNewsLabel];
        
        _sourceNameNewsLabel = [UILabel new];
        _sourceNameNewsLabel.backgroundColor = UIColor.redColor;
        _sourceNameNewsLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_sourceNameNewsLabel];
        
        _authorNewsLabel = [UILabel new];
        _authorNewsLabel.backgroundColor = UIColor.redColor;
        _authorNewsLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_authorNewsLabel];
        
        [self createConstraints];
    }
    return self;
}

- (void)createConstraints
{
    [_publishedNewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(SBTOffset/2);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(SBTOffset);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-SBTOffset);
    }];
    [_titleNewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_publishedNewsLabel.mas_bottom).with.offset(SBTOffset);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(SBTOffset);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-SBTOffset);
    }];
    [_descriptionNewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleNewsLabel.mas_bottom).with.offset(SBTOffset);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(SBTOffset);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-SBTOffset);
    }];
    [_sourceNameNewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_descriptionNewsLabel.mas_bottom).with.offset(SBTOffset/2);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(SBTOffset);
        make.right.mas_equalTo(self.contentView.mas_centerX);
    }];
    [_authorNewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sourceNameNewsLabel.mas_bottom).with.offset(SBTOffset/2);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(SBTOffset);
        make.right.mas_equalTo(self.contentView.mas_centerX);
    }];
    UIImageView *separator = [UIImageView new];
    separator.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1];
    [self.contentView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_authorNewsLabel.mas_bottom).with.offset(SBTOffset/2);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(SBTHeightSeparator);
    }];
    
}


@end

















