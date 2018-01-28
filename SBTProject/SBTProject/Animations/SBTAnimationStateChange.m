//
//  SBTAnimationStateChange.m
//  SBTProject
//
//  Created by Sergey Altukhov on 28.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTAnimationStateChange.h"


@implementation SBTAnimationStateChange


+ (void)animationWithView:(UIView *)view isAppear:(BOOL)isAppear completion:(void(^)(void))completion
{
    view.alpha = !isAppear;
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         view.alpha = isAppear;
                     } completion:^(BOOL finished) {
                         if (completion)
                         {
                             completion();
                         }
                     }];
}


@end
