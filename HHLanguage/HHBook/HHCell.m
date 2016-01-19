//
//  HHCell.m
//  HHLanguage
//
//  Created by caohuihui on 16/1/19.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import "HHCell.h"
#import "HHTool.h"
@implementation HHCell
-(instancetype)initWithDic:(NSDictionary *)dic row:(NSInteger)row
{
    self = [super init];
    if (self) {
        _text = @"";
        _row = row;
        if ([dic.allKeys containsObject:@"v"]) {
            _sIndex = [dic[@"v"] integerValue];
        }else
        {
            _sIndex = -1;
        }
        
        NSString *  rString = [NSString stringWithFormat:@"%@",dic[@"_r"]];
        ///含有行后缀
        if([rString hasSuffix:[NSString stringWithFormat:@"%li",_row]]){
            NSString * suffix = [NSString stringWithFormat:@"%li",_row];
            rString = [rString substringToIndex:rString.length - suffix.length];
        }
        _column = [HHTool conversionInt:rString];
        _textType = [NSString stringWithFormat:@"%@",dic[@"_t"]];
    }
    return self;
}

@end
