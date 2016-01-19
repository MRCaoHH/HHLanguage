//
//  HHCell.h
//  HHLanguage
//
//  Created by caohuihui on 16/1/19.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHCell : NSObject
///行
@property (nonatomic, assign) NSInteger row;
///列
@property (nonatomic, assign) NSInteger column;
///文本内容
@property (nonatomic, copy) NSString * text;
///字符串index
@property (nonatomic, assign) NSInteger sIndex;
///文本类型
@property (nonatomic, copy) NSString * textType;

-(instancetype)initWithDic:(NSDictionary *)dic row:(NSInteger)row;
@end
