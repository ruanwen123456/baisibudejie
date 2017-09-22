//
//  RH_attentionController.m
//  RH_baisi
//
//  Created by 阮浩 on 17/8/9.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_attentionController.h"
#import "RH_testViewController.h"
#import "RH_LoginViewController.h"

@interface RH_attentionController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation RH_attentionController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor cyanColor];
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightedImage:@"friendsRecommentIcon-click" target:self action:@selector(focusClick) ];
}

#pragma mark - 登录按钮实现
- (IBAction)loginButton:(id)sender {
    
    RH_LoginViewController *viewController = [[RH_LoginViewController alloc] init];
    
    [self presentViewController:viewController animated:YES completion:nil];
    
}

-(void)focusClick{
    
    [self.navigationController pushViewController:[[RH_testViewController alloc] init] animated:YES];
    
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
