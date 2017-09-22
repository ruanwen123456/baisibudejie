//
//  UIImage+RH_ImageEx.m
//  RH_baisi
//
//  Created by 阮浩 on 17/8/9.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "UIImage+RH_ImageEx.h"

@implementation UIImage (RH_ImageEx)
//设置图片为原始图片
+(UIImage *)RH_originalImageNamed:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    image  = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}
//设置圆形图片
-(UIImage *)Rh_circleImage{
    
    //开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    //上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect =  CGRectMake(0, 0, self.size.width, self.size.height);
    //添加一个圆
    CGContextAddEllipseInRect(ctx,rect);
    //对多余的地方进行裁剪
    CGContextClip(ctx);
    //绘制图片
    [self drawInRect:rect];
    //获得图片
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();

    return circleImage;
}
@end
