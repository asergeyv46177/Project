//
//  SBTDataPriceModel.h
//  SBTProject
//
//  Created by Sergey Altukhov on 20.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SBTDataPriceModel : NSObject


@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *symbolString;
@property (nonatomic, assign) CGFloat priceUSDFloat;
@property (nonatomic, assign) CGFloat percentChange24hFloat;
@property (nonatomic, assign) CGFloat percentChange7dFloat;


@end
