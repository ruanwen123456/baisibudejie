//
//  RH_recommendModel.h
//  RH_baisi
//
//  Created by 阮浩 on 17/9/17.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RH_recommendModel : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;

@end
