//
//  RH_pictureView.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/15.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_pictureView.h"
#import <UIKit/UIKit.h>
#import "RH_topicModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking.h>
#import <DALabeledCircularProgressView.h>
#import "RH_seePictureViewController.h"
@interface RH_pictureView()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressview;

@end

@implementation RH_pictureView
-(void)awakeFromNib{
    [super awakeFromNib];
    //从xib中加载的控件autoresizingMask默认是会根据父控件自动拉伸的
    self.autoresizingMask = UIViewAutoresizingNone;
    self.progressview.roundedCorners = YES;
    self.progressview.progressLabel.textColor = [UIColor whiteColor];
    //打开图片的交互
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
}
-(void)tapClick{
    RH_seePictureViewController *seeController = [[RH_seePictureViewController alloc] init];
    seeController.topic = self.topicModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeController animated:YES completion:nil];
}
-(void)setTopicModel:(RH_topicModel *)topicModel{
    _topicModel = topicModel;
    //真机网络环境
//    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
//    switch (status) {
//        case AFNetworkReachabilityStatusReachableViaWiFi:
//            [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image1]];
//        case AFNetworkReachabilityStatusReachableViaWWAN:
//             [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image0]];
//            break;
//        default: self.imageView = nil;
//            break;
//    }
// [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image1]];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image1]placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        CGFloat progress =(1.0 * receivedSize) / expectedSize;
        self.progressview.progress = progress;
        self.progressview.hidden = NO;
        self.progressview.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress*100];
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.progressview.hidden = YES;
    } ];
    //处理gif图 将后缀全部转成小写的字母
    if (topicModel.is_gif) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
    //没被压缩的图片不隐藏 压缩的图片就隐藏
    if (topicModel.isbigPicture) {
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else{
        self.imageView.clipsToBounds = NO;
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
