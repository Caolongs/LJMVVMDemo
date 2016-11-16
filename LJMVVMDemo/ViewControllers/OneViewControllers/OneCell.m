//
//  OneCell.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "OneCell.h"
#import "UIImageView+WebCache.h"

@interface OneCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgUrl;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@end

@implementation OneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(OneModel *)model{
    [self.imgUrl sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.imageView.backgroundColor = [UIColor redColor];
    
    self.titleLabel.text = model.title;
    self.summaryLabel.text = model.digest;
    
}

- (void)setNewsModel:(News *)newsModel{
    [self.imgUrl sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc]];
    self.imageView.backgroundColor = [UIColor redColor];
    
    self.titleLabel.text = newsModel.title;
    self.summaryLabel.text = newsModel.digest;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
