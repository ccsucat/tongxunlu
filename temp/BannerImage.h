//
//  BannerImage.h
//  temp
//
//  Created by xubinbin on 2020/3/9.
//  Copyright © 2020 ccsu_cat. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerImage : JSONModel
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString<Optional> *uri;
@property (nonatomic, assign) NSString<Optional> *imageType;
@property (nonatomic, assign) NSString<Optional> *width;
@property (nonatomic, assign) NSString<Optional> *height;
@property (nonatomic, strong) NSString<Optional> *urList;
@end

NS_ASSUME_NONNULL_END
