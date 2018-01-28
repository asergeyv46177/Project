//
//  SBTCryptocurrencyTableViewCell.m
//  SBTProject
//
//  Created by Sergey Altukhov on 11.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTCryptocurrencyTableViewCell.h"
#import "SBTDataPriceModel.h"
#import <Masonry.h>


static CGFloat const SBTOffset = 15.0;
static CGFloat const SBTHeightImage = 50.0;
static CGFloat const SBTWidthImage = 38.5;
static CGFloat const SBTHeightSeparator = 2.0;


@implementation SBTCryptocurrencyTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _iconCryptoImageView = [UIImageView new];
        [self.contentView addSubview:_iconCryptoImageView];
        
        _symbolCryptoLabel = [UILabel new];
        _symbolCryptoLabel.font= [UIFont fontWithName:@"Arial-BoldMT" size:15];
        [self.contentView addSubview:_symbolCryptoLabel];
        
        _nameCryptoLabel = [UILabel new];
        _nameCryptoLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameCryptoLabel];
        
        _priceCryptoLabel = [UILabel new];
        _priceCryptoLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
        [self.contentView addSubview:_priceCryptoLabel];
        
        _percent24hLabel = [UILabel new];
        _percent24hLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_percent24hLabel];
        
        _percent7dLabel = [UILabel new];
        _percent7dLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_percent7dLabel];
        
        [self createConstraints];
        [self createLineMarking];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)createConstraints
{
    [_iconCryptoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(SBTOffset);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(SBTOffset);
        make.height.mas_lessThanOrEqualTo(SBTHeightImage);
        make.width.mas_equalTo(SBTWidthImage);
    }];
    
    [_symbolCryptoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_iconCryptoImageView.mas_centerY);
        make.left.mas_equalTo(_iconCryptoImageView.mas_right).with.offset(SBTOffset);
    }];
    
    [_nameCryptoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_iconCryptoImageView.mas_centerY);
        make.left.mas_equalTo(_symbolCryptoLabel.mas_right).with.offset(SBTOffset);
    }];
    
    [_priceCryptoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_iconCryptoImageView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-SBTOffset * 3);
    }];
    
    [_percent24hLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceCryptoLabel.mas_bottom).with.offset(SBTOffset * 2);
        make.right.mas_equalTo(self.contentView.mas_centerX).with.offset( - SBTOffset);
    }];
    
    [_percent7dLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceCryptoLabel.mas_bottom).with.offset(SBTOffset * 2);
        make.left.mas_equalTo(self.contentView.mas_centerX).with.offset(SBTOffset);
    }];

}

- (void)createLineMarking
{
    UIImageView *separatorNameAndSymbol = [UIImageView new];
    separatorNameAndSymbol.backgroundColor = UIColor.blackColor;
    [self.contentView addSubview:separatorNameAndSymbol];
    [separatorNameAndSymbol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_iconCryptoImageView.mas_centerY);
        make.left.mas_equalTo(_symbolCryptoLabel.mas_right).with.offset(SBTOffset / 2);
        make.height.mas_equalTo(_symbolCryptoLabel.font.pointSize - SBTHeightSeparator * 2);
        make.width.mas_equalTo(SBTHeightSeparator);
    }];
    
    UIImageView *separatorPercent = [UIImageView new];
    separatorPercent.backgroundColor = [UIColor colorWithWhite:.98f alpha:1];
    [self.contentView addSubview:separatorPercent];
    [separatorPercent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_priceCryptoLabel.mas_bottom).with.offset(SBTOffset);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(SBTOffset * 2);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-SBTOffset * 2);
        make.height.mas_equalTo(SBTHeightSeparator);
    }];
    
    UIImageView *separatorCell = [UIImageView new];
    separatorCell.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1];
    [self.contentView addSubview:separatorCell];
    [separatorCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_percent7dLabel.mas_bottom).with.offset(SBTOffset);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(SBTHeightSeparator);
    }];
}


#pragma mark - Methods for using cell

- (void)setDataCell:(SBTDataPriceModel *)priceModel
{
    self.iconCryptoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", priceModel.nameString]];
    self.nameCryptoLabel.text = priceModel.nameString;
    self.symbolCryptoLabel.text = priceModel.symbolString;
    self.priceCryptoLabel.text = [NSString stringWithFormat:@"%.2f USD", priceModel.priceUSDFloat];
    self.percent24hLabel.attributedText = [self attributedString:priceModel.percentChange24hFloat prefixString:@"24h: "];
    self.percent7dLabel.attributedText = [self attributedString:priceModel.percentChange7dFloat prefixString:@"7d: "];
}

- (NSAttributedString *)attributedString:(CGFloat)valueFloat prefixString:(NSString *)prefix
{
    NSString *valueString = [NSString stringWithFormat:@"%.2f\%\%", valueFloat];
    NSMutableAttributedString *attributedString  = [[NSMutableAttributedString alloc] initWithString:
        [NSString stringWithFormat:@"%@%@",prefix, valueString]];
    
    UIColor *fontColor = valueFloat <= 0 ? UIColor.redColor : UIColor.greenColor;
    NSRange range = NSMakeRange(prefix.length, valueString.length);
    
    NSDictionary *attributedDictionary = @{NSForegroundColorAttributeName : fontColor,
        NSFontAttributeName : [UIFont fontWithName:@"Arial-BoldMT" size:15]};
    [attributedString addAttributes:attributedDictionary range:range];
    return attributedString;
}


#pragma mark - Methods for reusing cell

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.iconCryptoImageView.image = nil;
    self.nameCryptoLabel.text = @"";
    self.symbolCryptoLabel.text = @"";
    self.priceCryptoLabel.text = @"";
    self.percent24hLabel.text = @"";
    self.percent7dLabel.text = @"";
}

@end
