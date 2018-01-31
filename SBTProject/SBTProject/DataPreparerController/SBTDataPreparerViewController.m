//
//  SBTDataPreparerViewController.m
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTDataPreparerViewController.h"
#import "SBTChangeRootViewControllerProtocol.h"
#import "SBTCoreDataFileFacade.h"
#import "SBTAnimationWaiting.h"
#import "SBTDataPreparerTableViewCell.h"
#import "SBTAnimationStateChange.h"
#import <Masonry.h>


static CGFloat const SBTTopOffset = 40.0;
static CGFloat const SBTHeightButton = 49.0;

static NSString *const SBTPreparerCellIdentifier = @"SBTPreparerCellIdentifier";


@interface SBTDataPreparerViewController () <UITableViewDataSource>


@property (nonatomic, strong) SBTCoreDataFileFacade *coreDataFileFacade;
@property (nonatomic, strong) UIButton *okeyButton;
@property (nonatomic, strong) UILabel *mainLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *animationView;
@property (nonatomic, strong) UIView *coinsDropView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSArray *contentArray;
@property (nonatomic, copy) NSArray *nameArray;


@end


@implementation SBTDataPreparerViewController


#pragma mark - Lifecycle

- (instancetype)initWithCoreDataFileFacade:(SBTCoreDataFileFacade *)coreDataFileFacade
{
    self = [super init];
    if (self)
    {
        _coreDataFileFacade = coreDataFileFacade;
        _contentArray = @[@"Access to the latest information about the crypto currency. There is an opportunity to go to the source to read more.", @"All about bitcon, the ability to track parameters such as: market price, exchange trade volume, market capitalization and etc. The change history is 180 days, the data is updated every day.",@"Current price of crypto currency. Endpoints update every 5 minutes. Please limit requests to no more than 10 per minute."];
        _nameArray = @[@"newsBig",@"graphBig",@"dollarBitcoinBig"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self prepareViews];
    [self createConstraints];
    [self.animationView addSubview:[SBTAnimationWaiting animationOnView:self.view]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.coreDataFileFacade prepareData];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4
                                                  target:self
                                                selector:@selector(actionTimerRemoveAnimation)
                                                userInfo:nil
                                                 repeats:NO];
}


#pragma mark - Prepare views

- (void)prepareViews
{
    self.coinsDropView = [UIView new];
    self.coinsDropView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"crypto"]];
    [self.view addSubview:self.coinsDropView];
    
    self.mainLabel = [UILabel new];
    self.mainLabel.numberOfLines = 0;
    self.mainLabel.font = [UIFont systemFontOfSize:25];
    self.mainLabel.textAlignment = NSTextAlignmentCenter;
    self.mainLabel.text = @"Application description";
    [self.view addSubview:self.mainLabel];
    
    self.tableView = [UITableView new];
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    [self.tableView registerClass:[SBTDataPreparerTableViewCell class] forCellReuseIdentifier:SBTPreparerCellIdentifier];
    [self.view addSubview:self.tableView];
    
    self.okeyButton = [UIButton new];
    [self.okeyButton addTarget:self action:@selector(actionOkeyButton) forControlEvents:UIControlEventTouchDown];
    self.okeyButton.backgroundColor = [UIColor colorWithRed:0/255.f green:122/255.f blue:255/255.f alpha:1.0];
    [self.okeyButton setTitle:@"Okey!" forState:UIControlStateNormal];
    [self.view addSubview:self.okeyButton];
    
    self.animationView = [UIView new];
    self.animationView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.animationView];
}


#pragma mark - Action timer

- (void)actionTimerRemoveAnimation
{
    [SBTAnimationStateChange animationWithView:self.animationView isAppear:NO completion:^{
        [self.animationView removeFromSuperview];
    }];
}


#pragma mark - Action okey button

- (void)actionOkeyButton
{
    [self.delegate changeRootViewController:self];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBTDataPreparerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SBTPreparerCellIdentifier forIndexPath:indexPath];
    cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.nameArray[indexPath.row]]];
    cell.contentLabel.text = self.contentArray[indexPath.row];
    return cell;
}

- (void)createConstraints
{
    [self.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(SBTTopOffset);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mainLabel.mas_bottom).with.offset(SBTTopOffset / 4);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.okeyButton.mas_top);
    }];
    
    [self.coinsDropView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_centerY);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    [self.okeyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(SBTHeightButton);
    }];
}


@end
