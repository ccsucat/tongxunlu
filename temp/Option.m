//
//  Option.m
//  temp
//
//  Created by xubinbin on 2020/3/5.
//  Copyright © 2020 ccsu_cat. All rights reserved.
//

#import "Option.h"

@implementation Option

+ (BOOL)supportsSecureCoding
{
    return YES;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phoneNumber forKey:@"phoneNumber"];
}
-(instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.phoneNumber = [coder decodeObjectForKey:@"phoneNumber"];
    }
    return self;
}
@end
