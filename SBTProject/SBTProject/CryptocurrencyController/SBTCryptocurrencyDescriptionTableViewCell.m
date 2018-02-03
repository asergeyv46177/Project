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
static CGFloat const SBTWidthNameDescriptionLabel = 135.0;
static NSString *const SBTAffiliateURL = @"Affiliate URL";


@interface SBTCryptocurrencyDescriptionTableViewCell ()

@property (nonatomic, copy) NSArray *nameArray;

@end


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
        
        _nameArray = @[@"Symbol",@"Start date",@"Id",@"Algorithm",@"Block time",@"Block reward",
            @"Total coin supply",@"Affiliate URL",@"Twitter"];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createConstraints];
    }
    return self;
}


#pragma mark - Table view cell view customization

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

#pragma mark - Table view cell for usable

- (void)setupContentCellWithIndexRow:(NSInteger)row content:(NSArray *)content
{
    self.nameDescriptionLabel.text = self.nameArray[row];
    self.contentDescriptionLabel.text = content[row];
    if ([self.nameArray[row] isEqualToString:SBTAffiliateURL])
    {
        self.contentDescriptionLabel.textColor = UIColor.blueColor;
    }
}


#pragma mark - Table view cell for reusable

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.contentDescriptionLabel.textColor = UIColor.blackColor;
    self.nameDescriptionLabel.text = @"";
    self.contentDescriptionLabel.text = @"";
}

@end
