//
//  RH_QuickLoginButton.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/1.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_QuickLoginButton.h"

@implementation RH_QuickLoginButton

-(void)awakeFromNib{
    [super awakeFromNib];
//    self.imageView.backgroundColor = [UIColor cyanColor];
//    self.titleLabel.backgroundColor = [UIColor redColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //设置图片
    self.imageView.RH_Above = 0;
    self.imageView.RH_CenterX = self.RH_Width * 0.5;
    
    //设置label
    self.titleLabel.RH_Left = 0;
    self.titleLabel.RH_Above = self.imageView.RH_Bottom;
    self.titleLabel.RH_Height = self.RH_Height - self.imageView.RH_Bottom;
    self.titleLabel.RH_Width  = self.RH_Width;
}
@end
