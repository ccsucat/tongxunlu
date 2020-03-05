//
//  ListViewController.m
//  temp
//
//  Created by xubinbin on 2020/3/5.
//  Copyright © 2020 ccsu_cat. All rights reserved.
//

#import "ListViewController.h"
#import "Option.h"
#import "AddOptionController.h"
#import <Masonry.h>
#import "ListCell.h"
#import "EditViewController.h"
#import "myScrollViewController.h"
#import "myCollectionViewController.h"


#define OptionPath [NSHomeDirectory()stringByAppendingPathComponent:@"Option.archiver"]
#define Path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Option.arc"]

@interface ListViewController ()<UITableViewDataSource, AddOptionControllerDelegate, UITableViewDelegate, EditViewControllerDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *options;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.frame;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"退出登录" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    self.navigationItem.leftBarButtonItem = leftButton;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"新建联系人" style:UIBarButtonItemStylePlain target:self action:@selector(addOptionClick)];
    self.navigationItem.rightBarButtonItem = rightButton;
}
-(void) addOptionClick
{
    AddOptionController *controller = [[AddOptionController alloc] init];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)logout
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Title" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
     }];
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
         NSLog(@"Cancel Action");
     }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)addViewController:(AddOptionController *)controller optionData:(Option *)option
{
    
    [self.options addObject:option];
    NSLog(@"count = %lu", self.options.count);
//
//    // 对数据进行编码
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.options requiringSecureCoding:YES error:nil];
//
//    //将二进制数据保存到文件
//    [[NSFileManager defaultManager]createFileAtPath:OptionPath contents:nil attributes:nil];
//    [data writeToFile:OptionPath atomically:YES];
    
    [NSKeyedArchiver archiveRootObject:self.options toFile:Path];
    
    [self.tableView reloadData];
}
-(void)editViewController:(EditViewController *)controller optionData:(Option *)option
{
    
    [self.tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.options.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0: {
            myCollectionViewController *controller = [[myCollectionViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        default:{
            EditViewController *controller = [[EditViewController alloc] init];
            controller.delegate = self;
            Option *option = self.options[indexPath.row];
            controller.option = option;
            [self.navigationController pushViewController:controller animated:YES];
            
            break;
        }
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    ListCell *cell = [ListCell cellWithTableView:tableView];
    Option *option = self.options[indexPath.row];
    cell.option = option;

    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.options removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
    [NSKeyedArchiver archiveRootObject:self.options toFile:Path];
}
- (NSMutableArray *)options
{
    if (!_options) {
        
//        NSLog(@"path = %@", OptionPath);
//        NSData *data = [NSData dataWithContentsOfFile:OptionPath];
//        NSLog(@"%@", data);
//      // Option *option = [NSKeyedUnarchiver unarchivedObjectOfClass:[Option class] fromData:data error:nil];
//       // NSLog(@"%@", option.name);
//
//
//        NSSet *options = [NSSet setWithObjects:[Option class], nil];
//        options = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[Option class], nil] fromData:data error:nil];

        _options = [NSKeyedUnarchiver unarchiveObjectWithFile:Path];
        
        if (!_options) {
            _options = [NSMutableArray array];
        }
    }
    return _options;
}
@end
