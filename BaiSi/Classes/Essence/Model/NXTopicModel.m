//
//  NXTopicModel.m
//  BaiSi
//
//  Created by N-X on 2017/2/11.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXTopicModel.h"

@implementation NXTopicModel
- (CGFloat)cellHeight
{
    if (_cellHeight) {
        return _cellHeight;
    }
    //这里进行高度计算
    
    //先加上顶部的高度
    _cellHeight += 52;
    
    //计算内容label 的高度
    CGSize maxSize = CGSizeMake(SCREENW - NXMargin *2, 1300); //这里的Y 值是指最大的范围
    _cellHeight += [self.text boundingRectWithSize:maxSize options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height + NXMargin;
    if (self.type != TopicType_word) {
        //这里加上中间内容的高度
        CGFloat middleW = maxSize.width;
        //等比缩放
        CGFloat middleH = self.height * middleW / self.width ;
        
        //长图处理
        if (self.height >= SCREENH) {
            self.bigImage = YES;
            middleH = 200;
        }else
        {
            self.bigImage = NO;
        }
        
        self.middleFrame = CGRectMake(NXMargin, _cellHeight + NXMargin, middleW, middleH);
        _cellHeight += middleH + NXMargin;
    }
    //加上底部的高度
    _cellHeight += 35 + NXMargin * 2;
    return _cellHeight;

}
@end
