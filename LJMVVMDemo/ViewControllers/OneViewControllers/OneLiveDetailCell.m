//
//  OneLiveDetailCell.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/10/1.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "OneLiveDetailCell.h"
#import "LiveDetailModel.h"

@interface OneLiveDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeightConstraint;

@end

@implementation OneLiveDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setMessageModel:(Live_messages *)messageModel{
    [self.iconImgView sd_setImageWithURL:messageModel.commentator[@"imgUrl"]];
    self.nameLable.text = messageModel.commentator[@"name"];
    self.timeLabel.text = [[messageModel.time componentsSeparatedByString:@" "].lastObject substringToIndex:5];
    NSDictionary *imgDict = messageModel.images.firstObject;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgDict[@"fullSizeSrc"]]];
    self.contentLabel.text = messageModel.msg[@"content"];
    
    NSString *str = imgDict[@"fullSrcSize"];
    if (str) {
        NSArray *sizeArr = [str componentsSeparatedByString:@"*"];
        CGFloat width = ((NSString *)sizeArr.firstObject).floatValue;
        CGFloat height = ((NSString *)sizeArr.lastObject).floatValue;
        self.imgHeightConstraint.constant = height*[UIScreen mainScreen].bounds.size.width/width;
    }else{
        self.imgHeightConstraint.constant = 1;
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
