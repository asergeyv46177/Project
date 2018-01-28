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
#import "SBTCoreDataDownloadFacade.h"
#import "SBTAnimationStateChange.h"


static NSString *const SBTIdentifierCell = @"SBTIdentifierCell";
static CGFloat const SBTOffsetToCenterTabBar = 9;


@interface SBTGraphTableViewController ()


@property (nonatomic, copy) NSArray *nameGraphArray;
@property (nonatomic, strong) SBTCoreDataDownloadFacade *coreDataDownloadFacade;


@end


@implementation SBTGraphTableViewController


- (instancetype)initWithCoreDataDowloadFacade:(SBTCoreDataDownloadFacade *)coreDataDownloadFacade
{
    self = [super init];
    if (self)
    {
        _coreDataDownloadFacade = coreDataDownloadFacade;
        self.tabBarItem.image = [UIImage imageNamed:@"graphs"];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -SBTOffsetToCenterTabBar, 0);
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
    [SBTAnimationStateChange animationWithView:self.view isAppear:YES completion:nil];
}


#pragma mark - Prepare views

- (void)prepareViews
{
    self.navigationItem.title = @"Bitcoin graphics";
    
    self.nameGraphArray = @[@"Market Price (USD)", @"USD Exchange Trade Volume", @"Market Capitalization",
        @"Miners Revenue", @"Total Transaction Fees"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SBTGraphTableViewCell class] forCellReuseIdentifier:SBTIdentifierCell];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBTGraphViewController *graphViewController = [[SBTGraphViewController alloc]
        initWithCoreDateService:self.coreDataDownloadFacade nameGraph:self.nameGraphArray[indexPath.row]];
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
