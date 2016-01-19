//
//  HHRow.h
//  HHLanguage
//
//  Created by caohuihui on 16/1/19.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HHCell;
@interface HHRow : NSObject
///行标
@property (nonatomic, assign) NSInteger row;
///包含的内容
@property (nonatomic, strong) NSArray <HHCell *>* cells;

-(instancetype)initWithDic:(NSDictionary *)dic;
@end
