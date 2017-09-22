//
//  RH_clearViewCell.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/11.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_clearViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>
#define RH_CachesDirectory  [ [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"--.RH-baisi"]
@implementation RH_clearViewCell
//重写方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加计算进度 正在处理
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView  =loadingView;
      
//                NSString *filePath = [NSString stringWithFormat:@"/Users/user/Desktop/dad"];
        //设置默认的加载样式
        self.textLabel.text = @"正在计算缓存大小...........";

        //禁止cell点击
        self.userInteractionEnabled = NO;
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{  //子线程计算缓存的大小
#warning 睡眠
            [NSThread sleepForTimeInterval:2];
            unsigned long long  size = RH_CachesDirectory.getFileSize;
            
            NSString *sizeText = nil;
            if (size > pow(10, 9)) { //内存大于1GB
                sizeText = [NSString stringWithFormat:@"%.2fGB",size / pow(10, 9) ];
            }
            else if (size > pow(10, 6)){ //内存大于1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB",size / pow(10, 6) ];
            }
            else if (size > pow(10, 3)){ //内存大于1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB",size / pow(10, 3) ];

            }else{
                sizeText = [NSString stringWithFormat:@"%zdB",size ];

            }
            //恢复cell的点击
            self.userInteractionEnabled = YES;
            
            NSString * text = [NSString stringWithFormat:@"清除缓存(%@)",sizeText];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //因为accessoryView的优先级大于accessoryType，所以要先清空accessoryView得值才能对accessoryType赋值
                self.accessoryView = nil;
                self.textLabel.text = text;
                //设置右边的箭头
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            });
            [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
        });
    }
    return self;
}

//清除缓存的实现
-(void)tapClick{
    //弹出蒙版
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.label.text = @"正在清除缓存";
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.label.textColor = [UIColor grayColor];
    hud.dimBackground = YES;
    
    //开子线程清除缓存文件
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //删除缓存文件
        NSFileManager *manager = [NSFileManager defaultManager];
        //先删除文件缓存
        [manager removeItemAtPath:[NSString stringWithFormat:@"%@", RH_CachesDirectory] error:nil];
        //创建新的问价夹
        //IntermediateDirectories是否带有中间文件夹 YES如果没有自行创建
        [manager createDirectoryAtPath:RH_CachesDirectory withIntermediateDirectories:YES attributes:nil error:nil];
#warning 睡眠
        [NSThread sleepForTimeInterval:2];
        //所有缓存清除完毕
        dispatch_async(dispatch_get_main_queue(), ^{
            //关闭蒙版
            [MBProgressHUD hideHUDForView:self.window animated:YES];
            
            //还原文字
            self.textLabel.text = @"清除缓存(0B)";
        });
    });
   }

/**
 当cell重新显示到屏幕上时就会调用这个方法
 */
-(void)layoutSubviews{
    [super layoutSubviews];
        //当删除cell被循环利用之后调用此方法重新加载动画
        UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *) self.accessoryView;
        [loadingView startAnimating];
}
@end
