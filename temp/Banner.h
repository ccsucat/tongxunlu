//
//  Banner.h
//  temp
//
//  Created by xubinbin on 2020/3/9.
//  Copyright © 2020 ccsu_cat. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Banner : NSObject
@property (nonatomic, strong) NSString *url;
-(instancetype)initWithDict:(NSDictionary *) dict;
+(instancetype) bannerWithDict:(NSDictionary *)dict;

+(void)bannersWithSuccess:(void(^)(NSArray *array))success error:(void(^)())error;
@end

