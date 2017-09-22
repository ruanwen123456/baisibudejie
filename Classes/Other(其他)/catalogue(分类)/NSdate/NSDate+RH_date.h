//
//  NSDate+RH_date.h
//  RH_baisi
//
//  Created by 阮浩 on 17/9/14.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RH_date)
//是否为今年
- (BOOL)isThisYear;
//是否为今天
-(BOOL)isToDay;
//是否为昨天
-(BOOL)isYestesday;
@end
