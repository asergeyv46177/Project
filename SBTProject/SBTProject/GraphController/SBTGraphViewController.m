//
//  SBTGraphViewController.m
//  SBTProject
//
//  Created by Сергей Алтухов on 10.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTGraphViewController.h"
#import "SBTBuildGraphView.h"
#import "SBTCoreDataDownloadFacade.h"
#import "SBTDataGraphModel.h"
#import <Masonry.h>


static CGFloat const SBTWidthGraphView = 920.0;
static CGFloat const SBTOffset = 15.0;


@interface SBTGraphViewController ()

@property (nonatomic, copy) NSString *nameGraphString;
@property (nonatomic, strong) SBTCoreDataDownloadFacade *coreDataDownloadFacade;
@property (nonatomic, strong) SBTDataGraphModel *dataGraphModel;
@property (nonatomic, strong) SBTBuildGraphView *buildGraphView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *yAxisValuesView;
@property (nonatomic, strong) UILabel *nameGraphLabel;
@property (nonatomic, strong) UILabel *descriptionGraphLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end


@implementation SBTGraphViewController


#pragma mark - Lifecycle

- (instancetype)initWithCoreDateService:(SBTCoreDataDownloadFacade *)coreDataDownloadFacade nameGraph:(NSString *)nameGraphString;
{
    self = [super init];
    if (self)
    {
        _coreDataDownloadFacade = coreDataDownloadFacade;
        _nameGraphString = [nameGraphString copy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareViews];
    [self downloadDataForGraph];
}


#pragma mark - Prepare views

- (void)prepareViews
{
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"Detailed graphic";
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(actionBackBarButton)];
    self.navigationItem.leftBarButtonItem = backBarButton;
    self.activityIndicatorView = [[UIActivityIndicatorView alloc]
        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicatorView.color = UIColor.blackColor;
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.activityIndicatorView];
}

- (void)downloadDataForGraph
{
    [self.activityIndicatorView startAnimating];
    [self.coreDataDownloadFacade obtainModelGraphWithPredicateString:self.nameGraphString
        completeHandler:^(SBTDataGraphModel *dataModel) {
            self.dataGraphModel = dataModel;
            [self createViews];
            [self setConstraints];
            [self.activityIndicatorView stopAnimating];
        }];
}


#pragma mark - Action button

- (void)actionBackBarButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Create views

- (void)createViews
{
    self.nameGraphLabel = [UILabel new];
    self.nameGraphLabel.textAlignment = NSTextAlignmentCenter;
    self.nameGraphLabel.font = [UIFont systemFontOfSize:20];
    self.nameGraphLabel.text = self.dataGraphModel.nameString;
    [self.view addSubview:self.nameGraphLabel];
    
    self.descriptionGraphLabel =  [UILabel new];
    self.descriptionGraphLabel.textAlignment = NSTextAlignmentCenter;
    self.descriptionGraphLabel.font = [UIFont systemFontOfSize:15];
    self.descriptionGraphLabel.numberOfLines = 0;
    self.descriptionGraphLabel.text = self.dataGraphModel.descriptionString;
    [self.view addSubview:self.descriptionGraphLabel];
    
    self.yAxisValuesView = [UIView new];
    [self.view addSubview:self.yAxisValuesView];
    
    CGRect frame = self.buildGraphView.frame;
    CGFloat height = CGRectGetHeight(frame);
    self.scrollView = [UIScrollView new];
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.scrollView.contentSize = CGSizeMake(SBTWidthGraphView, height);
    [self.view addSubview:self.scrollView];
    
    self.buildGraphView = [[SBTBuildGraphView alloc] initWithDataGraphModel:self.dataGraphModel
        withView:self.yAxisValuesView];
    [self.scrollView addSubview:self.buildGraphView];
}

- (void)setConstraints
{
    CGRect tabBarFrame = self.tabBarController.tabBar.frame;
    CGFloat tabBarHeight = CGRectGetHeight(tabBarFrame);
    CGRect navigationBarFrame = self.navigationController.navigationBar.frame;
    CGFloat navigationBarHeight = CGRectGetMaxY(navigationBarFrame);
    
    [self.nameGraphLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(navigationBarHeight + SBTOffset);
        make.height.mas_equalTo(self.nameGraphLabel.font.pointSize);
    }];
    
    [self.descriptionGraphLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.nameGraphLabel.mas_bottom).with.offset(SBTOffset);
        make.left.mas_equalTo(self.view.mas_left).with.offset(SBTOffset * 2);
        make.right.mas_equalTo(self.view.mas_right).with.offset( - SBTOffset * 2);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descriptionGraphLabel.mas_bottom).with.offset(SBTOffset);
        make.left.mas_equalTo(self.view.mas_left).with.offset(SBTOffset * 2);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset( - tabBarHeight);
        make.right.mas_equalTo(self.view.mas_right).with.offset( - SBTOffset);
    }];
    
    [self.buildGraphView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_top);
        make.left.mas_equalTo(self.scrollView.mas_left);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset( - tabBarHeight);
        make.width.mas_equalTo(SBTWidthGraphView);
    }];
    
    [self.yAxisValuesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_top);
        make.left.mas_equalTo(self.view.mas_left).with.offset(SBTOffset / 2);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset( - tabBarHeight);
        make.right.mas_equalTo(self.view.mas_right).with.offset( - SBTOffset / 2);
    }];
}

@end
