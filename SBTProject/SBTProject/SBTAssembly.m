//
//  SBTAssembly.m
//  SBTProject
//
//  Created by Sergey Altukhov on 22.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTAssembly.h"
#import "SBTAnimationStateChange.h"

#import "SBTCoreDataService.h"
#import "SBTDownloadDataService.h"
#import "SBTCoreDataDownloadFacade.h"
#import "SBTCoreDataFileFacade.h"

#import "SBTNewsTableViewController.h"
#import "SBTCryptocurrencyTableViewController.h"
#import "SBTGraphTableViewController.h"
#import "SBTDataPreparerViewController.h"


@interface SBTAssembly ()


@property (nonatomic, strong) SBTDownloadDataService *downloadDataService;
@property (nonatomic, strong) SBTCoreDataService *coreDataService;
@property (nonatomic, strong) SBTCoreDataDownloadFacade *coreDataDowloadFacade;
@property (nonatomic, strong) SBTCoreDataFileFacade *coreDataFileFacade;


@end


@implementation SBTAssembly


- (instancetype)initWithContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self)
    {
        _downloadDataService = [SBTDownloadDataService new];
        _coreDataService = [[SBTCoreDataService alloc] initWithContext:context];
        _coreDataDowloadFacade = [[SBTCoreDataDownloadFacade alloc] initWithCoreDataService:_coreDataService
            dowloadDataService:_downloadDataService];
        _coreDataFileFacade = [[SBTCoreDataFileFacade alloc] initWithCoreDataService:_coreDataService];
    }
    return self;
}

- (UIViewController *)createRootViewController
{
    UIViewController *rootViewController;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isFirstTime = ![userDefaults boolForKey:@"isFirstTime"];
    if (isFirstTime)
    {
        [userDefaults setBool:YES forKey:@"isFirstTime"];
        SBTDataPreparerViewController *dataPreparerViewController = [[SBTDataPreparerViewController alloc]
            initWithCoreDataFileFacade:self.coreDataFileFacade];
        dataPreparerViewController.delegate = self;
        rootViewController = dataPreparerViewController;
    }
    else
    {
        rootViewController = [self createTabBarController];
    }
    return rootViewController;
}

- (UITabBarController *)createTabBarController
{
    SBTNewsTableViewController *newsTableViewController = [[SBTNewsTableViewController alloc]
        initWithDownloadDataService:self.downloadDataService];
    UINavigationController *newsNavigationController = [[UINavigationController alloc]
        initWithRootViewController:newsTableViewController];
    
    SBTCryptocurrencyTableViewController *cryptocurrencyTableViewController = [[SBTCryptocurrencyTableViewController alloc]
        initWithCoreDateService:self.coreDataService downloadDataService:self.downloadDataService];
    UINavigationController *cryptocurrencyNavigationController = [[UINavigationController alloc]
        initWithRootViewController:cryptocurrencyTableViewController];
    
    SBTGraphTableViewController *graphTableViewController = [[SBTGraphTableViewController alloc]
        initWithCoreDataDowloadFacade:self.coreDataDowloadFacade];
    UINavigationController *graphNavigationController = [[UINavigationController alloc]
        initWithRootViewController:graphTableViewController];
    
    UITabBarController *tabBarController = [UITabBarController new];
    tabBarController.viewControllers = @[newsNavigationController, graphNavigationController, cryptocurrencyNavigationController];
    return tabBarController;
}


#pragma mark - Protocol ChangeRootViewController

- (void)changeRootViewController:(UIViewController *)oldViewController
{
    UIViewController *rootViewController = [self createTabBarController];
    UIApplication *application = [UIApplication sharedApplication];
    UIWindow *window = application.windows.firstObject;
    window.rootViewController = rootViewController;
}


@end
