//
//  RH_recommendTableViewCell.h
//  RH_baisi
//
//  Created by 阮浩 on 17/9/17.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RH_recommendModel;
@interface RH_recommendTableViewCell : UITableViewCell
/** 模型数据 */
@property (nonatomic, weak) RH_recommendModel *recommendModel;
@end
