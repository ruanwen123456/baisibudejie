//
//  RH_topicModel.h
//  RH_baisi
//
//  Created by 阮浩 on 17/9/13.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RH_commentModel;

typedef enum{
    /** 图片*/
    RH_TopicTypePicture = 10,
    /** 段子*/
    RH_TopicTypeWord = 29,
    /** 音频*/
    RH_TopicTypeVoice = 31,
    /** 视频*/
    RH_TopicTypeVideo = 41,
}RH_TopicType;
@interface RH_topicModel : NSObject

/** 用户名*/
@property (nonatomic, copy) NSString *name;
/** 头像*/
@property (nonatomic, copy) NSString *profile_image;
/** 帖子文字内容*/
@property (nonatomic, copy) NSString *text;
/** 发帖审核时间*/
@property (nonatomic, copy) NSString *created_at;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger  ding;
/** 踩得数量 */
@property (nonatomic, assign) NSUInteger  cai;
/** 转发的数量 */
@property (nonatomic, assign) NSUInteger  repost;
/** 评论数量 */
@property (nonatomic, assign) NSUInteger  comment;
/** 最热评论 */
@property (nonatomic, strong) RH_commentModel  *top_cmt;
/** 帖子类型 */
@property (nonatomic, assign) NSInteger  type;
/** cell高度 */
@property (nonatomic, assign) CGFloat  cellHeight;
/** 图片的真实高度 */
@property (nonatomic, assign) CGFloat  height;
/** 图片的真实宽度 */
@property (nonatomic, assign) CGFloat  width;
//中间内容的尺寸
@property (nonatomic, assign) CGRect  contentFrame;
/** 小图片*/
@property (nonatomic, copy) NSString *image0;
/** 原图片*/
@property (nonatomic, copy) NSString *image1;
/**中等 图片*/
@property (nonatomic, copy) NSString *image2;

/** 判断是否是大图 */
@property (nonatomic, assign,getter = isbigPicture) BOOL  bigPicture;
/** 判断是否为动态图 */
@property (nonatomic, assign) BOOL  is_gif;

/** 播放次数 */
@property (nonatomic, assign) NSInteger  playcount;
//视频播放时长
@property (nonatomic, assign) NSInteger  videotime;
//音频播放时长
@property (nonatomic, assign) NSInteger  voicetime;

/** 视屏播放地址*/
@property (nonatomic, copy) NSString *videouri;

/** 音频播放地址*/
@property (nonatomic, copy) NSString *voiceuri;
@end
