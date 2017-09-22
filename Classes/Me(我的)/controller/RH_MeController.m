//
//  RH_MeController.m
//  RH_baisi
//
//  Created by 阮浩 on 17/8/9.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_MeController.h"
#import "RH_footerView.h"
#import "RH_settingViewController.h"
@interface RH_MeController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation RH_MeController

- (void)viewDidLoad {
  
    [super viewDidLoad];
    
    
    //设置导航栏
    [self setNav];
    
   //设置cell样式
    [self setTableViewCell];
    
    //设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //设置footer
    self.tableView.tableFooterView = [[RH_footerView alloc] init];
    
}

#pragma mark - 设置样式为分组
-(instancetype)init{
    
    return [self initWithStyle:UITableViewStyleGrouped];
}

-(void)setTableViewCell{
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight  = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    self.view.backgroundColor = RH_DefaultColor;
}

-(void)setNav{
    
    self.navigationItem.title = @"我的";
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" target:self action:@selector(settingClick) ];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self action:@selector(moonClick) ];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
}
-(void)moonClick{
    RH_func
}
-(void)settingClick{
    RH_settingViewController *vc = [[RH_settingViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


#pragma mark - 实现UITableViewDataSource 方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置重用标识
    static NSString * ID = @"cell";
    
    //从缓存池中取数据
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //如果缓存池中没有 自己创建
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }
    else{
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
