//
//  SBTCryptocurrencyDescriptionTableViewCell.h
//  SBTProject
//
//  Created by Sergey Altukhov on 16.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SBTCryptocurrencyDescriptionTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *nameDescriptionLabel;
@property (nonatomic, strong) UILabel *contentDescriptionLabel;

- (void)prepareForReuse;
- (void)contentCellWithIndexRow:(NSInteger)row content:(NSArray *)content;


@end
