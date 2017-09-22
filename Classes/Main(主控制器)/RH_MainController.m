//
//  RH_MainController.m
//  RH_baisi
//
//  Created by 阮浩 on 17/8/9.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_MainController.h"
#import "RH_attentionController.h"
#import "RH_EssenceController.h"
#import "RH_MeController.h"
#import "RH_NewsController.h"
#import "UIImage+RH_ImageEx.h"
#import "RH_publicController.h"
#import "RH_NavController.h"

@interface RH_MainController ()

@end

@implementation RH_MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置所有UITabBarItem的文字属性
    [self setupItemTitleTextAttributes];
    
    //设置子控制器
    [self setupChildViewController];
   
}
#pragma mark -  设置所有UITabBarItem的文字属性

/**
 *  设置所有UITabBarItem的文字属性
 */
- (void)setupItemTitleTextAttributes
{
    UITabBarItem *item = [UITabBarItem appearance];
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateSelected];
}

#pragma mark - 设置子控制器
-(void) setupChildViewController{
    
    //新帖
    RH_NewsController *newsController = [[RH_NewsController alloc] init];
    [self addChildViewController:[[RH_NavController alloc] initWithRootViewController:newsController] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
       //精华
    RH_EssenceController *essenceController = [[RH_EssenceController alloc] init];
    [self addChildViewController:[[RH_NavController alloc] initWithRootViewController:essenceController] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
 
    UIViewController *publicController = [[UIViewController alloc] init];
    [self addChildViewController:publicController title:nil image:nil selectedImage:nil];

    //关注
    RH_attentionController *attentionController = [[RH_attentionController alloc] init];
    [self addChildViewController:[[RH_NavController alloc] initWithRootViewController:attentionController] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    

    //我的
    RH_MeController *meController = [[RH_MeController alloc] init];
    [self addChildViewController:[[RH_NavController alloc] initWithRootViewController:meController] title:@"我的" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
}
#pragma mark - 添加控制器的方法

-(void)addChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    vc.tabBarItem.title = title;
    vc.view.backgroundColor = RH_DefaultColor;
    if (image.length && selectedImage.length) {
        vc.tabBarItem.image = [UIImage RH_originalImageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage RH_originalImageNamed:selectedImage];
    }
    [self addChildViewController:vc];
}

#pragma mark - 拓展按钮
-(void)viewDidAppear:(BOOL)animated{
    /** 添加发布按钮 **/
    UIButton *publicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [publicButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [publicButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    publicButton.frame = CGRectMake(0, 0, RH_tabBarWidth * 0.2, RH_tabBarHeight);
    publicButton.center = CGPointMake(RH_tabBarWidth * 0.5,  RH_tabBarHeight * 0.5);
    
    [publicButton addTarget:self action:@selector( publicFunc) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:publicButton];
}

#pragma mark - 拓展按钮方法的实现
-(void)publicFunc{
    RH_func
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
