//
//  RH_settingViewController.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/8.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_settingViewController.h"
#import "RH_clearViewCell.h"

//设置重用标识
static NSString *const clearID = @"clearCell";

@interface RH_settingViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 尺寸 */
//@property (nonatomic, assign) unsigned long long  size;
@end

@implementation RH_settingViewController

//设置为分组样式

-(instancetype)init{
    
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //注册cell
    [self.tableView registerClass:[RH_clearViewCell class] forCellReuseIdentifier:clearID];
    
    RH_Printf(@"%@",NSHomeDirectory());
//    [self getSize];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView代理实现
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    unsigned long long  size = 0;
//    //创建标识符
//    static NSString *ID = @"cell";
//    //从缓存池中取值
//   UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:ID];
    
    //从缓存池中取cell
    RH_clearViewCell *cell = [tableView dequeueReusableCellWithIdentifier:clearID];

//    //如果cell为空重新创建
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }

    return cell;
}
//选中cell方法的实现
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


}

@end
