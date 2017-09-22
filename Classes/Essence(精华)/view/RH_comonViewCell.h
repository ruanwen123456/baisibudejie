//
//  RH_comonViewCell.h
//  RH_baisi
//
//  Created by 阮浩 on 17/9/14.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RH_topicModel;
@interface RH_comonViewCell : UITableViewCell
/** 帖子模型数据 */
@property (nonatomic, strong) RH_topicModel *topicModel;
@end
