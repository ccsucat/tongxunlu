//
//  Option.h
//  temp
//
//  Created by xubinbin on 2020/3/5.
//  Copyright © 2020 ccsu_cat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Option : NSObject <NSSecureCoding>

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *phoneNumber;

@end

NS_ASSUME_NONNULL_END
