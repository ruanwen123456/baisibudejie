//
//  RH_refreshFooter.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/13.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_refreshFooter.h"

@implementation RH_refreshFooter
- (void)prepare{
    [super prepare];
    //设置出现控件的百分比开始自动刷新 负数会提前刷新 默认是0
    self.triggerAutomaticallyRefreshPercent = 0;
    //关闭自动刷新
    self.automaticallyRefresh = NO;
    [self setTitle:@"点击加载更多"forState:MJRefreshStateIdle];
    [self setTitle:@"正在加载更多数据......."forState:MJRefreshStateRefreshing];
}

@end
