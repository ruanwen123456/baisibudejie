//
//  UIImage+RH_ImageEx.h
//  RH_baisi
//
//  Created by 阮浩 on 17/8/9.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RH_ImageEx)

//设置图片为原始图片
+(UIImage *)RH_originalImageNamed:(NSString *)imageName;
//设置圆形图片
-(UIImage *)Rh_circleImage;
@end
