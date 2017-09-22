//
//  RH_seePictureViewController.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/17.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_seePictureViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RH_topicModel.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <Photos/Photos.h>
@interface RH_seePictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
/** 图片控件 */
@property (nonatomic, weak) UIImageView *imageview;
@end

@implementation RH_seePictureViewController
- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveBtn:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.imageview.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
       MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:NO];
        hud.label.text = @"保存失败";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.label.text = @"正在加载图片";
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return; // 图片下载失败
        hud.hidden = YES;
        self.saveBtn.enabled = YES;
    }];
    [scrollView addSubview:imageView];
    
    imageView.RH_Width = scrollView.RH_Width;
    imageView.RH_Height = self.topic.height * imageView.RH_Width / self.topic.width;
    imageView.RH_Left = 0;
    
    if (imageView.RH_Height >= scrollView.RH_Height) { // 图片高度超过整个屏幕
        imageView.RH_Right = 0;
        // 滚动范围
        scrollView.contentSize = CGSizeMake(0, imageView.RH_Height);
    } else { // 居中显示
        imageView.RH_CenterY = scrollView.RH_Height * 0.5;
    }
    self.imageview = imageView;
    
    // 缩放比例
    CGFloat scale =  self.topic.width / imageView.RH_Width;
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
    }

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
