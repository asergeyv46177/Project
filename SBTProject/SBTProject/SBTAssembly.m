//
//  SBTAssembly.m
//  SBTProject
//
//  Created by Sergey Altukhov on 22.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTAssembly.h"
#import "SBTCoreDataService.h"
#import "SBTNewsTableViewController.h"
#import "SBTCryptocurrencyTableViewController.h"
#import "SBTGraphTableViewController.h"


@interface SBTAssembly ()


@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) SBTCoreDataService *coreDataService;


@end


@implementation SBTAssembly


- (instancetype)initWithContext:(NSManagedObjectContext *) context
{
    self = [super init];
    if (self)
    {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        _coreDataService = [[SBTCoreDataService alloc] initWithContext:context session:_session];
    }
    return self;
}

- (UITabBarController *)createRootViewController
{
    SBTNewsTableViewController *newsTableViewController = [[SBTNewsTableViewController alloc] initWithSession:self.session];
    UINavigationController *newsNavigationController = [[UINavigationController alloc] initWithRootViewController:newsTableViewController];
    
    SBTCryptocurrencyTableViewController *cryptocurrencyTableViewController = [[SBTCryptocurrencyTableViewController alloc]
        initWithCoreDateService:self.coreDataService];
    UINavigationController *cryptocurrencyNavigationController = [[UINavigationController alloc]
        initWithRootViewController:cryptocurrencyTableViewController];
    
    SBTGraphTableViewController *graphTableViewController = [[SBTGraphTableViewController alloc]
        initWithCoreDateService:self.coreDataService];
    UINavigationController *graphNavigationController = [[UINavigationController alloc]
        initWithRootViewController:graphTableViewController];
    
    UITabBarController *tabBarController = [UITabBarController new];
    tabBarController.viewControllers = @[newsNavigationController, graphNavigationController, cryptocurrencyNavigationController];
    return tabBarController;
}


@end
