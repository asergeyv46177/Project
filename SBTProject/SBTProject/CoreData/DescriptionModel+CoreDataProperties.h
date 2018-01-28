//
//  DescriptionModel+CoreDataProperties.h
//  
//
//  Created by Sergey Altukhov on 28.01.2018.
//
//

#import "DescriptionModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DescriptionModel (CoreDataProperties)

+ (NSFetchRequest<DescriptionModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *nameString;
@property (nullable, nonatomic, copy) NSString *symbolString;
@property (nullable, nonatomic, copy) NSString *startDateString;
@property (nullable, nonatomic, copy) NSString *idString;
@property (nullable, nonatomic, copy) NSString *algorithmString;
@property (nullable, nonatomic, copy) NSString *blockRewardString;
@property (nullable, nonatomic, copy) NSString *blockTimeString;
@property (nullable, nonatomic, copy) NSString *affiliateUrlString;
@property (nullable, nonatomic, copy) NSString *twitterString;
@property (nullable, nonatomic, copy) NSString *totalCoinSupplyString;

@end

NS_ASSUME_NONNULL_END
