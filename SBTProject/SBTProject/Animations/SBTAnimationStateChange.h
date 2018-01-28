//
//  SBTAnimationStateChange.h
//  SBTProject
//
//  Created by Sergey Altukhov on 28.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SBTAnimationStateChange : UIView


+ (void)animationWithView:(UIView *)view isAppear:(BOOL)isAppear completion:(void(^)(void))completion;


@end
