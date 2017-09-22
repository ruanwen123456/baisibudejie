//
//  RH_comonViewCell.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/14.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_comonViewCell.h"
#import "RH_topicModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RH_commentModel.h"
#import "RH_userModel.h"
#import "RH_pictureView.h"
#import "RH_TopicVideovView.h"
#import "RH_TopicVoiceView.h"
@interface RH_comonViewCell()
//头像
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
//昵称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//更多按钮
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
//文本内容
@property (weak, nonatomic) IBOutlet UILabel *text_label;
//最热评论整体
@property (weak, nonatomic) IBOutlet UIView *hotCommentView;
//最热评论内容
@property (weak, nonatomic) IBOutlet UILabel *hotTextlabel;
//顶按钮
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
//踩按钮
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
//分享按钮
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
//评论按钮
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;


//中间控件

/** 图片控件 */
@property (nonatomic, weak) RH_pictureView *pictureview;
/** 视频控件 */
@property (nonatomic, weak) RH_TopicVideovView *videoview;
/** 声音控件 */
@property (nonatomic, weak) RH_TopicVoiceView *voiceview;
@end
@implementation RH_comonViewCell

#pragma mark - 懒加载中间的控件
-(RH_pictureView *)pictureview{
    if (!_pictureview) {
        RH_pictureView *pictureview = [RH_pictureView RH_ViewWithXib];
        [self.contentView addSubview:pictureview];
        _pictureview = pictureview;
    }
    return _pictureview;
}
-(RH_TopicVoiceView *)voiceview{
    if (!_voiceview) {
        RH_TopicVoiceView *voiceview = [RH_TopicVoiceView RH_ViewWithXib];
        [self.contentView addSubview:voiceview];
        _voiceview = voiceview;
    }
    return _voiceview;
}
-(RH_TopicVideovView *)videoview{
    if (!_videoview) {
        RH_TopicVideovView *videoview = [RH_TopicVideovView RH_ViewWithXib];
        [self.contentView addSubview:videoview];
        _videoview = videoview;
    }
    return _videoview;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
    //设置cell选中之后不变色
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
}
//赋值
-(void)setTopicModel:(RH_topicModel *)topicModel{
    _topicModel = topicModel;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.profile_image] placeholderImage:[UIImage imageNamed:@"logo"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.profileImageView.image = [image Rh_circleImage];
    }];
    self.nameLabel.text  = topicModel.name;
    self.timeLabel.text = topicModel.created_at;
    self.text_label.text  = topicModel.text;
    
    NSCalendar *calender =nil;
    if (RH_ios(8.0)) {
        calender = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    else{
        calender = [NSCalendar currentCalendar];
        
    }
    //判断一下有没有最热评论
    RH_commentModel *dic = topicModel.top_cmt;

    if (topicModel.top_cmt) {
        self.hotCommentView.hidden = NO;
        
        NSString *userName = dic.user.username
        ;
        NSString *content = dic.content;
        
        self.hotTextlabel.text = [NSString stringWithFormat:@"%@:%@",userName,content];
    }else{
        self.hotCommentView.hidden = YES;
    }
    //设置底部条
    [self setButtonTitle:topicModel.ding buttonType:self.dingBtn placeholder:@"顶"];
    [self setButtonTitle:topicModel.cai buttonType:self.caiBtn placeholder:@"踩"];
    [self setButtonTitle:topicModel.repost buttonType:self.shareBtn placeholder:@"分享"];
    [self setButtonTitle:topicModel.comment buttonType:self.commentBtn placeholder:@"评论"];
    
    
#pragma mark ---- 根据数据模型的情况决定添加什么内容
    RH_Printf(@"%ld",topicModel.type);
    NSInteger RH_type = topicModel.type;
    if (RH_type == RH_TopicTypePicture) {  //图片
        self.pictureview.hidden = NO;
        self.pictureview.frame = topicModel.contentFrame;
        self.pictureview.topicModel = topicModel;
        self.videoview.hidden = YES;
        self.voiceview.hidden = YES;
    }else if (RH_type == RH_TopicTypeWord){ //段子
        self.pictureview.hidden = YES;
        self.videoview.hidden = YES;
        self.voiceview.hidden = YES;
        
    }else if (RH_type == RH_TopicTypeVideo){ //视频
        self.videoview.topicModel = topicModel;
        self.pictureview.hidden = YES;
        self.videoview.hidden = NO;
        self.videoview.frame = topicModel.contentFrame;
        self.voiceview.hidden = YES;    }
    else if (RH_type == RH_TopicTypeVoice){ //音频
        self.voiceview.topicModel = topicModel;
        self.pictureview.hidden = YES;
        self.videoview.hidden = YES;
        self.voiceview.hidden = NO;
        self.voiceview.frame = topicModel.contentFrame;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

//更多按钮设置
- (IBAction)moreThing:(UIButton *)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RH_Printf(@"点击了收藏按钮");
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        RH_Printf(@"点击了举报按钮");
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        RH_Printf(@"点击了取消按钮");
    }]];
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
}


//重写设置cell的frame 拦截所有设置cell的frame操作
-(void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
//    frame.origin.x +=10;
//    frame.size.width -= 2*10;
    frame.origin.y += 10;
    [super setFrame:frame];
}



#pragma mark - 设置按钮数字
- (void)setButtonTitle:(NSUInteger )number buttonType:(UIButton *)buttton placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [buttton setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    }
    else if (number > 0){
        [buttton setTitle:[NSString stringWithFormat:@"%ld",number] forState:UIControlStateNormal];
    }else{
        [buttton setTitle:placeholder forState:UIControlStateNormal];
    }
}
@end
