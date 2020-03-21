//
//  Banner.m
//  temp
//
//  Created by xubinbin on 2020/3/9.
//  Copyright © 2020 ccsu_cat. All rights reserved.
//

#import "Banner.h"
#import "HTTPSessionManager.h"
#import "BannerImage.h"

@implementation Banner

+(void)bannersWithSuccess:(void (^)(NSArray * _Nonnull))success error:(void (^)())error {
    [[HTTPSessionManager sharedManager] GET:@"" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        NSDictionary *data = responseObject[@"data"];
        NSDictionary *main_page_banner = data[@"main_page_banner"];
        NSArray *items = main_page_banner[@"items"];
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:items.count];
        [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *image = obj[@"image"];
            NSDictionary *dict = image[0];
            BannerImage *imageData = [[BannerImage alloc] initWithDictionary:dict error:nil];
            [arrayM addObject:imageData];
        }];
        if (success) {
            success(arrayM.copy);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull er) {
        if (er) {
            error();
        }
    }];
}
@end
