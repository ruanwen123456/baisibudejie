//
//  RH_commentViewController.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/17.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_commentViewController.h"

#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "RH_topicModel.h"
#import "RH_refreshFooter.h"
static NSString * const commendcell = @"commendcell";

@interface RH_commentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tabelview;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UITextField *uitextfield;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyBoardHeight;

@property (nonatomic, strong) NSMutableArray *ListArr;
/** 下拉任务 */
@property (nonatomic, weak) NSURLSessionTask *task;
@property (nonatomic, weak) NSURLSessionTask *task2;
@end

@implementation RH_commentViewController

- (IBAction)voiceBtn:(id)sender {
    
}
- (IBAction)addBtn:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBase];
    
    //加载数据
    [self loadNewList];
    
    //刷新控件
    [self setRefresh];
    
}
-(void)loadNewList{
    //下拉刷新时取消上拉刷新功能
    [self.task2 cancel];
//    [self.tabelview.mj_header beginRefreshing];
    //发请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    
    self.task =  [manager GET:RH_MeUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
   
        
        self.ListArr  = [RH_topicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
#warning 使用afn请求数据后一定要刷新表格
        //刷新表格
        [self.tabelview reloadData];
        
        //结束刷新
        [self.tabelview.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RH_Printf(@"error-------%@",error);
        //结束刷新
        [self.tabelview.mj_header endRefreshing];
    }];
}
-(void)setRefresh{
    
    RH_refreshHeader *normalheader = [RH_refreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewList)];
    self.tabelview.mj_header = normalheader;
    
    //上拉刷新数据
    RH_refreshFooter *footer = [RH_refreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tabelview.mj_footer = footer;
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

    
    self.task2 = [manager GET:RH_MeUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
     
        
        NSMutableArray<RH_topicModel *> *listArr = [RH_topicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.ListArr addObjectsFromArray:listArr];
        
        
#warning 使用afn请求数据后一定要刷新表格
        //刷新表格
        [self.tabelview reloadData];
        
        //结束刷新
        [self.tabelview.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RH_Printf(@"error-------%@",error);
        //结束刷新
        [self.tabelview.mj_footer endRefreshing];
    }];
    
}

-(void)setBase{
    self.tabelview.backgroundColor = RH_DefaultColor;
    [self.tabelview registerClass:[UITableViewCell class] forCellReuseIdentifier:commendcell];
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor redColor];
    headerView.RH_Height = 200;
    self.tabelview.tableHeaderView = headerView;
    
    self.navigationItem.title = @"评论详情";
    //监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
#pragma mark - 监听键盘通知实现
-(void)keyBoardChange:(NSNotification *)note{
    RH_Printf(@"%@",note);
    
    CGFloat keyBoardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    self.keyBoardHeight.constant = screenH - keyBoardY;
    
    CGFloat during = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:during animations:^{
        [self.view layoutIfNeeded];
    }];
}
-(void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 数据方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }else{
        return 10;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commendcell];
        cell.textLabel.text = [NSString stringWithFormat:@"评论数据-%ld-%ld",indexPath.section,indexPath.row];
        return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"最热评论";
    }else{
        return @"最新评论";
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
//回收键盘
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
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
