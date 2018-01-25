//
//  SBTNewsTableViewCell.h
//  SBTProject
//
//  Created by Sergey Altukhov on 17.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SBTNewsTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *publishedNewsLabel;
@property (nonatomic, strong) UILabel *titleNewsLabel;
@property (nonatomic, strong) UILabel *descriptionNewsLabel;
@property (nonatomic, strong) UILabel *sourceNameNewsLabel;
@property (nonatomic, strong) UILabel *authorNewsLabel;


@end
