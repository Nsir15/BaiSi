//
//  NXSquareCell.m
//  BaiSi
//
//  Created by N-X on 2017/2/6.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXSquareCell.h"
#import <UIImageView+WebCache.h>
@interface NXSquareCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation NXSquareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(NXMeSquareModel *)model
{
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.title.text = model.name;
}
@end
