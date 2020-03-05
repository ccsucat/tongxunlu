//
//  EditViewController.h
//  temp
//
//  Created by xubinbin on 2020/3/5.
//  Copyright © 2020 ccsu_cat. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Option, EditViewController;

@protocol EditViewControllerDelegate <NSObject>

-(void)editViewController:(EditViewController *)controller optionData:(Option *)option;

@end

@interface EditViewController : UIViewController

@property (nonatomic, strong) Option *option;
@property (nonatomic, weak) id<EditViewControllerDelegate> delegate;
@end


