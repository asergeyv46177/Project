//
//  SBTNewsTableViewController.m
//  SBTProject
//
//  Created by Sergey Altukhov on 11.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTNewsTableViewController.h"
#import "UIView+SBTView.h"
#import "SBTNewsTableViewCell.h"
#import "SBTDownloadDataService.h"
#import "SBTDataNewsModel.h"
#import <SafariServices/SafariServices.h>


static CGFloat const SBTOffsetToCenterTabBar = 9;
static NSString *const SBTNewsIdentifierCell = @"SBTNewsIdentifierCell";


@interface SBTNewsTableViewController ()

@property (nonatomic, strong) SBTDownloadDataService *downloadDataService;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, copy) NSArray *modelArray;

@end


@implementation SBTNewsTableViewController


#pragma mark - Lifecycle

- (instancetype)initWithDownloadDataService:(SBTDownloadDataService *)downloadDataService
{
    self = [super init];
    if (self)
    {
        _downloadDataService = downloadDataService;
        self.tabBarItem.image = [UIImage imageNamed:@"news"];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -SBTOffsetToCenterTabBar, 0);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareViews];
    [self.activityIndicatorView startAnimating];
    [self.downloadDataService downloadDataWithURLKeyString:@"40" downloadDataType:SBTDownloadDataTypeNews queue:nil
        completeHandler:^(id modelArray) {
            self.modelArray = modelArray;
            [self.tableView reloadData];
            [self.activityIndicatorView stopAnimating];
        }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView sbt_animationWithView:self.view isAppear:YES completion:nil];
}


#pragma mark - Prepare views

- (void)prepareViews
{
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"News";
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicatorView.color = UIColor.blackColor;
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.activityIndicatorView];
    
    [self.tableView registerClass:[SBTNewsTableViewCell class] forCellReuseIdentifier:SBTNewsIdentifierCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBTDataNewsModel *dataNewsModel = self.modelArray[indexPath.row];
    NSURL *url = [NSURL URLWithString:dataNewsModel.urlString];
    SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:url];
    [self.navigationController pushViewController:safariViewController animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBTNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SBTNewsIdentifierCell forIndexPath:indexPath];
    [cell setupContentCell:self.modelArray[indexPath.row]];
    return cell;
}

@end
