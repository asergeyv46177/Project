//
//  SBTDataPreparerViewController.m
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTDataPreparerViewController.h"
#import "SBTCoreDataService.h"
#import "SBTChangeRootViewControllerProtocol.h"
#import "SBTCoreDataFileFacade.h"
#import "SBTParsingJSONDescription.h"
#import "SBTDataDescriptionModel.h"

@interface SBTDataPreparerViewController ()


@property (nonatomic, strong) SBTCoreDataFileFacade *coreDataFileFacade;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end


@implementation SBTDataPreparerViewController

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (instancetype)initWithCoreDataFileFacade:(SBTCoreDataFileFacade *)coreDataFileFacade
{
    self = [super init];
    if (self)
    {
        _coreDataFileFacade = coreDataFileFacade;
    }
    return self;
}

- (void)addDataOk
{
    [self.activityIndicatorView stopAnimating];
    [self.delegate changeRootViewController:self];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.coreDataFileFacade prepareData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;

    CGRect bounds = self.view.bounds;
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(bounds), 25)];
    [self.button addTarget:self action:@selector(addDataOk) forControlEvents:UIControlEventTouchDown];
    self.button.backgroundColor = UIColor.redColor;
    [self.button setTitle:@"preparation complete" forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    [self.activityIndicatorView startAnimating];
}

@end
