//
//  OneLiveListCellTableViewCell.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/29.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "OneLiveListCell.h"
#import "LiveListModel.h"

@interface OneLiveListCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconMovieimgView;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *userCountLabel;

@end

@implementation OneLiveListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(LiveListModel *)model{
    self.titleLabel.text = model.title;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.sourceLabel.text = model.source;
    self.tagLabel.text = model.TAG;
    if ([model.TAG isEqualToString:@"正在直播"]) {
        self.tagLabel.backgroundColor = [UIColor orangeColor];
    }else{
        self.tagLabel.backgroundColor = [UIColor lightGrayColor];
    }
    self.userCountLabel.text = [NSString stringWithFormat:@"%@人参与",model.live_info[@"user_count"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
