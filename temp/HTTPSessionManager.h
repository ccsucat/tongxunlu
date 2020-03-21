//
//  HTTPSessionManager.h
//  temp
//
//  Created by xubinbin on 2020/3/9.
//  Copyright © 2020 ccsu_cat. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HTTPSessionManager : AFHTTPSessionManager
+(instancetype)sharedManager;
@end

