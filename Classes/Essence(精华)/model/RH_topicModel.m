//
//  RH_topicModel.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/13.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_topicModel.h"
#import "RH_commentModel.h"
#import "RH_userModel.h"
@implementation RH_topicModel

static NSDateFormatter *fmt;
static NSCalendar *calendar ;
+(NSDictionary *)mj_objectClassInArray{
    return @{@"top_cmt":[RH_commentModel class]};
}

-(NSString *)created_at{
    //获取calendar
    if (calendar == nil) {
        calendar = [NSCalendar RH_calendar];
    }
    //获得发帖的时间
    if (fmt == nil) {
          fmt = [[NSDateFormatter alloc] init];
    }
    fmt.dateFormat  = @"yyyy-MM-dd HH:mm:ss";
    NSDate *crateDate = [fmt dateFromString:_created_at];
    if (crateDate.isThisYear) { //今年
        if (crateDate.isToDay) { //今天
            //当前时间
            NSDate *nowDate = [NSDate date];
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *coms = [calendar components:unit fromDate:crateDate toDate:nowDate options:0];
            if (coms.hour > 1) {
                return [NSString stringWithFormat:@"%zd小时前",coms.hour];
            }else if (coms.minute > 1){
                return [NSString stringWithFormat:@"%zd分钟前",coms.minute];
            }else{
                return [NSString stringWithFormat:@"刚刚"];
            }
        }else if (crateDate.isYestesday){//昨天
                fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:crateDate];
        }else{
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:crateDate];
        }
    }else{ //非今年
        return _created_at;
    }
}

//重写cellHeight的get方法
- (CGFloat)cellHeight
{
    // 如果cell的高度已经计算过, 就直接返回
    if (_cellHeight) return _cellHeight;
    
    // 1.头像
    _cellHeight = 54;
    
    // 2.文字
    CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * 10;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    CGSize textSize = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
    _cellHeight += textSize.height + 10;
    
    // 3.中间的内容
    if (self.type != RH_TopicTypeWord) { // 如果是图片\声音\视频帖子, 才需要计算中间内容的高度
        // 中间内容的高度 == 中间内容的宽度 * 图片的真实高度 / 图片的真实宽度
        CGFloat contentH = textMaxW * self.height / self.width;
        
        if (contentH >= [UIScreen mainScreen].bounds.size.height) { // 超长图片
            // 将超长图片的高度变为200
//            vc.imageView.userInteractionEnabled = NO;
            
            contentH = 200;
            self.bigPicture = YES;
        }
        
        // 这里的cellHeight就是中间内容的y值
        self.contentFrame = CGRectMake(10, _cellHeight, textMaxW, contentH);
        
        // 累加中间内容的高度
        _cellHeight += contentH + 10;
    }
    
    // 4.最热评论
    if (self.top_cmt) { // 如果有最热评论
        // 最热评论-标题
        _cellHeight += 20;
        // 最热评论-内容
        NSString *topCmtContent = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
        CGSize topCmtContentSize = [topCmtContent boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
        _cellHeight += topCmtContentSize.height + 10;
    }
    
    // 5.底部 - 工具条
    _cellHeight += 35 + 10;
    
    return _cellHeight;
}
@end
