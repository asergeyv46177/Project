//
//  SBTCryptocurrencyDescriptionView.h
//  SBTProject
//
//  Created by Sergey Altukhov on 12.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DescriptionModel;

@interface SBTCryptocurrencyDescriptionView : UIView


- (instancetype)initWithSuperview:(UIView *)superview descriptionModel:(DescriptionModel *)descriptionModel;


@end
