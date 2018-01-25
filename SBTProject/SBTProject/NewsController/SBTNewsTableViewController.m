//
//  SBTNewsTableViewController.m
//  SBTProject
//
//  Created by Sergey Altukhov on 11.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTNewsTableViewController.h"
#import "SBTNewsTableViewCell.h"
#import "SBTNewsWebViewController.h"


static CGFloat const SBTOffsetToCenterTabBar = 9;
static NSString *const SBTNewsIdentifierCell = @"SBTNewsIdentifierCell";


@interface SBTNewsTableViewController ()


//@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSURLSession *session;


@end


@implementation SBTNewsTableViewController


- (instancetype)initWithSession:(NSURLSession *)session
{
    self = [super init];
    if (self)
    {
//        _context = context;
        _session = session;
        self.tabBarItem.image = [UIImage imageNamed:@"Icon"];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -SBTOffsetToCenterTabBar, 0);
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
//    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.title = @"News";
    [self.tableView registerClass:[SBTNewsTableViewCell class] forCellReuseIdentifier:SBTNewsIdentifierCell];
}


#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBTNewsWebViewController *webViewController = [SBTNewsWebViewController new];
    webViewController.urlNewsString = @"https://www.ccn.com/visa-ceo-we-wont-accept-bitcoin-directly/";
    [self.navigationController pushViewController:webViewController animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

//https://www.ccn.com/visa-ceo-we-wont-accept-bitcoin-directly/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBTNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SBTNewsIdentifierCell forIndexPath:indexPath];
    cell.publishedNewsLabel.text = @"2018-01-19 13:01:57";
    cell.titleNewsLabel.text = @"Visa CEO: We Won’t Accept Bitcoin Directly";
    cell.descriptionNewsLabel.text = @"The post Visa CEO: We Won’t Accept Bitcoin Directly appeared first on CCN Visa will not directly accept bitcoin, according to company CEO Alfred Kelly in a recent CNBC interview during the National Retail Federation trade show in New York City. “We at Visa wo…";
    cell.sourceNameNewsLabel.text = @"Crypto Coins News";
    cell.authorNewsLabel.text = @"Lester Coleman";
    return cell;
}


@end
