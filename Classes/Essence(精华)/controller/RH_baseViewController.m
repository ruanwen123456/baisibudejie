//
//  RH_baseViewController.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/12.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "RH_topicModel.h"
#import "RH_refreshFooter.h"
#import "RH_comonViewCell.h"

#import "RH_baseViewController.h"
#import "RH_allViewController.h"
#import "RH_picViewController.h"
#import "RH_wordViewController.h"
#import "RH_videoViewController.h"
#import "RH_voiceViewController.h"

#import "RH_commentViewController.h"

@interface RH_baseViewController ()
/** 模型数组 */
@property (nonatomic, strong) NSMutableArray<RH_topicModel *> *ListArr;

/** maxtime 用来加载更多的数据*/
@property (nonatomic, copy) NSString *maxtime;

/** 下拉任务 */
@property (nonatomic, weak) NSURLSessionTask *task;
@property (nonatomic, weak) NSURLSessionTask *task2;
@end

@implementation RH_baseViewController

static NSString *const comonID = @"topic";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取消cell的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RH_comonViewCell class]) bundle:nil] forCellReuseIdentifier:comonID];
    
    self.tableView.contentInset = UIEdgeInsetsMake(64+44, 0, 49, 0);
    self.tableView.scrollIndicatorInsets  = self.tableView.contentInset;
    
    //加载数据
    [self loadNewList];
    
    //刷新控件
    [self setRefresh];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)setRefresh{
    
    RH_refreshHeader *normalheader = [RH_refreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewList)];
    self.tableView.mj_header = normalheader;
    
    //上拉刷新数据
    RH_refreshFooter *footer = [RH_refreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer = footer;
}

//加载更多的数据
-(void)loadMoreData{
    //在上拉刷新时取消下拉刷新功能
    [self.task cancel];
    //发请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    
    if ([NSStringFromClass(self.class) isEqualToString:@"RH_allViewController"]) {
        parameters[@"type"] = @"1";
    }
   else if ([NSStringFromClass(self.class) isEqualToString:@"RH_videoViewController"]) {
        parameters[@"type"] = @"41";
    }
    else if ([NSStringFromClass(self.class) isEqualToString:@"RH_voiceViewController"]) {
        parameters[@"type"] = @"31";
    }
    else if ([NSStringFromClass(self.class) isEqualToString:@"RH_picViewController"]) {
        parameters[@"type"] = @"10";
    }else if ([NSStringFromClass(self.class) isEqualToString:@"RH_wordViewController"]) {
        parameters[@"type"] = @"29";
    }
    parameters[@"maxtime"] = self.maxtime;
    
    self.task2 = [manager GET:RH_MeUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //存储maxtime关键字
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSMutableArray<RH_topicModel *> *listArr = [RH_topicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.ListArr addObjectsFromArray:listArr];
        
        
#warning 使用afn请求数据后一定要刷新表格
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RH_Printf(@"error-------%@",error);
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)loadNewList{
    //下拉刷新时取消上拉刷新功能
    [self.task2 cancel];
    //发请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    if ([NSStringFromClass(self.class) isEqualToString:@"RH_allViewController"]) {
        parameters[@"type"] = @"1";
    }
   else  if ([NSStringFromClass(self.class) isEqualToString:@"RH_videoViewController"]) {
        parameters[@"type"] = @"41";
    }
    else if ([NSStringFromClass(self.class) isEqualToString:@"RH_voiceViewController"]) {
        parameters[@"type"] = @"31";
    }
   else if ([NSStringFromClass(self.class) isEqualToString:@"RH_picViewController"]) {
        parameters[@"type"] = @"10";
    }else if ([NSStringFromClass(self.class) isEqualToString:@"RH_wordViewController"]) {
        parameters[@"type"] = @"29";
    }
    self.task =  [manager GET:RH_MeUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        //存储maxtime关键字
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.ListArr  = [RH_topicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
#warning 使用afn请求数据后一定要刷新表格
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RH_Printf(@"error-------%@",error);
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ListArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RH_comonViewCell *cell = [tableView dequeueReusableCellWithIdentifier:comonID];
    cell.topicModel  = self.ListArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
#pragma mark -- 根据模型数据返回不同的高度
    RH_topicModel *model = self.ListArr[indexPath.row];
    return model.cellHeight;;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat{
    RH_commentViewController *vc = [[RH_commentViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
