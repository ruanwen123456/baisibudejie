//
//  RH_NewsController.m
//  RH_baisi
//
//  Created by 阮浩 on 17/8/9.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_NewsController.h"

@interface RH_NewsController ()

@end

@implementation RH_NewsController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor grayColor];
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage: [UIImage imageNamed:@"MainTitle"]]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(NewClick) ];
}
#pragma mark - 按钮实现
-(void)NewClick{
    RH_func
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
