//
//  SBTNewsTableViewCell.m
//  SBTProject
//
//  Created by Sergey Altukhov on 17.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTNewsTableViewCell.h"
#import "SBTDataNewsModel.h"
#import <Masonry.h>


static CGFloat const SBTOffset = 10.0;
static CGFloat const SBTHeightSeparator = 2.0;

static NSString *const SBTAuthor = @"AUTHOR: ";


@interface SBTNewsTableViewCell ()

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *authorLabel;

@end


@implementation SBTNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _dateLabel = [UILabel new];
        _dateLabel.textColor = [UIColor colorWithRed:206/255.0 green:206/255.0 blue:210/255.0 alpha:1.0];
        _dateLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_dateLabel];
        
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
        [self.contentView addSubview:_titleLabel];
        
        _descriptionLabel = [UILabel new];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_descriptionLabel];
        
        _authorLabel = [UILabel new];
        _authorLabel.textAlignment = NSTextAlignmentRight;
        _authorLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_authorLabel];
        
        [self createConstraints];
        [self createLineMarking];
    }
    return self;
}


#pragma mark - Table view cell view customization

- (void)createConstraints
{
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(SBTOffset / 2);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(SBTOffset);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset( - SBTOffset);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_dateLabel.mas_bottom).with.offset(SBTOffset * 2);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(SBTOffset);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset( - SBTOffset);
    }];
    
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(SBTOffset * 2);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(SBTOffset);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset( - SBTOffset);
    }];
    
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_descriptionLabel.mas_bottom).with.offset(SBTOffset);
        make.left.mas_equalTo(self.contentView.mas_centerX).with.offset(SBTOffset);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset( - SBTOffset);
    }];
}

- (void)createLineMarking
{
    UIImageView *separator = [UIImageView new];
    separator.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1];
    [self.contentView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_authorLabel.mas_bottom).with.offset(SBTOffset);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(SBTHeightSeparator);
    }];
}


#pragma mark - Table view cell for usable

- (void)setupContentCell:(SBTDataNewsModel *)newsModel
{
    self.dateLabel.text = newsModel.dateString;
    self.titleLabel.text = newsModel.titleString;
    self.descriptionLabel.text = newsModel.descriptionString;
    self.authorLabel.attributedText = [self attributedString:newsModel.authorString];
}

- (NSAttributedString *)attributedString:(NSString *)authorString
{
    NSString *author = @"";
    if (authorString && ![authorString isEqual:[NSNull null]])
    {
        author = authorString;
    }
    NSMutableAttributedString *attributedString  = [[NSMutableAttributedString alloc]
        initWithString:[NSString stringWithFormat:@"%@%@",SBTAuthor, author]];
    NSRange range = NSMakeRange(SBTAuthor.length, author.length);
    UIColor *textColor = [UIColor colorWithRed:142/255.f green:142/255.f blue:147/255.f alpha:1.0];
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    return attributedString;
}


#pragma mark - Table view cell for reusable

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.dateLabel.text = @"";
    self.titleLabel.text = @"";
    self.descriptionLabel.text = @"";
    self.authorLabel.attributedText = nil;
}

@end
