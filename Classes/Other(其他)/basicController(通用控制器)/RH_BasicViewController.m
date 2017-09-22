//
//  RH_LoginViewController.m
//  RH_baisi
//
//  Created by 阮浩 on 17/8/31.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_LoginViewController.h"

@interface RH_LoginViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMar;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;


@end

@implementation RH_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}


/**
 控制状态栏的颜色
 */
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)backButtonClick:(id)sender {
      [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registButton:(UIButton *)button {
    //退出键盘
    [self.view endEditing:YES];
    //设置frame
    if (self.leftMar.constant) { //注册界面 再次点击偏移清零
        [button setTitle:@"注册帐号" forState:UIControlStateNormal];
        self.leftMar.constant = 0;
    }
    else{ //登录界面 点击进行偏移到注册界面
        [button setTitle:@"已有帐号？" forState:UIControlStateNormal];

        self.leftMar.constant = -self.view.RH_Width;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}
#pragma mark - 退出键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
