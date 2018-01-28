//
//  SBTDataDescriptionModel.h
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SBTDataDescriptionModel : NSObject


@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *symbolString;
@property (nonatomic, copy) NSString *startDateString;
@property (nonatomic, copy) NSString *idString;
@property (nonatomic, copy) NSString *algorithmString;
@property (nonatomic, copy) NSString *blockRewardString;
@property (nonatomic, copy) NSString *blockTimeString;
@property (nonatomic, copy) NSString *affiliateUrlString;
@property (nonatomic, copy) NSString *twitterString;
@property (nonatomic, copy) NSString *totalCoinSupplyString;


@end
