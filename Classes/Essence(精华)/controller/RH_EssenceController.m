//
//  RH_EssenceController.m
//  RH_baisi
//
//  Created by 阮浩 on 17/8/9.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_EssenceController.h"
#import "RH_titleBtn.h"
#import "RH_wordViewController.h"
#import "RH_picViewController.h"
#import "RH_voiceViewController.h"
#import "RH_videoViewController.h"
#import "RH_allViewController.h"
#import "RH_recommendViewController.h"
@interface RH_EssenceController ()<UIScrollViewDelegate>
/** titleView */
@property (nonatomic, strong) UIView *titleView;
/** scrollView*/
@property (nonatomic, strong) UIScrollView *scroll;

/** 标题按钮数量 */
@property (nonatomic, assign) NSUInteger  count;

/** 选中按钮 */
@property (nonatomic, weak) RH_titleBtn *selectButton;

/** 指示控件 */
@property (nonatomic, weak) UIView *indirctView;
@end

@implementation RH_EssenceController
-(void)EssenceClick{
    RH_recommendViewController *vc = [[RH_recommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.scroll.delegate = self;
  //设置导航栏内容
    [self setNavView];
    //创建子控制器
    [self setChildViewController];
    //设置滚动视图
    [self setScrollerView];
    //设置标题栏视图
    [self setTitleView];

    //默认添加子控制器的view
    [self addChildVc];
}
-(void)setChildViewController{
    RH_allViewController *allViewController = [[RH_allViewController alloc] init];
    [self addChildViewController:allViewController];
    RH_videoViewController *videoController  = [[RH_videoViewController alloc] init];
    [self addChildViewController:videoController];
    RH_voiceViewController *voiceController = [[RH_voiceViewController alloc] init];
    [self addChildViewController:voiceController];
    RH_picViewController *picController = [[RH_picViewController alloc] init];
    [self addChildViewController:picController];
    RH_wordViewController *wordController = [[RH_wordViewController alloc] init];
    [self addChildViewController:wordController];
}
-(void)setTitleView{
    
    //标题栏
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = RH_Color_32(255, 255, 255, 0.4);
    titleView.frame = CGRectMake(0, 64, self.view.RH_Width, 44);
    [self.view addSubview:titleView];
    self.titleView = titleView;
    //添加标题
    NSArray *titleArr = @[@"全部",@"视频",@"声音",@"图片",@"帖子"];
    NSUInteger titleCount = titleArr.count;
    self.count = titleCount;
    for (NSInteger i = 0; i < titleCount; i++) {
        RH_titleBtn *titleButton = [RH_titleBtn buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        titleButton.RH_Width = titleView.RH_Width / titleCount;
        titleButton.RH_Height = titleView.RH_Height;
        titleButton.RH_Above = 0;
        titleButton.RH_Left = titleButton.RH_Width * i;
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleButton setTitle:titleArr[i] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置选中按钮的颜色
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [titleView addSubview:titleButton];
        
        
    
    }

    //拿出最后一个添加的按钮
    RH_titleBtn *lastBtn = titleView.subviews.lastObject;
    RH_titleBtn *firstBtn = titleView.subviews.firstObject;

    //添加底部的指示器
    UIView *indirctView  = [[UIView alloc] init];
    
    //将view的颜色设置为选中按钮的颜色
    indirctView.backgroundColor = [lastBtn titleColorForState:UIControlStateSelected];
    indirctView.RH_Height = 1;
    indirctView.RH_Above = titleView.RH_Height - indirctView.RH_Height;
    
    [titleView addSubview:indirctView];
    self.indirctView = indirctView;
    
    
    //默认选中第一个按钮
    [firstBtn.titleLabel sizeToFit];
    [self btnClick:firstBtn];
}
//标题按钮点击实现

-(void)btnClick:(RH_titleBtn *)btn{
    //设置按钮的状态
    self.selectButton.selected = NO;
    btn.selected = YES;
    self.selectButton =btn;
    
    //指示器
    //计算指示器的宽度
    self.indirctView.RH_Width = self.selectButton.titleLabel.RH_Width;
    [UIView animateWithDuration:0.25 animations:^{
        self.indirctView.RH_CenterX = self.selectButton.RH_CenterX;
    }];
    //先滚动在加载视图
    CGPoint offSet = self.scroll.contentOffset;
    offSet.x = btn.tag * self.scroll.RH_Width;
    
    [self.scroll setContentOffset:offSet animated:YES];
 
}
-(void)setScrollerView{
    
    //关闭自动调整尺寸
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.backgroundColor = RH_DefaultColor;
    scroll.frame = self.view.bounds;
    scroll.contentSize  =CGSizeMake(self.view.RH_Width * 5, 0);
    scroll.showsVerticalScrollIndicator  = YES;
    scroll.showsHorizontalScrollIndicator = YES;
   scroll.delegate = self;

    [self.view addSubview:scroll];
    self.scroll  = scroll;
    
//    //将自控制器添加到滚动视图当中
//    NSUInteger count = self.childViewControllers.count;
//    for (NSUInteger i = 0; i < count; i++) {
//        UITableView *childView =(UITableView *) self.childViewControllers[i].view;
//        childView.backgroundColor = RH_Arc4RandomColor;
//        childView.RH_Left = self.view.RH_Width * i;
//        childView.RH_Above = 0;
//        childView.RH_Height = self.scroll.RH_Height;
//        [scroll addSubview:childView];
//        //设置内边距
//        childView.contentInset  = UIEdgeInsetsMake(64+44, 0, 49, 0);
//        scroll.scrollIndicatorInsets = UIEdgeInsetsMake(64+44, 0, 49, 0);
//    }
}
-(void)setNavView{
    //设置标题
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage: [UIImage imageNamed:@"MainTitle"]]];
    //设置左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(EssenceClick) ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate实现
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self addChildVc];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //添加点击按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.RH_Width;
    RH_titleBtn *buttonClick =(RH_titleBtn *) self.titleView.subviews[index];
    [self btnClick:buttonClick];
    //添加子控制器
    [self addChildVc];
}

//添加子控制器的view
-(void)addChildVc{
    //取出下标
    NSUInteger index = self.scroll.contentOffset.x / self.scroll.RH_Width;
    //取出自控制器
    UIViewController *childVc = self.childViewControllers[index];
    if ([childVc isViewLoaded]) {
        return;
    }
    childVc.view.RH_Above = 0;
    childVc.view.RH_Left  = index * self.scroll.RH_Width;
    childVc.view.RH_Width =  self.scroll.RH_Width;
    childVc.view.RH_Height  = self.scroll.RH_Height;
    childVc.view.backgroundColor = RH_DefaultColor;
    [self.scroll addSubview:childVc.view];
}
@end
