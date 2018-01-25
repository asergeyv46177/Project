//
//  SBTCryptocurrencyTableViewController.m
//  SBTProject
//
//  Created by Sergey Altukhov on 11.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTCryptocurrencyTableViewController.h"
#import "SBTCryptocurrencyTableViewCell.h"
#import "SBTCryptocurrencyDescriptionView.h"
#import "SBTCoreDataService.h"
#import <Masonry.h>


static NSString *const SBTCryptoIdentifierCell = @"SBTCryptoIdentifierCell";
static CGFloat const SBTOffsetToCenterTabBar = 9;


@interface SBTCryptocurrencyTableViewController ()


@property (nonatomic, strong) SBTCoreDataService *coreDataService;
@property (nonatomic, copy) NSArray *nameCryptoArray;


@end


@implementation SBTCryptocurrencyTableViewController


- (instancetype)initWithCoreDateService:(SBTCoreDataService *)coreDataService
{
    self = [super init];
    if (self)
    {
        _coreDataService = coreDataService;
        self.tabBarItem.image = [UIImage imageNamed:@"ethereumBitcoin"];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -SBTOffsetToCenterTabBar, 0);
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"Cryptocurrency price";
    
    self.nameCryptoArray = @[@"Bitcoin", @"Ethereum", @"Litecoin", @"Ripple", @"Dash", @"IOTA", @"Monero", @"NEM",
        @"EOS", @"Stratis"];
//    NSMutableArray *nameGraphsDictionary = [NSMutableArray new];
//    for (NSString *nameGraph in nameCryptoArray)
//    {
//        SBTDataPriceModel *dataPriceModel = [SBTDataPriceModel new];
//        dataPriceModel.nameString = nameGraph;
//        [nameGraphsDictionary addObject:dataPriceModel];
//    }
//    self.dataPriceModelArray = [nameGraphsDictionary copy];
//
//    if (!self.dataPriceModelArray[0].symbolString)
//    {
//        for (SBTDataPriceModel *dataPriceModel in self.dataPriceModelArray)
//        {
//            NSString *nameCrypto = dataPriceModel.nameString;
//            NSURL *url = [SBTBuilderURLPrice urlWithNameCryptoString:nameCrypto];
//            [SBTDownloadDataService downloadDataWithURLSession:self.session url:url dataType:SBTDownloadDataTypePrice
//                completeHandler:^(id dataModel) {
//                    [dataPriceModel updateModel:dataModel];
//                    self.dataPriceModelArray = [self sortingArray:self.dataPriceModelArray];
//                    [self.tableView reloadData];
//            }];
//        }
//    }
    [self.tableView registerClass:[SBTCryptocurrencyTableViewCell class] forCellReuseIdentifier:SBTCryptoIdentifierCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SBTCryptocurrencyDescriptionView *cryptocurrencyDescriptionView = [[SBTCryptocurrencyDescriptionView alloc]
//        initWithSuperview:self.view nameCrypto:self.dataPriceModelArray[indexPath.row].nameString];
//    [self.tabBarController.view.window addSubview:cryptocurrencyDescriptionView];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nameCryptoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SBTCryptocurrencyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SBTCryptoIdentifierCell
        forIndexPath:indexPath];
    [cell prepareForReuse];
    
//        cell.percent24hLabel.text = self.dataPriceModelArray[indexPath.row].percentChange24hString;
//        cell.percent7dLabel.text = self.dataPriceModelArray[indexPath.row].percentChange7dString;
    
//    NSMutableAttributedString *attributedString  = [[NSMutableAttributedString alloc] initWithString:@"1231123123123"];
//    [attributedString addAttribute:NSForegroundColorAttributeName
//                  value: UIColor.redColor
//                  range:NSMakeRange(1, 5)];

    
//        cell.symbolCryptoLabel.text = self.dataPriceModelArray[indexPath.row].symbolString;
        cell.nameCryptoLabel.text = self.nameCryptoArray[indexPath.row];
//        cell.priceCryptoLabel.text = self.dataPriceModelArray[indexPath.row].priceUSDString;
//        cell.iconCryptoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.dataPriceModelArray[indexPath.row].nameString]];
    return cell;
}


#pragma mark - Data source sorting

//- (NSArray *)sortingArray:(NSArray *)oldArray
//{
//    NSArray *newArray = [oldArray sortedArrayUsingComparator: ^NSComparisonResult(SBTDataPriceModel *obj1, SBTDataPriceModel *obj2) {
//        if (obj1.priceUSDString.floatValue < obj2.priceUSDString.floatValue)
//        {
//            return NSOrderedDescending;
//        }
//        else if (obj1.priceUSDString.floatValue > obj2.priceUSDString.floatValue)
//        {
//            return NSOrderedAscending;
//        }
//        else
//        {
//            return NSOrderedSame;
//        }
//    }];
//    return newArray;
//}


@end
