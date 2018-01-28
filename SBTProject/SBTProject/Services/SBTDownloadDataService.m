//
//  SBTDownloadDataService.m
//  SBTProject
//
//  Created by Sergey Altukhov on 20.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTDownloadDataService.h"
#import "SBTBuilderURLPrice.h"
#import "SBTBuilderURLGraphs.h"

#import "SBTParsingJSONGraphs.h"
#import "SBTParsingJSONPrice.h"


@interface SBTDownloadDataService ()


@property(nonatomic, strong) NSURLSession *session;


@end


@implementation SBTDownloadDataService


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        _session = session;
    }
    return self;
}

- (void)downloadDataWithURLKeyString:(NSString *)urlKey downloadDataType:(SBTDownloadDataType)dataType queue:(dispatch_queue_t)queue
            completeHandler:(void(^)(id))completeHandler
{
    dispatch_queue_t queue_t = dispatch_get_main_queue();
    if (queue)
    {
        queue_t = queue;
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[self buildURLByType:dataType urlKeyString:urlKey]];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (data)
            {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                id dataModel = [self parsingByType:dataType json:json];
                dispatch_async(queue_t, ^{
                    completeHandler(dataModel);
                });
            }
            else
            {
                dispatch_async(queue_t, ^{
                    completeHandler(nil);
                });
            }
        }];
    [dataTask resume];
}

- (void)downloadGroupWithURLKeyArray:(NSArray *)urlKeyArray downloadDataType:(SBTDownloadDataType)dataType
            completeHandler:(void(^)(NSArray *))completeHandler
{
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    __block NSMutableArray *modelArray = [NSMutableArray new];
    dispatch_async(queue, ^{
        dispatch_group_t dispatchGroup = dispatch_group_create();
        for (NSString *urlKey in urlKeyArray)
        {
            dispatch_group_enter(dispatchGroup);
            [self downloadDataWithURLKeyString:urlKey downloadDataType:dataType queue:queue
                completeHandler:^(id dataModel) {
                    if (dataModel)
                    {
                        [modelArray addObject:dataModel];
                    }
                    dispatch_group_leave(dispatchGroup);
                }];
        }
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            completeHandler([modelArray copy]);
        });
    });
}

- (NSURL *)buildURLByType:(SBTDownloadDataType) dataType urlKeyString:(NSString *)urlKey
{
    NSURL *url;
    switch (dataType)
    {
        case SBTDownloadDataTypeGraph:
        {
            url = [SBTBuilderURLGraphs urlWithNameGraph:urlKey];
            break;
        }
        case SBTDownloadDataTypePrice:
        {
            url = [SBTBuilderURLPrice urlWithNameCryptoString:urlKey];
            break;
        }
        case SBTDownloadDataTypeNews:
        {
//            dataModel = [SBTBuilderURLNews url];
            break;
        }
    }
    return url;
}

- (id)parsingByType:(SBTDownloadDataType)dataType json:(NSDictionary *)json
{
    id dataModel;
    switch (dataType)
    {
        case SBTDownloadDataTypeGraph:
        {
            dataModel = [SBTParsingJSONGraphs jsonToModel:json];
            break;
        }
        case SBTDownloadDataTypePrice:
        {
            dataModel = [SBTParsingJSONPrice jsonToModel:json];
            break;
        }
        case SBTDownloadDataTypeNews:
        {
//            dataModel = [SBTParsingJSONNews jsonToModel:json];
            break;
        }
    }
    return dataModel;
}


@end
