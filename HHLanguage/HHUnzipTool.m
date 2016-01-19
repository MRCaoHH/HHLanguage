//
//  HHUnzipTool.m
//  HHLanguage
//
//  Created by caohuihui on 16/1/18.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import "HHUnzipTool.h"

@implementation HHUnzipTool

+(BOOL)unzip:(NSString *)path
{
    NSTask *task = [[NSTask alloc]init];
    task.launchPath = @"/usr/bin/unzip";
    task.arguments  = @[@"-o",path,@"-d",[self tempFilePath]];
    [task launch];
    [task waitUntilExit];
   
    return YES;
}

+(NSString *)tempFilePath
{
    NSMutableString * homeDirectory =  NSHomeDirectory().mutableCopy;
    [homeDirectory appendString:@"/unzipTemp"];
    return homeDirectory;
}

+(void)clearTempFile
{
    NSString * homeDirectory =  [self tempFilePath];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;//是否是文件夹
    BOOL isExists = [fileManager fileExistsAtPath:homeDirectory isDirectory:&isDirectory];//是否存在
    if (isExists && isDirectory) {
        [fileManager removeItemAtPath:homeDirectory error:nil];
    }
    [fileManager createDirectoryAtPath:homeDirectory withIntermediateDirectories:NO attributes:nil error:nil];
}
@end
