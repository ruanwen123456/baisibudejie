//
//  RH_viewFrameExtension.m
//  RH_baisi
//
//  Created by 阮浩 on 17/8/16.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_viewFrameExtension.h"

@implementation UIView(RH_viewFrameExtension)
-(CGFloat)RH_Left{
    return self.frame.origin.x;
}
-(void)setRH_Left:(CGFloat)RH_Left{
    CGRect frame = self.frame;
    frame.origin.x = RH_Left;
    self.frame = frame;
}

-(CGFloat)RH_Above{
    return self.frame.origin.y;
}
-(void)setRH_Above:(CGFloat)RH_Above{
    CGRect frame = self.frame;
    frame.origin.y = RH_Above;
    self.frame = frame;
}

-(CGFloat)RH_Width{
    return self.frame.size.width;
}
-(void)setRH_Width:(CGFloat)RH_Width{
    CGRect frame = self.frame;
    frame.size.width = RH_Width;
    self.frame = frame;
}
-(CGFloat)RH_Height{
    return self.frame.size.height;
}
-(void)setRH_Height:(CGFloat)RH_Height{
    CGRect frame = self.frame;
    frame.size.height = RH_Height;
    self.frame = frame;
}
-(CGFloat)RH_Right{
    return CGRectGetMaxX(self.frame);
}
-(void)setRH_Right:(CGFloat)RH_Right{
    self.RH_Left = RH_Right - self.RH_Width;
}
-(CGFloat)RH_Bottom{
    return CGRectGetMaxY(self.frame);
}
-(void)setRH_Bottom:(CGFloat)RH_Bottom{
    self.RH_Above = RH_Bottom - self.RH_Height;
}
-(CGFloat)RH_CenterX{
    return self.center.x;
}
-(void)setRH_CenterX:(CGFloat)RH_CenterX{
    CGPoint size = self.center;
    size.x = RH_CenterX;
    self.center = size;
}
-(CGFloat)RH_CenterY{
    return self.center.y;
}
-(void)setRH_CenterY:(CGFloat)RH_CenterY{
    CGPoint size = self.center;
    size.y = RH_CenterY;
    self.center = size;
}
+(instancetype)RH_ViewWithXib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
