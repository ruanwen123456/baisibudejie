//
//  RH_recommendTableViewCell.m
//  RH_baisi
//
//  Created by 阮浩 on 17/9/17.
//  Copyright © 2017年 阮浩. All rights reserved.
//

#import "RH_recommendTableViewCell.h"

#import "RH_recommendModel.h"

#import <UIImageView+WebCache.h>

@interface RH_recommendTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *recommendCount;
@property (weak, nonatomic) IBOutlet UIButton *recomBtn;

@end
@implementation RH_recommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
-(void)setRecommendModel:(RH_recommendModel *)recommendModel{
    
    
    _recommendModel = recommendModel;
    self.imageview.userInteractionEnabled = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    //请求数据
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:recommendModel.image_list] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //将请求的图片改为圆形
       self.imageview.image = [image Rh_circleImage];
        
    }];
    self.titleLabel.text = recommendModel.theme_name;
    if (recommendModel.sub_number >= 10000) {
        self.recommendCount.text = [NSString stringWithFormat:@"%.2f万人订阅", recommendModel.sub_number / 10000.0];
    }else{
        self.recommendCount.text = [NSString stringWithFormat:@"%ld人订阅", recommendModel.sub_number];
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)recomBtn:(id)sender {
}

@end
