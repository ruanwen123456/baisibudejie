//
//  RH_footerView.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/5.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_footerView.h"
#import <AFNetworking.h>
#import "RH_Square_listModel.h"
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "RH_MeCubeButton.h"
#import "RH_webviewViewController.h"

@interface RH_footerView()

/** 存放所有模型的字典 */
@property (nonatomic, strong) NSMutableDictionary<NSString *,RH_Square_listModel*> *allSquares;

@end


@implementation RH_footerView
//懒加载字典
-(NSMutableDictionary<NSString *,RH_Square_listModel *> *)allSquares{
    if (!_allSquares) {
        _allSquares = [NSMutableDictionary dictionary];
    }
    return _allSquares;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = RH_DefaultColor;
//        self.RH_Height = 200;
        //设置参数
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"a"] = @"square";
        parameters[@"c"] = @"topic";
        
        //请求数据
        [[AFHTTPSessionManager manager] GET:RH_MeUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
            NSArray *listArr = [RH_Square_listModel mj_objectArrayWithKeyValuesArray:            responseObject[@"square_list"] ];
    
//            RH_Printf(@"%@",listArr);
            
            //根据模型创建控件
            [self RH_creatSquares:listArr];
            
            
//            //字典只有这个写入方法
//            [responseObject writeToFile:@"/Users/user/Desktop/me.plist" atomically:YES];
// 错误写法  字符串方法 : [responseObject writeToFile:@"/Users/user/Desktop/me.plist" atomically:YES encoding:NSUTF8StringEncoding error:nil];
//            RH_Printf(@"请求成功------%@ %@",[responseObject class] ,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            RH_Printf(@"error -----%@",error);
        }];
    }
    return self;
}

/**
 根据模型数组创建控件
 */
-(void)RH_creatSquares:(NSArray *)squares{
    NSUInteger count = squares.count;
    //初始化按钮尺寸
    int maxcols = 4;
    CGFloat ButtonWidth = self.RH_Width / maxcols;
    CGFloat ButtonHeight = ButtonWidth;
    for (NSUInteger i = 0; i < count; i++) {
        //取出对应的模型数据
        RH_Square_listModel *model = squares[i];
        
        //将模型中的名字作为关键字存储在字典中
        self.allSquares[model.name] = model;
        
        RH_MeCubeButton *button = [RH_MeCubeButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        [self addSubview:button];
        
        //布局按钮尺寸
        button.RH_Left = (i % maxcols) * ButtonWidth;
        button.RH_Above = (i / maxcols) * ButtonHeight;
        button.RH_Width = ButtonWidth - 1;
        button.RH_Height = ButtonHeight - 1;
        

        //设置按钮数据
        [button setTitle:model.name forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:model.icon ]options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            //延时
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [button setImage:image forState:UIControlStateNormal];
            });
        }];
    
    }
    //将footView的高度设置为最后添加按钮的底部值
    self.RH_Height = self.subviews.lastObject.RH_Bottom;
    
    //自适应footView的高度
    UITableView *tabelView =(UITableView *) self.superview;
//    tabelView.tableFooterView = self;
    [tabelView reloadData];
//    tabelView.contentSize = CGSizeMake(0, self.RH_Bottom);
}

-(void)ButtonClick:(RH_MeCubeButton *)button{
    //根据按钮的标题取出对应的模型
    RH_Square_listModel *model = self.allSquares[button.currentTitle];
    if ([model.url  hasSuffix:@"BDJ_To_Check"]) {
        RH_Printf(@"跳转到审帖界面");
    }
    if ([model.url hasPrefix:@"http"]) {
        RH_webviewViewController *webview = [[RH_webviewViewController alloc] init];
        webview.url = model.url;
        webview.navigationItem.title = button.currentTitle;
        //拿到根控制器
        UITabBarController *tabarVC= (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = tabarVC.childViewControllers.lastObject;
        [nav pushViewController:webview animated:YES];
        RH_Printf(@"利用webView加载数据");

    }
    RH_Printf(@"%@",model.url);
}
@end
