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
#import "BannerCell.h"
#import "Banner.h"
#import "BannerImage.h"



#define OptionPath [NSHomeDirectory()stringByAppendingPathComponent:@"Option.archiver"]
#define Path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Option.arc"]

@interface ListViewController ()<UITableViewDataSource, AddOptionControllerDelegate, UITableViewDelegate, EditViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *options;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *BannerArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSTimer *timer;
//@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Banner bannersWithSuccess:^(NSArray *array) {
        self.BannerArray = array;
    } error:^{
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
     layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
     layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
     layout.minimumInteritemSpacing = 0;
     layout.minimumLineSpacing = 0;
     CGFloat width = self.view.frame.size.width;
     
     UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, 200) collectionViewLayout:layout];
     collect.delegate = self;
     collect.dataSource = self;
     collect.pagingEnabled = YES;
     collect.showsHorizontalScrollIndicator = NO;
     collect.bounces = NO;
     [self.view addSubview: collect];
     self.collectionView = collect;
    [self addScrollTimer];
    [self.collectionView registerClass:[BannerCell class] forCellWithReuseIdentifier:@"main_collect"];
    
    CGFloat Y = CGRectGetMaxY(self.collectionView.frame);
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, Y, self.view.frame.size.width, self.view.frame.size.height - Y);
    
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
        // NSLog(@"Cancel Action");
     }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)addViewController:(AddOptionController *)controller optionData:(Option *)option
{
    
    [self.options addObject:option];
    //NSLog(@"count = %lu", self.options.count);
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
-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath{
    myCollectionViewController *controller = [[myCollectionViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case -1: {
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
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.collectionView.frame.size.width;
    CGFloat height = self.collectionView.frame.size.height;
    return CGSizeMake(width, height - 40);
}
 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.BannerArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"main_collect" forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.bannerImage = nil;
    cell.backgroundColor = [UIColor whiteColor];
    NSInteger index = (self.index + indexPath.item - 1 + self.BannerArray.count) % self.BannerArray.count;
    BannerImage *image = self.BannerArray[index];
    cell.tag = index;
    NSLog(@"item =   ------ %ld %ld", index, indexPath.item);
    cell.bannerImage = image;
    
    return cell;
}
//- (void)viewDidLayoutSubviews
//{
//    
//}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%lu", self.BannerArray.count);
    int offsetx = scrollView.contentOffset.x / scrollView.bounds.size.width - 1;
    self.index = (self.index + offsetx + self.BannerArray.count) % self.BannerArray.count;
    [self.collectionView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
    
    });
    NSLog(@"index = %ld", self.index);
}
- (void)setBannerArray:(NSArray *)BannerArray
{
    _BannerArray = BannerArray;
    [self.collectionView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
         [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
}
-(void)addScrollTimer
{
    //self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)nextPage
{
    self.index = (self.index + 1) % self.BannerArray.count;
    [self.collectionView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];
    
    });
}
@end
