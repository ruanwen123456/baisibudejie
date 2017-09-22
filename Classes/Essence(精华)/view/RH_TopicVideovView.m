//
//  RH_TopicVideovView.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/15.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_TopicVideovView.h"
#import <UIImageView+WebCache.h>
#import "RH_topicModel.h"
#import "RH_seePictureViewController.h"
@interface RH_TopicVideovView()
@property (weak, nonatomic) IBOutlet UILabel *playTime;
@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@end
@implementation RH_TopicVideovView
-(void)awakeFromNib{
    [super awakeFromNib];
    //从xib中加载的控件autoresizingMask默认是会根据父控件自动拉伸的
    self.autoresizingMask = UIViewAutoresizingNone;
    self.videoImageView.userInteractionEnabled = YES;
    [self.videoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
}
-(void)tapClick{
    RH_func
    RH_seePictureViewController *seeViewController = [[RH_seePictureViewController alloc] init];
    seeViewController.topic = self.topicModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeViewController animated:YES completion:nil];
}
-(void)setTopicModel:(RH_topicModel *)topicModel{
    _topicModel = topicModel;
    self.playTime.text = [NSString stringWithFormat:@"%ld次播放",topicModel.playcount];
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image1]];
    NSInteger min = topicModel.videotime / 60;
    NSInteger sec  = topicModel.videotime % 60;
    self.totalTime.text = [NSString stringWithFormat:@"%02ld : %02ld",min,sec];
}
- (IBAction)playBtn:(id)sender {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
