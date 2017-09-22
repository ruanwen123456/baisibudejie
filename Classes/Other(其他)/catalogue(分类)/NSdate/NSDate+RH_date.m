//
//  NSDate+RH_date.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/14.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "NSDate+RH_date.h"

@implementation NSDate (RH_date)
static NSDateFormatter *fmt ;
//判断是否为今年
- (BOOL)isThisYear{
    //获取当前的时间
    NSCalendar *calendar = [NSCalendar RH_calendar];
      NSDate *selfDate = self;
    NSDate *nowDate = [NSDate date];
    return [calendar component:NSCalendarUnitYear fromDate:selfDate] == [calendar component:NSCalendarUnitYear fromDate:nowDate];
}
//判断是否为今天
-(BOOL)isToDay{
    //创建NSDateFormatter对象
    if (fmt == nil) {
        fmt = [[NSDateFormatter alloc] init];
    }

        //判断self的日期是否为今天
        fmt.dateFormat  =@"yyyy-MM-dd";
        //年
        NSString *selfDay  =[fmt stringFromDate:self];
        NSString *nowDay= [fmt stringFromDate:[NSDate date]];
        
    return [selfDay isEqualToString:nowDay];
}
//是否为昨天
-(BOOL)isYestesday{
    //创建NSDateFormatter对象
    if (fmt == nil) {
        fmt = [[NSDateFormatter alloc] init];
    }
    //判断self的日期是否为今天
    fmt.dateFormat  =@"yyyy-MM-dd";
    //获取时间的字符串
    NSString *selfDay  =[fmt stringFromDate:self];
    NSString *nowDay= [fmt stringFromDate:[NSDate date]];
    //将字符串转成NSDate类型
    NSDate *selfDate = [fmt dateFromString:selfDay];
    NSDate *nowDate = [fmt dateFromString:nowDay];
    
    NSCalendar *calendar = [NSCalendar RH_calendar];
    NSCalendarUnit uint = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents  *coms = [calendar components:uint fromDate:selfDate toDate:nowDate options:0];
    
    return coms.year == 0 && coms.month == 0 && coms.day == 1;
}
@end
