
//
//  RH_MeCubeButton.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/6.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_MeCubeButton.h"

@implementation RH_MeCubeButton
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //设置图片尺寸
    self.imageView.RH_Above = self.RH_Height * 0.2;
    self.imageView.RH_Height = self.RH_Height * 0.5;
    self.imageView.RH_Width = self.imageView.RH_Height;
    self.imageView.RH_CenterX = self.RH_Width * 0.5;
    
    //设置文字
    self.titleLabel.RH_Left = 0;
    self.titleLabel.RH_Above = self.imageView.RH_Bottom;
    self.titleLabel.RH_Width = self.RH_Width;
    self.titleLabel.RH_Height  = self.RH_Height - self.imageView.RH_Bottom;
   
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


@end
