//
//  NSCalendar+RH_calendar.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/14.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "NSCalendar+RH_calendar.h"

@implementation NSCalendar (RH_calendar)
+(instancetype)RH_calendar{
    if (RH_ios(8)) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else{
        return [NSCalendar currentCalendar];
    }
}
@end
