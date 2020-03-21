//
//  ViewController.m
//  temp
//
//  Created by xubinbin on 2020/3/4.
//  Copyright © 2020 ccsu_cat. All rights reserved.
//

#import "ViewController.h"
#import "ListViewController.h"
#import <Masonry.h>
#import <JSONModel.h>

#define padding 20
#define account @"account"
#define pwd @"pwd"
#define rePwd @"rePwd"
#define autoLogin @"autoLogin"

@interface ViewController ()

@property(nonatomic, strong) UILabel *accountLabel;
@property(nonatomic, strong) UILabel *pwdLabel;
@property(nonatomic, strong) UITextField *accountTextField;
@property(nonatomic, strong) UITextField *pwdTextField;
@property(nonatomic, strong) UILabel *reLabel;
@property(nonatomic, strong) UISwitch *reSwitch;
@property(nonatomic, strong) UILabel *autoLabel;
@property(nonatomic, strong) UISwitch *autoSwitch;
@property(nonatomic, strong) UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"welcome";
    self.view.backgroundColor = [UIColor whiteColor];

    [self loadSubView];
    [self setLayout];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.accountTextField];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:_pwdTextField];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.accountTextField.text = [defaults objectForKey:account];
    [self.reSwitch setOn:[defaults boolForKey:rePwd] animated:YES];
    
    if (self.reSwitch.isOn) {
        self.pwdTextField.text = [defaults objectForKey:pwd];
    }
    
    [self.autoSwitch setOn:[defaults boolForKey:autoLogin] animated:YES];
    if (self.autoSwitch.isOn) {
        [self loginClick];
    }
    [self textChange];
}
-(void)textChange
{
    self.loginButton.enabled = (self.accountTextField.text.length > 0 && self.pwdTextField.text.length > 0);
    if (self.loginButton.enabled) {
        [self.loginButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    } else {
        [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void)rePwdClick
{
    if (self.reSwitch.isOn == NO) {
        [self.autoSwitch setOn:NO animated:YES];
    }
}
-(void)autoLoginClick
{
    if (self.autoSwitch.isOn == YES) {
        [self.reSwitch setOn:YES animated:YES];
    }
}
-(void)loginClick
{
    NSLog(@"hello world");
    ListViewController *controller = [[ListViewController alloc] init];
    controller.title = [NSString stringWithFormat:@"尊敬的%@",self.accountTextField.text];
   // controller.title = @"";
    [self.navigationController pushViewController:controller animated:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.accountTextField.text forKey:account];
    [defaults setObject:self.pwdTextField.text forKey:pwd];
    [defaults setBool:self.reSwitch.isOn forKey:rePwd];
    [defaults setBool:self.autoSwitch.isOn forKey:autoLogin];
}

-(void) loadSubView
{
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.text = @"账号";
    accountLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:accountLabel];
    self.accountLabel = accountLabel;
    
    UILabel *pwdLabel = [[UILabel alloc] init];
    pwdLabel.text = @"密码";
    pwdLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:pwdLabel];
    self.pwdLabel = pwdLabel;
    
    UITextField *accountTextField = [[UITextField alloc] init];
    [accountTextField setBorderStyle: UITextBorderStyleRoundedRect];
    [self.view addSubview:accountTextField];
    self.accountTextField = accountTextField;
    
    UITextField *pwdTextField = [[UITextField alloc] init];
    [pwdTextField setBorderStyle: UITextBorderStyleRoundedRect];
    [self.view addSubview:pwdTextField];
    self.pwdTextField = pwdTextField;
    
    UILabel *reLabel = [[UILabel alloc] init];
    reLabel.text = @"记住密码";
    reLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: reLabel];
    self.reLabel = reLabel;
    
    UISwitch *reSwitch = [[UISwitch alloc] init];
    [self.view addSubview: reSwitch];
    [reSwitch addTarget:self action:@selector(rePwdClick) forControlEvents:UIControlEventTouchUpInside];
    self.reSwitch = reSwitch;

    UILabel *autoLabel = [[UILabel alloc] init];
    autoLabel.text = @"自动登录";
    autoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: autoLabel];
    self.autoLabel = autoLabel;
    
    UISwitch *autoSwitch = [[UISwitch alloc] init];
    [self.view addSubview: autoSwitch];
    [autoSwitch addTarget:self action:@selector(autoLoginClick) forControlEvents:UIControlEventTouchUpInside];
    self.autoSwitch = autoSwitch;
    
    UIButton *loginButton = [[UIButton alloc] init];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:loginButton];
    [loginButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton = loginButton;
}
-(void) setLayout
{
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).insets(UIEdgeInsetsMake(150, padding, 0, 0));
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(self.accountTextField.mas_width).multipliedBy(0.2);
    }];
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-padding);
        make.top.equalTo(self.accountLabel.mas_top);
        make.left.equalTo(self.accountLabel.mas_right).offset(padding);
        make.height.equalTo(self.accountLabel.mas_height);
    }];
    [self.pwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accountLabel.mas_left);
        make.right.equalTo(self.accountLabel.mas_right);
        make.top.equalTo(self.accountLabel.mas_bottom).offset(padding);
        make.height.equalTo(self.accountLabel.mas_height);
    }];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-padding);
        make.top.equalTo(self.pwdLabel.mas_top);
        make.left.equalTo(self.pwdLabel.mas_right).offset(padding);
        make.height.equalTo(self.pwdLabel.mas_height);
    }];
    [self.reLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(padding);
        make.top.equalTo(self.pwdLabel.mas_bottom).offset(padding);
        make.height.equalTo(self.pwdLabel.mas_height);
        make.width.equalTo(self.reSwitch.mas_width);
    }];
    [self.reSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reLabel.mas_right).offset(padding);
        make.top.equalTo(self.reLabel.mas_top);
        make.height.equalTo(self.reLabel.mas_height);
        make.width.equalTo(self.autoLabel.mas_width);
    }];
    [self.autoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reSwitch.mas_right).offset(padding);
        make.top.equalTo(self.reSwitch.mas_top);
        make.height.equalTo(self.reSwitch.mas_height);
        make.width.equalTo(self.autoSwitch.mas_width);
    }];
    [self.autoSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.autoLabel.mas_right).offset(padding);
        make.top.equalTo(self.autoLabel.mas_top);
        make.height.equalTo(self.autoLabel.mas_height);
        make.right.equalTo(self.view.mas_right).offset(-padding);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.autoSwitch.mas_bottom).offset(padding);
        make.height.equalTo(self.autoSwitch.mas_height);
        CGFloat width = self.view.frame.size.width;
        make.left.equalTo(self.view.mas_left).offset(0.45 * width);
        make.right.equalTo(self.view.mas_right).offset(-0.45 * width);
    }];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
