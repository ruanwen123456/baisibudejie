//
//  NSString+RH_Extension.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/11.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "NSString+RH_Extension.h"

@implementation NSString (RH_Extension)
-(unsigned long long)getFileSize{
    
    unsigned long long size = 0;
    
    //创建文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //文件夹类型
    NSDictionary *attrs = [manager attributesOfItemAtPath:self error:nil];
    
    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) {       //传入的路径为文件夹类型
        
        //获取文件夹下所有文件的大小
        NSDirectoryEnumerator *subPaths = [manager enumeratorAtPath:self];
        
        for (NSString *partPath in subPaths) {
            //拼接全路径
            NSString *fullpath = [self stringByAppendingPathComponent:partPath];
            //计算文件大小
            size  = size + [manager attributesOfItemAtPath:fullpath error:nil].fileSize;
        }
    }
    else{   //传入的类型为单独的文件
        
        size = attrs.fileSize; //直接计算文件夹的大小
    }
    return size;
}
@end
