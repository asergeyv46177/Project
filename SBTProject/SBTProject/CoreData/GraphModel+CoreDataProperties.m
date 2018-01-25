//
//  GraphModel+CoreDataProperties.m
//  
//
//  Created by Sergey Altukhov on 23.01.2018.
//
//

#import "GraphModel+CoreDataProperties.h"


@implementation GraphModel (CoreDataProperties)


+ (NSFetchRequest<GraphModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GraphModel"];
}


@dynamic nameString;
@dynamic descriptionString;
@dynamic unitString;
@dynamic maxYInteger;
@dynamic dateLastUpdateString;
@dynamic valuesXYArray;


@end
