//
//  HHBook.h
//  HHLanguage
//
//  Created by caohuihui on 16/1/19.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HHSheet;
@interface HHBook : NSObject
///字符串库
@property (nonatomic, strong) NSArray * sharedStrings;
@property (nonatomic, strong) NSArray<HHSheet *> *sheets;

-(instancetype)initWithPath:(NSString *)path;
@end
