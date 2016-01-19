//
//  HHJSFile.m
//  HHLanguage
//
//  Created by caohuihui on 16/1/12.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import "HHJSFile.h"

@implementation HHJSFile

@synthesize arciiString;
@synthesize name;

-(instancetype)initWithContext:(JSContext *)ctx
{
    self = [super init];
    if (self) {
        context = ctx;
        context[@"HHJSFile"] = [HHJSFile class];
    }
    return self;
}

-(void)ocLog:(JSValue *)value
{
    NSLog(@"%@",[value toNumber]);
}

@end
