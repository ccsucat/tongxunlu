//
//  AddOptionController.m
//  temp
//
//  Created by xubinbin on 2020/3/5.
//  Copyright © 2020 ccsu_cat. All rights reserved.
//

#import "AddOptionController.h"
#import "Option.h"
#import <Masonry.h>

#define padding 10
@interface AddOptionController ()

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIButton *Btn;

@end

@implementation AddOptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubView];
    [self setLayout];
    [self textChange];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
}
-(void) addBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    Option *option = [[Option alloc] init];
    option.name = self.nameField.text;
    option.phoneNumber = self.phoneField.text;
    if ([self.delegate respondsToSelector:@selector(addViewController:optionData:)]) {
        [self.delegate addViewController:self optionData:option];
    }
}
-(void)textChange
{
    self.Btn.enabled = (self.nameField.text.length > 0 && self.phoneField.text.length > 0);
    if (self.Btn.enabled) {
        [self.Btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    } else {
        [self.Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
-(void) loadSubView
{
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"姓名";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"电话";
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:phoneLabel];
    self.phoneLabel = phoneLabel;
    
    UITextField *nameField = [[UITextField alloc] init];
    [nameField setBorderStyle: UITextBorderStyleRoundedRect];
    [self.view addSubview:nameField];
    self.nameField = nameField;
    
    UITextField *phoneField = [[UITextField alloc] init];
    [phoneField setBorderStyle: UITextBorderStyleRoundedRect];
    [self.view addSubview:phoneField];
    self.phoneField = phoneField;
    
    UIButton *Btn = [[UIButton alloc] init];
    [Btn setTitle:@"添加" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [Btn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn];
    self.Btn = Btn;
}
-(void) setLayout
{
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).insets(UIEdgeInsetsMake(150, padding, 0, 0));
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(self.nameField.mas_width).multipliedBy(0.2);
    }];
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-padding);
        make.top.equalTo(self.nameLabel.mas_top);
        make.left.equalTo(self.nameLabel.mas_right).offset(padding);
        make.height.equalTo(self.nameLabel.mas_height);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.right.equalTo(self.nameLabel.mas_right);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(padding);
        make.height.equalTo(self.nameLabel.mas_height);
    }];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-padding);
        make.top.equalTo(self.phoneLabel.mas_top);
        make.left.equalTo(self.phoneLabel.mas_right).offset(padding);
        make.height.equalTo(self.phoneLabel.mas_height);
    }];
    [self.Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneField.mas_bottom).offset(padding);
        make.height.equalTo(self.phoneField.mas_height);
        CGFloat width = self.view.frame.size.width;
        make.left.equalTo(self.view.mas_left).offset(width * 0.45);
        make.right.equalTo(self.view.mas_right).offset(-width * 0.45);
    }];
}
@end
