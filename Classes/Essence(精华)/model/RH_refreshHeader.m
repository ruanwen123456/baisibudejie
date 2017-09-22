//
//  RH_refreshHeader.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/13.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_refreshHeader.h"
@interface RH_refreshHeader()
//logo
/** logo */
@property (nonatomic, weak) UIImageView *logoImageView;
@end

@implementation RH_refreshHeader
-(void)prepare{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor cyanColor];
//    self.lastUpdatedTimeLabel.text = @"上次刷新时间";
    [self.lastUpdatedTimeLabel setText:@"上次刷新时间"];
    [self setTitle:@"正在加载数据......." forState:MJRefreshStateRefreshing];
    [self setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    self.lastUpdatedTimeLabel.hidden = YES;
    
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"logo"];
    [self addSubview: logo];
    self.logoImageView = logo;
}
//布局子控件
-(void)placeSubviews{
    [super placeSubviews];
    self.logoImageView.RH_Width = self.RH_Width;
    self.logoImageView.RH_Height = 70;
    self.logoImageView.RH_Left = 0;
    self.logoImageView.RH_Above = -70;
}
@end
