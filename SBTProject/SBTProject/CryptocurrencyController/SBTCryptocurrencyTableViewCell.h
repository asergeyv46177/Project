//
//  SBTCryptocurrencyTableViewCell.h
//  SBTProject
//
//  Created by Sergey Altukhov on 11.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBTDataPriceModel;

@interface SBTCryptocurrencyTableViewCell : UITableViewCell


@property (nonatomic, strong) UIImageView *iconCryptoImageView;
@property (nonatomic, strong) UILabel *nameCryptoLabel;
@property (nonatomic, strong) UILabel *symbolCryptoLabel;
@property (nonatomic, strong) UILabel *priceCryptoLabel;
@property (nonatomic, strong) UILabel *percent24hLabel;
@property (nonatomic, strong) UILabel *percent7dLabel;

- (void)setupContentCell:(SBTDataPriceModel *)priceModel;


@end
