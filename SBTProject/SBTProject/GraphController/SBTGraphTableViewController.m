//
//  SBTGraphTableViewController.m
//  SBTProject
//
//  Created by Сергей Алтухов on 09.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTGraphTableViewController.h"
#import "SBTGraphTableViewCell.h"
#import "SBTGraphViewController.h"
#import "SBTCoreDataService.h"


static NSString *const SBTIdentifierCell = @"SBTIdentifierCell";
static CGFloat const SBTOffsetToCenterTabBar = 9;


@interface SBTGraphTableViewController ()


@property (nonatomic, copy) NSArray <NSString *> *nameGraphArray;
@property (nonatomic, strong) SBTCoreDataService *coreDataService;


@end


@implementation SBTGraphTableViewController


- (instancetype)initWithCoreDateService:(SBTCoreDataService *)coreDataService
{
    self = [super init];
    if (self)
    {
        _coreDataService = coreDataService;
        self.tabBarItem.image = [UIImage imageNamed:@"graphs"];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -SBTOffsetToCenterTabBar, 0);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Bitcoin graphics";
    [self prepareViews];
}


#pragma mark - Prepare views

- (void)prepareViews
{
    self.nameGraphArray = @[@"Market Price (USD)", @"USD Exchange Trade Volume", @"Market Capitalization",
        @"Miners Revenue", @"Total Transaction Fees"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SBTGraphTableViewCell class] forCellReuseIdentifier:SBTIdentifierCell];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBTGraphViewController *graphViewController = [[SBTGraphViewController alloc]
        initWithCoreDateService:self.coreDataService nameGraph:self.nameGraphArray[indexPath.row]];
    [self.navigationController pushViewController:graphViewController animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nameGraphArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBTGraphTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SBTIdentifierCell forIndexPath:indexPath];
    [cell prepareForReuse];
    cell.nameGraphLabel.text = self.nameGraphArray[indexPath.row];
    cell.viewGraphImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.nameGraphArray[indexPath.row]]];
    return cell;
}

@end
