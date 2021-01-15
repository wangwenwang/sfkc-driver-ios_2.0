//
//  PrintimageAviationLabelViewController.h
//  tms-ios
//
//  Created by wangww on 2020/12/30.
//  Copyright © 2020 wangziting. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PrintimageAviationLabelViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *container;

@property (strong, nonatomic) NSString *productNo_s;

@property (strong, nonatomic) NSDictionary *dic;

@end

NS_ASSUME_NONNULL_END
