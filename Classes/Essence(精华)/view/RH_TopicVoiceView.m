//
//  RH_TopicVoiceView.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/15.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_TopicVoiceView.h"
#import "RH_topicModel.h"
#import <UIImageView+WebCache.h>
#import "RH_seePictureViewController.h"
@interface RH_TopicVoiceView()
@property (weak, nonatomic) IBOutlet UILabel *playTime;
@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (weak, nonatomic) IBOutlet UIButton *playVoice;
@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;

@end
@implementation RH_TopicVoiceView
-(void)awakeFromNib{
    [super awakeFromNib];
    //从xib中加载的控件autoresizingMask默认是会根据父控件自动拉伸的
    self.autoresizingMask = UIViewAutoresizingNone;
    self.voiceImageView.userInteractionEnabled = YES;
    [self.voiceImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
}
-(void)tapClick{
    RH_func
    RH_seePictureViewController *seeController = [[RH_seePictureViewController alloc] init];
    seeController.topic = self.topicModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeController animated:YES completion:nil];
}
- (IBAction)playVoice:(id)sender {
}
-(void)setTopicModel:(RH_topicModel *)topicModel{
    _topicModel = topicModel;
    [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image1]];
    
    self.playTime.text = [NSString stringWithFormat:@"%ld次播放",topicModel.playcount];
    NSInteger min = topicModel.voicetime / 60;
    NSInteger sec = topicModel.voicetime % 60;
    self.totalTime.text = [NSString stringWithFormat:@"%02ld : %02ld",min,sec];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
