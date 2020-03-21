//
//  myCollectionViewController.m
//  temp
//
//  Created by xubinbin on 2020/3/5.
//  Copyright © 2020 ccsu_cat. All rights reserved.
//

#import "myCollectionViewController.h"
#import "Option.h"

@interface myCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *array;

@end

@implementation myCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:100];
    for (int i = 0; i < 100; i++) {
        Option *op = [[Option alloc] init];
        [arrayM addObject: op];
    }
    _array = arrayM;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"collectionView";
    //创建一个布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    //设置每个item的大小
    layout.itemSize = CGSizeMake(100, 100);
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    collect.delegate = self;
    collect.dataSource = self;
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collect"];
    [self.view addSubview: collect];
    self.collectionView = collect;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collect" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    //Option *op = [[Option alloc] init];
   // cell.op = self.array[indexPath.item];
   // cell.op;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row%2==0) {
        return CGSizeMake(50, 50);
    }else{
        return CGSizeMake(150, 150);
    }
}
 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

@end
