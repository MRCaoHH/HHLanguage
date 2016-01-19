//
//  HHRow.m
//  HHLanguage
//
//  Created by caohuihui on 16/1/19.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import "HHRow.h"
#import "HHCell.h"

@implementation HHRow
-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [self init];
    if (self) {
        _row = [dic[@"_r"] integerValue];
        
        NSMutableArray * cells = @[].mutableCopy;
        NSArray * cellsDic = dic[@"c"];
        for (NSDictionary * cellDic in cellsDic) {
            NSLog(@"%@",cellDic);
            NSLog(@"===================");
            HHCell * cell = [[HHCell alloc]initWithDic:cellDic row:_row];
            [cells addObject:cell];
        }
        _cells = cells;
    }
    return self;
}
@end
