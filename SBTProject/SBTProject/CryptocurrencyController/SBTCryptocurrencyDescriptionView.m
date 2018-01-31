//
//  SBTCryptocurrencyDescriptionView.m
//  SBTProject
//
//  Created by Sergey Altukhov on 12.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTCryptocurrencyDescriptionView.h"
#import "SBTCryptocurrencyDescriptionTableViewCell.h"
#import "SBTAnimationStateChange.h"
#import "DescriptionModel+CoreDataProperties.h"
#import <Masonry.h>


static CGFloat const SBTOffset = 10.0;
static CGFloat const SBTHeightImage = 58.5;
static CGFloat const SBTWidthImage = 45.0;
static NSString *const SBTAffiliateURL = @"Affiliate URL";
static NSString *const SBTCryptocurrencyDescriptionCellIdentifier = @"SBTCryptocurrencyDescriptionCellIdentifier";


@interface SBTCryptocurrencyDescriptionView () <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) UIView *descriptionCryptoView;
@property (nonatomic, strong) UIImageView *iconCryptoImageView;
@property (nonatomic, strong) UILabel *nameCryptoLabel;
@property (nonatomic, strong) UITableView *descriptionCryptoTableView;
@property (nonatomic, copy) NSArray *contentArray;


@end


@implementation SBTCryptocurrencyDescriptionView


- (instancetype)initWithSuperview:(UIView *)superview descriptionModel:(DescriptionModel *)descriptionModel
{
    self = [super init];
    if (self)
    {
        _superView = superview;
        
        _descriptionCryptoView = [UIView new];
        _descriptionCryptoView.layer.cornerRadius = 10;
        _descriptionCryptoView.backgroundColor = UIColor.whiteColor;
        [self addSubview:_descriptionCryptoView];
        
        _iconCryptoImageView = [UIImageView new];
        _iconCryptoImageView.image = [UIImage imageNamed:descriptionModel.nameString];
        [_descriptionCryptoView addSubview:_iconCryptoImageView];
        
        _nameCryptoLabel = [UILabel new];
        _nameCryptoLabel.text = descriptionModel.nameString;
        [_descriptionCryptoView addSubview:_nameCryptoLabel];
        
        _descriptionCryptoTableView = [UITableView new];
        _descriptionCryptoTableView.dataSource = self;
        _descriptionCryptoTableView.delegate = self;
        _descriptionCryptoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _descriptionCryptoTableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        [self addSubview:_descriptionCryptoTableView];
        [_descriptionCryptoTableView registerClass:[SBTCryptocurrencyDescriptionTableViewCell class]
            forCellReuseIdentifier:SBTCryptocurrencyDescriptionCellIdentifier];
        
        _contentArray = [self modelToArray:descriptionModel];
        
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.3f];
        [SBTAnimationStateChange animationWithView:self isAppear:YES completion:nil];
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect bounds = self.superView.bounds;
    CGFloat height = CGRectGetHeight(bounds);
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.superView.window.mas_top);
        make.left.mas_equalTo(self.superView.window.mas_left);
        make.bottom.mas_equalTo(self.superView.window.mas_bottom);
        make.right.mas_equalTo(self.superView.window.mas_right);
    }];
    
    [_descriptionCryptoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset(height / 5);
        make.left.mas_equalTo(self.mas_left).with.offset(SBTOffset * 2);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset( - height / 5);
        make.right.mas_equalTo(self.mas_right).with.offset( - SBTOffset * 2);
    }];
    
    [_iconCryptoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_descriptionCryptoView.mas_top).with.offset(SBTOffset * 2);
        make.left.mas_equalTo(_descriptionCryptoView.mas_left).with.offset(SBTOffset * 2);
        make.width.mas_equalTo(SBTWidthImage);
        make.height.mas_equalTo(SBTHeightImage);
    }];
    
    [_nameCryptoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_iconCryptoImageView.mas_centerY);
        make.left.mas_equalTo(_iconCryptoImageView.mas_right).with.offset(SBTOffset * 2);
    }];
    
    [_descriptionCryptoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconCryptoImageView.mas_bottom).with.offset(SBTOffset * 2);
        make.left.mas_equalTo(_descriptionCryptoView.mas_left).with.offset(0);
        make.bottom.mas_equalTo(_descriptionCryptoView.mas_bottom).with.offset( - SBTOffset * 2);
        make.right.mas_equalTo(_descriptionCryptoView.mas_right).with.offset(0);
    }];
}


#pragma mark - Responder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touchInView = touches.anyObject;
    CGPoint pointInView = [touchInView locationInView:self];
    id testInstance = [self hitTest:pointInView withEvent:event];
    if ([testInstance isMemberOfClass:[SBTCryptocurrencyDescriptionView class]])
    {
        [SBTAnimationStateChange animationWithView:self isAppear:NO completion:^{
            [self removeFromSuperview];
        }];
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBTCryptocurrencyDescriptionTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.nameDescriptionLabel.text isEqualToString:SBTAffiliateURL])
    {
        UIApplication *application = [UIApplication sharedApplication];
        [application openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.%@/",cell.contentDescriptionLabel.text]]
            options:@{} completionHandler:nil];
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBTCryptocurrencyDescriptionTableViewCell *cell = [tableView
        dequeueReusableCellWithIdentifier:SBTCryptocurrencyDescriptionCellIdentifier forIndexPath:indexPath];
    [cell setupContentCellWithIndexRow:indexPath.row content:self.contentArray];
    return cell;
}

- (NSArray *)modelToArray:(DescriptionModel *)descriptionModel
{
    if (!descriptionModel)
    {
        return nil;
    }
    NSMutableArray *propertyArray = [NSMutableArray new];
    [propertyArray addObject:descriptionModel.symbolString];
    [propertyArray addObject:descriptionModel.startDateString];
    [propertyArray addObject:descriptionModel.idString];
    [propertyArray addObject:descriptionModel.algorithmString];
    [propertyArray addObject:descriptionModel.blockTimeString];
    [propertyArray addObject:descriptionModel.blockRewardString];
    [propertyArray addObject:descriptionModel.totalCoinSupplyString];
    [propertyArray addObject:descriptionModel.affiliateUrlString];
    [propertyArray addObject:descriptionModel.twitterString];
    return [propertyArray copy];
}


@end
