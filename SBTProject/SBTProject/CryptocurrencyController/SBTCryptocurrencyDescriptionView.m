//
//  SBTCryptocurrencyDescriptionView.m
//  SBTProject
//
//  Created by Sergey Altukhov on 12.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTCryptocurrencyDescriptionView.h"
#import "SBTCryptocurrencyDescriptionTableViewCell.h"
#import <Masonry.h>


static CGFloat const SBTOffset = 30.0;
static NSInteger const SBTAffiliateURLIndexPath = 5;
static NSString *const SBTCryptocurrencyDescriptionCellIdentifier = @"SBTCryptocurrencyDescriptionCellIdentifier";


@interface SBTCryptocurrencyDescriptionView () <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) UIView *descriptionCryptoView;
@property (nonatomic, strong) UIImageView *iconCryptoImageView;
@property (nonatomic, strong) UILabel *nameCryptoLabel;
@property (nonatomic, strong) UITableView *descriptionCryptoTableView;
@property (nonatomic, copy) NSArray *labelArray;
@property (nonatomic, copy) NSArray *probArray;


@end


@implementation SBTCryptocurrencyDescriptionView


- (instancetype)initWithSuperview:(UIView *)superView nameCrypto:(NSString *)nameString
{
    self = [super init];
    if (self)
    {
        _probArray = @[@"STRAT", @"09/08/2016", @"24294", @"X13:", @"60 sec", @"stratisplatform.com",
            @"@stratisplatform", @"98691556.23"];
        _labelArray = @[@"Symbol:", @"Start date:", @"Id:", @"Algorithm:", @"Block time:", @"Affiliate url:",
            @"Twitter:", @"Total mined:"];
        
        _superView = superView;
        
        _descriptionCryptoView = [UIView new];
        _descriptionCryptoView.layer.cornerRadius = 10;
        _descriptionCryptoView.backgroundColor = UIColor.whiteColor;
        [self addSubview:_descriptionCryptoView];
        
        _iconCryptoImageView = [UIImageView new];
        _iconCryptoImageView.image = [UIImage imageNamed:nameString];
        [_descriptionCryptoView addSubview:_iconCryptoImageView];
        
        _nameCryptoLabel = [UILabel new];
        _nameCryptoLabel.text = nameString;
        [_descriptionCryptoView addSubview:_nameCryptoLabel];
        
        _descriptionCryptoTableView = [UITableView new];
        _descriptionCryptoTableView.dataSource = self;
        _descriptionCryptoTableView.delegate = self;
        _descriptionCryptoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _descriptionCryptoTableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        [self addSubview:_descriptionCryptoTableView];
        [_descriptionCryptoTableView registerClass:[SBTCryptocurrencyDescriptionTableViewCell class]
            forCellReuseIdentifier:SBTCryptocurrencyDescriptionCellIdentifier];
        
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.3f];
        [self viweWithAnimationAppear:YES];
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
        make.top.mas_equalTo(self.mas_top).with.offset(height/5);
        make.left.mas_equalTo(self.mas_left).with.offset(SBTOffset*2/3.f);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(-height/5);
        make.right.mas_equalTo(self.mas_right).with.offset(-SBTOffset*2/3.f);
    }];
    
    [_iconCryptoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_descriptionCryptoView.mas_top).with.offset(SBTOffset/2);
        make.left.mas_equalTo(_descriptionCryptoView.mas_left).with.offset(SBTOffset/2);
        make.width.mas_equalTo(SBTOffset*1.5f);
        make.height.mas_equalTo(SBTOffset*1.95f);
    }];
    
    [_nameCryptoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_iconCryptoImageView.mas_centerY);
        make.left.mas_equalTo(_iconCryptoImageView.mas_right).with.offset(SBTOffset/2);
    }];
    
    [_descriptionCryptoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconCryptoImageView.mas_bottom).with.offset(SBTOffset*2/3.f);
        make.left.mas_equalTo(_descriptionCryptoView.mas_left).with.offset(0);
        make.bottom.mas_equalTo(_descriptionCryptoView.mas_bottom).with.offset(-SBTOffset/3);
        make.right.mas_equalTo(_descriptionCryptoView.mas_right).with.offset(0);
    }];
}


#pragma mark - Animation view

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touchInView = [touches anyObject];
    CGPoint pointInView = [touchInView locationInView:self];
    id testInstance = [self hitTest:pointInView withEvent:event];
    if ([testInstance isMemberOfClass:[SBTCryptocurrencyDescriptionView class]])
    {
        [self viweWithAnimationAppear:NO];
    }
}

- (void)viweWithAnimationAppear:(BOOL)isViewAppear
{
    self.alpha = !isViewAppear;
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = isViewAppear;
                     } completion:^(BOOL finished) {
                         if (!isViewAppear)
                         {
                             [self removeFromSuperview];
                         }
                     }];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (SBTAffiliateURLIndexPath == indexPath.row)
    {
        UIApplication *application = [UIApplication sharedApplication];
        [application openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.%@/",@"stratisplatform.com"]]
                        options:@{} completionHandler:nil];
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.labelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBTCryptocurrencyDescriptionTableViewCell *descriptionCell = [tableView
        dequeueReusableCellWithIdentifier:SBTCryptocurrencyDescriptionCellIdentifier forIndexPath:indexPath];
    descriptionCell.nameDescriptionLabel.text = self.labelArray[indexPath.row];
    descriptionCell.contentDescriptionLabel.text = self.probArray[indexPath.row];
    if (SBTAffiliateURLIndexPath == indexPath.row)
    {
        descriptionCell.contentDescriptionLabel.textColor = UIColor.blueColor;
    }
    return descriptionCell;
}


@end
