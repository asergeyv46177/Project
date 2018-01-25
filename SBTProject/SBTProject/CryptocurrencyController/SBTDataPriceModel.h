//
//  SBTDataPriceModel.h
//  SBTProject
//
//  Created by Sergey Altukhov on 20.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SBTDataPriceModel : NSObject


@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *symbolString;
@property (nonatomic, copy) NSString *priceUSDString;
@property (nonatomic, copy) NSString *percentChange24hString;
@property (nonatomic, copy) NSString *percentChange7dString;

- (void)updateModel:(SBTDataPriceModel *)dataPriceModel;


@end
