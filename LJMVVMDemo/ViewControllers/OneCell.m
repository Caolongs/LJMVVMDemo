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
@property (weak, nonatomic) IBOutlet UIImageView *imaUrl;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@end

@implementation OneCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setModel:(OneModel *)model{
    [self.imaUrl sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
//    self.imageView.layer.cornerRadius = 10;
//    self.imageView.clipsToBounds = YES;
    
    self.imageView.backgroundColor = [UIColor redColor];
    
    self.titleLabel.text = model.title;
    self.summaryLabel.text = model.summary;
    
}

+ (id)subjectCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    return [tableView dequeueReusableCellWithIdentifier:className];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
