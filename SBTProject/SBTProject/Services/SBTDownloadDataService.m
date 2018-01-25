//
//  SBTDownloadDataService.m
//  SBTProject
//
//  Created by Sergey Altukhov on 20.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTDownloadDataService.h"
//#import "SBTDataGraphModel.h"
#import "SBTParsingJSONPrice.h"
#import "SBTBuilderURLPrice.h"

#import "SBTParsingJSONGraphs.h"
#import "SBTBuilderURLGraphs.h"


@implementation SBTDownloadDataService


+ (void)downloadDataWithURLSession:(NSURLSession *)session urlKeyString:(NSString *)urlKey
            dataType:(SBTDownloadDataType)dataType completeHandler:(void(^)(id))completeHandler
{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[SBTDownloadDataService buildURLByType:dataType urlKeyString:urlKey]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data,
                                        NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (!error)
        {
            id dataModel = [SBTDownloadDataService parsingByType:dataType json:json];
            dispatch_async(dispatch_get_main_queue(), ^{
                completeHandler(dataModel);
            });
        }
        else
        {
            NSLog(@"Error");
        }
        
    }];
    [dataTask resume];
}

+ (NSURL *)buildURLByType:(SBTDownloadDataType) dataType urlKeyString:(NSString *)urlKey
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

+ (id)parsingByType:(SBTDownloadDataType)dataType json:(NSDictionary *)json
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
