//
//  GraphModel+CoreDataProperties.h
//  
//
//  Created by Sergey Altukhov on 23.01.2018.
//
//

#import "GraphModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN


@interface GraphModel (CoreDataProperties)


+ (NSFetchRequest<GraphModel *> *)fetchRequest;


@property (nullable, nonatomic, copy) NSString *nameString;
@property (nullable, nonatomic, copy) NSString *descriptionString;
@property (nullable, nonatomic, copy) NSString *unitString;
@property (nonatomic) int64_t maxYInteger;
@property (nullable, nonatomic, copy) NSString *dateLastUpdateString;
@property (nullable, nonatomic, retain) NSObject *valuesXYArray;


@end


NS_ASSUME_NONNULL_END
