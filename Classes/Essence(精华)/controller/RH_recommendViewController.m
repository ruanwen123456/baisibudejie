//
//  RH_recommendViewController.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/17.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_recommendViewController.h"
#import "RH_recommendTableViewCell.h"
#import "RH_recommendModel.h"
#import <AFNetworking.h>
#import <MJExtension.h>
static NSString *recomendID = @"recomendID";

@interface RH_recommendViewController ()
@property(nonatomic,strong)NSMutableArray *ListArr;
@end

@implementation RH_recommendViewController
-(NSMutableArray *)ListArr{
    if (_ListArr == nil) {
        _ListArr = [NSMutableArray array];
    }
    return _ListArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.autoresizingMask = NO;
    self.tableView.rowHeight = 80;
    self.navigationItem.title = @"推荐订阅频道";
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RH_recommendTableViewCell class]) bundle:nil] forCellReuseIdentifier:recomendID];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"a"] = @"tag_recommend";
    dic[@"action"] = @"sub";
    dic[@"c"] = @"topic";
    dic[@"type"] = @"1";
    [manager GET:RH_MeUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        _ListArr = [RH_recommendModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RH_Printf(@"---------%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _ListArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RH_recommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recomendID"];
    cell.recommendModel = self.ListArr[indexPath.row];
    return cell;
}


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
