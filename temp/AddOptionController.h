//
//  AddOptionController.h
//  temp
//
//  Created by xubinbin on 2020/3/5.
//  Copyright © 2020 ccsu_cat. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddOptionController, Option;

@protocol AddOptionControllerDelegate <NSObject>

-(void)addViewController:(AddOptionController *)controller optionData:(Option *) option;

@end
@interface AddOptionController : UIViewController

@property (nonatomic, weak) id<AddOptionControllerDelegate> delegate;
@end

