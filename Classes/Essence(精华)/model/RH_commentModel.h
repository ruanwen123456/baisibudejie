//
//  RH_commentModel.h
//  RH_baisi
//
//  Created by 阮浩 on 17/9/15.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RH_userModel;
@interface RH_commentModel : NSObject
/** 用户 */
@property (nonatomic, strong) RH_userModel *user;
/** 评论内容*/
@property (nonatomic, copy) NSString *content;
@end
