//
//  HHSheet.h
//  HHLanguage
//
//  Created by caohuihui on 16/1/19.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,HHSheetOutPushStyle)
{
    HHSheetOutPushStyle_CSV,
//    HHSheetOutPushStyle_JSON,
//    HHSheetOutPushStyle_XML,
};

@class HHRow;
@interface HHSheet : NSObject
///开始列
@property (nonatomic, assign) NSInteger startColumn;
///结束列
@property (nonatomic, assign) NSInteger endColumn;
///开始行
@property (nonatomic, assign) NSInteger startRow;
///结束行
@property (nonatomic, assign) NSInteger endRow;
///表名
@property (nonatomic, copy) NSString * name;
///行
@property (nonatomic, strong) NSArray * rows;

/**
 *  @brief 根据文件路径初始化表格
 *
 *  @param path 文件路径
 */
-(instancetype)initWithPath:(NSString *)path name:(NSString *)name;

/**
 *  加载cell文本
 *
 *  @param stringArr 数组
 */
-(void)loadCellText:(NSArray *)stringArr;

/**
 *  根据style输出字符串类型
 *
 *  @param style 输出类型
 *
 *  @return 字符串
 */
-(NSString *)outPushWithStyle:(HHSheetOutPushStyle)style;
@end
