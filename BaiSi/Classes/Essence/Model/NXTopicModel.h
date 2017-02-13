//
//  NXTopicModel.h
//  BaiSi
//
//  Created by N-X on 2017/2/11.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  NS_ENUM(NSUInteger,TopicType){
    TopicType_all = 1,
    TopicType_video = 41,
    TopicType_voice = 31,
    TopicType_image = 10,
    TopicType_word = 29,
};

@interface NXTopicModel : NSObject
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;

/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

/*热门评论的数组*/
@property(nonatomic,copy)NSArray * top_cmtArray;
/*中间内容的宽度*/
@property (nonatomic ,assign)NSInteger width;
/*高度*/
@property (nonatomic ,assign)NSInteger height;
/*是否是gif*/
@property (nonatomic ,assign)BOOL  is_gif;
/*缩略图*/
@property(nonatomic,copy)NSString * image0;
/*大图*/
@property(nonatomic,copy)NSString * image1;
/*中图*/
@property(nonatomic,copy)NSString * image2;
/*帖子类型*/
@property(nonatomic,assign)NSUInteger type;

/*voicetime*/
@property(nonatomic,copy)NSString * voicetime;

/*playcount*/
@property(nonatomic,copy)NSString * playcount;

/*videotime*/
@property(nonatomic,copy)NSString * videotime;
/*****************自己添加的属性，根据项目需求********************/
/*cell 的高度*/
@property (nonatomic ,assign)CGFloat cellHeight;

/*middle view  的 frame */
@property (nonatomic ,assign)CGRect  middleFrame;

/*判断是否是长图*/
@property (nonatomic ,assign , getter= isBigImage)BOOL  bigImage;

@end
