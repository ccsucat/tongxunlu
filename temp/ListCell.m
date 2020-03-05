//
//  ListCell.m
//  temp
//
//  Created by xubinbin on 2020/3/5.
//  Copyright © 2020 ccsu_cat. All rights reserved.
//

#import "ListCell.h"
#import "Option.h"
#define padding 20
@interface ListCell()

@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *phoneLabel;

@end

@implementation ListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ListCell";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat width = self.contentView.frame.size.width;
        CGFloat height = self.contentView.frame.size.height;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.frame = CGRectMake(padding, padding, width, height * 0.4);
        [self.contentView addSubview: nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *phoneLabel = [[UILabel alloc] init];
        phoneLabel.frame = CGRectMake(padding, height * 0.4 + 3 * padding, width, height * 0.6 - 3 * padding);
        [self.contentView addSubview:phoneLabel];
        self.phoneLabel = phoneLabel;
    }
    return self;
}
-(void)setOption:(Option *)option
{
    _option = option;
    self.nameLabel.text = [NSString stringWithFormat:@"姓名: %@", option.name];
    self.phoneLabel.text = [NSString stringWithFormat:@"电话: %@", option.phoneNumber];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
