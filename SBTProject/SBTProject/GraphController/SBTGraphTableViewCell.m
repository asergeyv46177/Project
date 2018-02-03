//
//  SBTGraphTableViewCell.m
//  SBTProject
//
//  Created by Сергей Алтухов on 09.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTGraphTableViewCell.h"
#import <Masonry.h>


static CGFloat const SBTHeightSeparator = 2.0;
static CGFloat const SBTOffset = 20.0;


@implementation SBTGraphTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _nameGraphLabel = [UILabel new];
        _nameGraphLabel.numberOfLines = 0;
        _nameGraphLabel.textAlignment = NSTextAlignmentCenter;
        _nameGraphLabel.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_nameGraphLabel];
        
        _viewGraphImageView = [UIImageView new];
        _viewGraphImageView.layer.masksToBounds = YES;
        _viewGraphImageView.layer.cornerRadius = 10;
        [self.contentView addSubview:_viewGraphImageView];
        
        [self createConstraints];
        [self createLineMarking];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


#pragma mark - Table view cell view customization

- (void)createConstraints
{
    CGRect bounds = self.contentView.bounds;
    CGFloat width = CGRectGetWidth(bounds);
    
    [_nameGraphLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(SBTOffset);
    }];
    
    [_viewGraphImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(_nameGraphLabel.mas_bottom).with.offset(SBTOffset);
        make.left.mas_greaterThanOrEqualTo(self.contentView.mas_left).with.offset(SBTOffset);
        make.right.mas_greaterThanOrEqualTo(self.contentView.mas_right).with.offset( - SBTOffset);
        make.height.mas_equalTo(width / 1.5);
    }];
}

- (void)createLineMarking
{
    UIImageView *separatorCell = [UIImageView new];
    separatorCell.backgroundColor = [UIColor colorWithRed:206/255.f green:206/255.f blue:210/255.f alpha:1];
    separatorCell.layer.cornerRadius = SBTHeightSeparator / 2;
    [self.contentView addSubview:separatorCell];
    [separatorCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_viewGraphImageView.mas_bottom).with.offset(SBTOffset);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(SBTOffset / 2);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset( - SBTOffset / 2);
        make.height.mas_equalTo(SBTHeightSeparator);
    }];
}


#pragma mark - Table view cell for reusable

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.nameGraphLabel.text = @"";
    self.viewGraphImageView.image = nil;
}

@end
