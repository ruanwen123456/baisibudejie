//
//  RH_viewFrameExtension.h
//  RH_baisi
//
//  Created by 阮浩 on 17/8/16.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(RH_viewFrameExtension)
/** 控件距离左边线的距离 */
@property (nonatomic, assign) CGFloat  RH_Left;
/** 控件右边线的距离 */
@property (nonatomic, assign) CGFloat  RH_Right;
/** 控件距离上边线的距离 */
@property (nonatomic, assign) CGFloat  RH_Above;
/** 控件下边线的距离 */
@property (nonatomic, assign) CGFloat  RH_Bottom;
/** 控件长 */
@property (nonatomic, assign) CGFloat  RH_Width;
/** 控件宽 */
@property (nonatomic, assign) CGFloat  RH_Height;
/** 控件中心点X值 */
@property (nonatomic, assign) CGFloat  RH_CenterX;
/** 控件中心点Y值 */
@property (nonatomic, assign) CGFloat  RH_CenterY;

//加载类名的XIB
+(instancetype)RH_ViewWithXib;
@end
