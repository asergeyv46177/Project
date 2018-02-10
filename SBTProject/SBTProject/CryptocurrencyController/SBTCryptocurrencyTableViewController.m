//
//  SBTCryptocurrencyTableViewController.m
//  SBTProject
//
//  Created by Sergey Altukhov on 11.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTCryptocurrencyTableViewController.h"
#import "UIView+SBTView.h"
#import "SBTCryptocurrencyTableViewCell.h"
#import "SBTCryptocurrencyDescriptionView.h"
#import "SBTCoreDataService.h"
#import "SBTDownloadDataService.h"
#import "SBTDataPriceModel.h"
#import "DescriptionModel+CoreDataProperties.h"
#import <Masonry.h>


static NSString *const SBTCryptoIdentifierCell = @"SBTCryptoIdentifierCell";
static CGFloat const SBTOffsetToCenterTabBar = 9;


@interface SBTCryptocurrencyTableViewController ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) SBTCoreDataService *coreDataService;
@property (nonatomic, strong) SBTDownloadDataService *downloadDataService;
@property (nonatomic, copy) NSArray <SBTDataPriceModel *> *modelArray;

@end


@implementation SBTCryptocurrencyTableViewController


#pragma mark - Lifecycle

- (instancetype)initWithCoreDateService:(SBTCoreDataService *)coreDataService
                    downloadDataService:(SBTDownloadDataService *)downloadDataService
{
    self = [super init];
    if (self)
    {
        _downloadDataService = downloadDataService;
        _coreDataService = coreDataService;
        self.tabBarItem.image = [UIImage imageNamed:@"dollarBitcoin"];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, - SBTOffsetToCenterTabBar, 0);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self downloadNewModels];
    [UIView sbt_animationWithView:self.view isAppear:YES completion:nil];
}


#pragma mark - Prepare views

- (void)prepareViews
{
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"Cryptocurrency price";
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicatorView.color = UIColor.blackColor;
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.activityIndicatorView];
    
    [self.tableView registerClass:[SBTCryptocurrencyTableViewCell class] forCellReuseIdentifier:SBTCryptoIdentifierCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.refreshControl = [UIRefreshControl new];
    self.refreshControl.tintColor = UIColor.blackColor;
    [self.refreshControl addTarget:self action:@selector(downloadNewModels) forControlEvents:UIControlEventValueChanged];
}

- (void)downloadNewModels
{
    [self beginDownload];
    NSArray *nameCryptoArray = @[@"Bitcoin", @"Ethereum", @"Litecoin", @"Ripple", @"Dash", @"IOTA", @"Monero", @"NEM",
        @"EOS", @"Stratis"];
    [self.downloadDataService downloadGroupWithURLKeyArray:nameCryptoArray downloadDataType:SBTDownloadDataTypePrice
        completeHandler:^(NSArray *modelArray) {
            self.modelArray = [self sortingArray:modelArray];
            [self.tableView reloadData];
            [self endDownload];
        }];
}

- (void)beginDownload
{
    if (!self.refreshControl.isRefreshing)
    {
        [self.activityIndicatorView startAnimating];
    }
}

- (void)endDownload
{
    if (self.activityIndicatorView.isAnimating)
    {
        [self.activityIndicatorView stopAnimating];
    }
    else
    {
        [self.refreshControl endRefreshing];
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray <DescriptionModel *> *descriptionModelArray = [self.coreDataService
        obtainModelArrayWithEntityName:[DescriptionModel class] predicateString:self.modelArray[indexPath.row].nameString];
    SBTCryptocurrencyDescriptionView *cryptocurrencyDescriptionView = [[SBTCryptocurrencyDescriptionView alloc]
        initWithSuperview:self.view descriptionModel:descriptionModelArray.firstObject];
    [self.tabBarController.view.window addSubview:cryptocurrencyDescriptionView];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBTCryptocurrencyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SBTCryptoIdentifierCell
        forIndexPath:indexPath];
    [cell setupContentCell:self.modelArray[indexPath.row]];
    return cell;
}


#pragma mark - Data source sorting

- (NSArray *)sortingArray:(NSArray *)oldArray
{
    NSArray *newArray = [oldArray sortedArrayUsingComparator: ^NSComparisonResult(SBTDataPriceModel *model1, SBTDataPriceModel *model2) {
        if (model1.priceUSDFloat < model2.priceUSDFloat)
        {
            return NSOrderedDescending;
        }
        else if (model1.priceUSDFloat > model2.priceUSDFloat)
        {
            return NSOrderedAscending;
        }
        else
        {
            return NSOrderedSame;
        }
    }];
    
    return newArray;
}

@end
