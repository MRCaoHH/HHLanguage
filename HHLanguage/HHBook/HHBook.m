//
//  HHBook.m
//  HHLanguage
//
//  Created by caohuihui on 16/1/19.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import "HHBook.h"
#import "HHUnzipTool.h"

@interface HHBook()
{
    NSString * _filePath;
}
@end

@implementation HHBook

-(instancetype)initWithPath:(NSString *)path
{
    self = [super init];
    if (self) {
        _filePath = path;
        [self unzip];
        [self analysisSharedStringsXml];
        [self loadSheets];
    }
    return self;
}

- (void)unzip
{
    if ([HHUnzipTool unzip:_filePath]) {
        NSLog(@"解压成功");
    }else{
        NSLog(@"解压失败");
    }
}

- (void)analysisSharedStringsXml
{
    NSString * path = [NSString stringWithFormat:@"%@/xl/sharedStrings.xml",[HHUnzipTool tempFilePath]];
    NSString *xmlString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    if (xmlString) {
        NSMutableArray * mutableArr = @[].mutableCopy;
        
        NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:xmlString];
        NSArray * si = xmlDoc[@"si"];
        ///si不是一个数组的时候返回
        if (![si isKindOfClass:[NSArray class]]) {return;}
        
        for (NSDictionary * dic in si) {
            NSLog(@"%@",dic);
            NSLog(@"==============");
            NSString * text = [self analysisDic:dic];
            [mutableArr addObject:text];
        }
        _sharedStrings = mutableArr;
    }
}

- (NSString *)analysisDic:(NSDictionary *)dic{
    /**
     *  情况1:字典里面存在t键值,t里面是个字符串
     *  情况2:字典里面存在t键值,t里面是个字典
     t ={
     "__text" = "Data Statistics";
     "_xml:space" = preserve;
     }
     __text的内容是字符串
     *  情况3:字典里面只有一个键值r,且值是一个字典.则里面会存在一个t键值,解法同情况1,2
     *  情况4:字典里面只有一个键值r,且值是一个数组.则内容则是字典,字典会存在一个键值t,解法同情况1,2
     */
    
    NSMutableString * string = @"".mutableCopy;
    ///情况1,2包含键值t
    if ([[dic allKeys] containsObject:@"t"]) {
        [string appendString:[self analysisKeyTValue:dic[@"t"]]];
    }
    ///情况3,4包含键值r
    if ([[dic allKeys] containsObject:@"r"]) {
        [string appendString:[self analysisKeyRValue:dic[@"r"]]];
    }
    
    return string;
}

#pragma mark -  解析T键值
- (NSString *)analysisKeyTValue:(id)tValue{
    ///情况1,内容是字符串
    if ([tValue isKindOfClass:[NSString class]]) {
        return tValue;
    }
    ///情况2,内容是字典
    else if ([tValue isKindOfClass:[NSDictionary class]]) {
        NSDictionary * dic = tValue;
        
//        {
//            rPr =     {
//                color =         {
//                    "_indexed" = 8;
//                };
//                rFont =         {
//                    "_val" = "\U5b8b\U4f53";
//                };
//                sz =         {
//                    "_val" = 11;
//                };
//            };
//            t = "\U82f1\U8bed";
//        }

        if ([dic.allKeys containsObject:@"t"]) {
            return [self analysisKeyTValue:dic[@"t"]];
        }else if ([dic.allKeys containsObject:@"__text"]){
            NSString * __text = tValue[@"__text"];
            return __text;
        }
    }
    return @"";
}

#pragma mark -  解析R键值
- (NSString *)analysisKeyRValue:(id)rValue{
    ///情况3,内容是字典
    if ([rValue isKindOfClass:[NSDictionary class]]) {
        return [self analysisKeyTValue:rValue];
    }
    ///情况3,内容是数组
    else if ([rValue isKindOfClass:[NSArray class]]) {
        NSMutableString * string = @"".mutableCopy;
        for (NSDictionary * dic in rValue) {
            [string appendString:[self analysisKeyTValue:dic]];
        }
        return string;
    }
    return @"";
}

#pragma mark - 装载Sheets
- (void)loadSheets
{
    NSString * path = [NSString stringWithFormat:@"%@/xl/worksheets",[HHUnzipTool tempFilePath]];
    
    NSFileManager *myFileManager=[NSFileManager defaultManager];
    
    NSDirectoryEnumerator *myDirectoryEnumerator;
    
    myDirectoryEnumerator=[myFileManager enumeratorAtPath:path];
    
    //列举目录内容，可以遍历子目录
    NSString * fileName = @"";
    NSMutableArray * sheetArr = @[].mutableCopy;
    while((fileName=[myDirectoryEnumerator nextObject])!=nil)
    {
        if ([fileName hasSuffix:@".xml"]) {
            HHSheet * sheet = [[HHSheet alloc]initWithPath:[NSString stringWithFormat:@"%@/%@",path,fileName] name:[fileName stringByDeletingPathExtension]];
            [sheet loadCellText:_sharedStrings];
            [sheetArr addObject:sheet];
        }
    }
    _sheets = sheetArr;
}
@end
