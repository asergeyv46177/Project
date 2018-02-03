//
//  SBTBuildGraphView.h
//  SBTProject
//
//  Created by Сергей Алтухов on 10.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBTDataGraphModel;


/**
 Вью, на которой непосредственно строится график
 */
@interface SBTBuildGraphView : UIView

/**
 Инициализирует вью с моделью и вью
 @param dataGraphModel - модель, из которой берутся данные для построения графика
 @param yAxisValuesView - вью, на которой располагаются лейблы с названием оси ординат, значениями оси и подробным
    значнеием при нажатии на график
 @return экземпляр класса SBTBuildGraphView
 */
- (instancetype)initWithDataGraphModel:(SBTDataGraphModel *)dataGraphModel withView:(UIView *)yAxisValuesView;

@end
