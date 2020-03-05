//
//  ListCell.h
//  temp
//
//  Created by xubinbin on 2020/3/5.
//  Copyright © 2020 ccsu_cat. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Option;

@interface ListCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) Option *option;

@end


