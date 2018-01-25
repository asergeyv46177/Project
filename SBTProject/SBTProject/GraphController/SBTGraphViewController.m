//
//  SBTGraphViewController.m
//  SBTProject
//
//  Created by Сергей Алтухов on 10.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTGraphViewController.h"
#import "SBTBuildGraphView.h"
//#import "SBTDataGraphModel.h"
//#import "SBTDownloadDataService.h"
//#import "SBTBuilderURLGraphs.h"
#import "GraphModel+CoreDataProperties.h"
#import "SBTCoreDataService.h"
#import <Masonry.h>


static CGFloat const SBTWidthYAxisValuesView = 100.0;
static CGFloat const SBTHeightGraphView = 300.0;
static CGFloat const SBTWidthGraphView = 920.0;
static CGFloat const SBTOffset = 15.0;


@interface SBTGraphViewController ()


@property (nonatomic, copy) NSString *nameGraphString;
@property (nonatomic, strong) SBTCoreDataService *coreDataService;
@property (nonatomic, strong) NSManagedObjectID *objectID;
@property (nonatomic, strong) SBTBuildGraphView *buildGraphView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *yAxisValuesView;
@property (nonatomic, strong) UILabel *nameGraphLabel;
@property (nonatomic, strong) UILabel *descriptionGraphLabel;


@end


@implementation SBTGraphViewController



- (instancetype)initWithCoreDateService:(SBTCoreDataService *)coreDataService nameGraph:(NSString *)nameGraphString
{
    self = [super init];
    if (self)
    {
        _coreDataService = coreDataService;
        _nameGraphString = nameGraphString;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.coreDataService modelGraphWithEntityName:[GraphModel class] predicateString:self.nameGraphString
        coreDataType:SBTCoreDataTypeGraph completeHandler:^(NSManagedObjectID *objectID) {
            self.objectID = objectID;
            [self createViews];
            [self setConstraints];
            NSArray <GraphModel *> *arr = [self.coreDataService.context executeFetchRequest:[GraphModel fetchRequest] error:nil];
            for (GraphModel *gM in arr)
            {
                NSLog(@"GraphModel nameString: %@",gM.nameString);
            }
            
        }];
    self.navigationItem.title = @"Detailed graphic";
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(actionBackBarButton)];
    self.navigationItem.leftBarButtonItem = backBarButton;
}


#pragma mark - Action button

- (void)actionBackBarButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Prepare views

- (void)createViews
{
    GraphModel *graphModel = [self.coreDataService.context objectWithID:self.objectID];
    
    self.nameGraphLabel = [UILabel new];
    self.nameGraphLabel.textAlignment = NSTextAlignmentCenter;
    self.nameGraphLabel.font = [UIFont systemFontOfSize:20];
    self.nameGraphLabel.text = graphModel.nameString;
    [self.view addSubview:self.nameGraphLabel];
    
    self.descriptionGraphLabel =  [UILabel new];
    self.descriptionGraphLabel.textAlignment = NSTextAlignmentCenter;
    self.descriptionGraphLabel.font = [UIFont systemFontOfSize:15];
    self.descriptionGraphLabel.numberOfLines = 0;
    self.descriptionGraphLabel.text = graphModel.descriptionString;
    [self.view addSubview:self.descriptionGraphLabel];
    
    self.yAxisValuesView = [UIView new];
    [self.view addSubview:self.yAxisValuesView];
    
    CGRect frame = self.buildGraphView.frame;
    CGFloat height = CGRectGetHeight(frame);
    self.scrollView = [UIScrollView new];
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.scrollView.contentSize = CGSizeMake(SBTWidthGraphView, height);
    [self.view addSubview:self.scrollView];
    
    self.buildGraphView = [[SBTBuildGraphView alloc] initWithCoreDateService:self.coreDataService
        objectID:self.objectID withView:self.yAxisValuesView];
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
        make.bottom.mas_greaterThanOrEqualTo(self.view.mas_bottom).with.offset( - tabBarHeight);
        make.right.mas_equalTo(self.view.mas_right).with.offset( - SBTOffset);
        make.height.mas_greaterThanOrEqualTo(SBTHeightGraphView);
    }];
    
    [self.buildGraphView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_top);
        make.left.mas_equalTo(self.scrollView.mas_left);
        make.bottom.mas_greaterThanOrEqualTo(self.view.mas_bottom).with.offset( - tabBarHeight);
        make.height.mas_greaterThanOrEqualTo(SBTHeightGraphView);
        make.width.mas_equalTo(SBTWidthGraphView);
    }];
    
    [self.yAxisValuesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_top);
        make.left.mas_equalTo(self.view.mas_left).with.offset(SBTOffset / 2);
        make.bottom.mas_greaterThanOrEqualTo(self.view.mas_bottom).with.offset( - tabBarHeight);
        make.height.mas_greaterThanOrEqualTo(SBTHeightGraphView);
        make.width.mas_equalTo(SBTWidthYAxisValuesView);
    }];
}


@end
