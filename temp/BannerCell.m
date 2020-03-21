//
//  BannerCell.m
//  temp
//
//  Created by xubinbin on 2020/3/9.
//  Copyright © 2020 ccsu_cat. All rights reserved.
//


#import "BannerCell.h"
#import <SDWebImage.h>
#import <UIView+WebCache.h>
#import "BannerImage.h"
#import <Masonry.h>
@interface BannerCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation BannerCell


- (void)setBannerImage:(BannerImage *)bannerImage
{
    _bannerImage = bannerImage;
    self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.frame];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imageView];
    //NSLog(@"url ====  %@", self.bannerImage.url);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:bannerImage.url]];

    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = 6;
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.contentView addSubview:self.pageControl];
    self.pageControl.currentPage = self.tag;
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-30);
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
    }];
    //NSLog(@"cell --- tag = %ld", self.tag);
}
@end
