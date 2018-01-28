//
//  DescriptionModel+CoreDataProperties.m
//  
//
//  Created by Sergey Altukhov on 28.01.2018.
//
//

#import "DescriptionModel+CoreDataProperties.h"

@implementation DescriptionModel (CoreDataProperties)

+ (NSFetchRequest<DescriptionModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DescriptionModel"];
}

@dynamic nameString;
@dynamic symbolString;
@dynamic startDateString;
@dynamic idString;
@dynamic algorithmString;
@dynamic blockRewardString;
@dynamic blockTimeString;
@dynamic affiliateUrlString;
@dynamic twitterString;
@dynamic totalCoinSupplyString;

@end
