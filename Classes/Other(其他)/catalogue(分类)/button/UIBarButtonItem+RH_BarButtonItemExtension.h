//
//  UIBarButtonItem+RH_BarButtonItemExtension.h
//  RH_baisi
//
//  Created by 阮浩 on 17/8/17.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (RH_BarButtonItemExtension)
+(instancetype)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action;
@end
