//
//  HHTool.m
//  HHLanguage
//
//  Created by caohuihui on 16/1/19.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import "HHTool.h"

@implementation HHTool

+(NSInteger)conversionInt:(NSString *)string
{
    NSInteger value = 0;
    for (int i = 0; i < string.length; i++) {
        char ch = [string characterAtIndex:string.length-1-i];
        NSInteger multiple = pow(26, i);
        value+= conversionChar(ch)*multiple;
    }
    return value;
}

int conversionChar(char ch)
{
    if (ch >= 'A' && ch <= 'Z') {
        return ch - 'A' + 1;
    }
    if (ch >= 'a' && ch <= 'z') {
        return ch - 'a'  + 1;
    }
    return 0;
}

@end
