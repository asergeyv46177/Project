//
//  SBTDataGraphModel.h
//  SBTProject
//
//  Created by Сергей Алтухов on 10.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GraphModel;


/**
 Модель для работы с данными о графике
 */
@interface SBTDataGraphModel : NSObject

@property (nonatomic, copy) NSString *unitString;               /**< Единицы измерения по оси ординат */
@property (nonatomic, copy) NSString *descriptionString;        /**< Описание графика */
@property (nonatomic, copy) NSString *nameString;               /**< Название графика */
@property (nonatomic, copy) NSArray *valuesXYArray;             /**< Массив значений типа (X,Y) для построения графика  */
@property (nonatomic, copy) NSString *dateLastUpdateString;     /**< Дата последнего обновления данных */
@property (nonatomic, assign) NSInteger maxYInteger;            /**< Максимальное значение по оси ординат */

/**
 Инициализирует модель с данными
 @param graphModel - сущность, из которой берутся данные для заполнения модели
 @return экземпляр класса SBTDataGraphModel
 */
- (instancetype)initWithGraphModel:(GraphModel *)graphModel;

@end
