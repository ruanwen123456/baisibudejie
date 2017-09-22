//
//  UIBarButtonItem+RH_BarButtonItemExtension.m
//  RH_baisi
//
//  Created by 阮浩 on 17/8/17.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "UIBarButtonItem+RH_BarButtonItemExtension.h"

@implementation UIBarButtonItem (RH_BarButtonItemExtension)
+(instancetype)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}


@end
