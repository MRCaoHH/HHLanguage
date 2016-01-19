//
//  HHSheet.m
//  HHLanguage
//
//  Created by caohuihui on 16/1/19.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import "HHSheet.h"
#import "HHUnzipTool.h"
#import "HHRow.h"
#import "HHTool.h"

@interface HHSheet ()
{
    NSString * _filePath;
}
@end

@implementation HHSheet

-(instancetype)initWithPath:(NSString *)path name:(NSString *)name{
    self = [super init];
    if (self) {
        _filePath = path;
        _name = name;
        [self analysisSheetXml];
    }
    return self;
}

#pragma mark - 解析sheetXml文件
- (void)analysisSheetXml
{
    NSString * path = _filePath;
    NSString *xmlString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    if (xmlString) {
        NSDictionary *xmlDic = [NSDictionary dictionaryWithXMLString:xmlString];
        
        ///得到开始行,结束行,开始列结束列
        NSDictionary * dimension = xmlDic[@"dimension"];
        if (dimension) {
            NSString * ref = dimension[@"_ref"];
            NSArray * arr = [ref componentsSeparatedByString:@":"];
            NSString * startString = [arr firstObject];
            NSInteger startRow = 0;
            NSInteger startColumn = 0;
            [self getRowAndColumn:startString row:&startRow column:&startColumn];
            _startRow = startRow;
            _startColumn = startColumn;
            
            NSString * endString = [arr lastObject];
            NSInteger endRow = 0;
            NSInteger endColumn = 0;
            [self getRowAndColumn:endString row:&endRow column:&endColumn];
            _endColumn = endColumn;
            _endRow = endRow;
            NSLog(@"%@",ref);
        }
        
        
        ///确定是否包含键值sheetData
        if ([xmlDic.allKeys containsObject:@"sheetData"]) {
            id sheetData = xmlDic[@"sheetData"];
            if([sheetData isKindOfClass:[NSArray class]]){
                [self analysisSheetData:sheetData];
            }
            else if ([sheetData isKindOfClass:[NSDictionary class]]){
                NSDictionary * sheetDataDic = (NSDictionary *)sheetData;
                NSArray * rowArr = sheetDataDic[@"row"];
                if ([rowArr isKindOfClass:[NSArray class]]) {
                    [self analysisSheetData:rowArr];
                }
            }
        }
    }
}

#pragma mark - 解析SheetData
- (void)analysisSheetData:(NSArray *)arr
{
    ///不是数组返回
    if (![arr isKindOfClass:[NSArray  class]]) {
        return;
    }
    
    NSMutableArray * rows = @[].mutableCopy;
    for (NSDictionary *dic in arr) {
        HHRow * row = [[HHRow alloc]initWithDic:dic];
        [rows addObject:row];
    }
    _rows = rows;
}

#pragma mark - 加载cell文本
-(void)loadCellText:(NSArray *)stringArr
{
    for (HHRow * row in _rows) {
        for (HHCell * cell in row.cells) {
            if (cell.sIndex >= 0) {
                if (cell.sIndex<[stringArr count]) {
                    cell.text = stringArr[cell.sIndex];
                }
            }
        }
    }
}

#pragma mark - 根据style输出字符串
-(NSString *)outPushWithStyle:(HHSheetOutPushStyle)style
{
    switch (style) {
        case HHSheetOutPushStyle_CSV:
            return [self getCSVString];
            break;
            
        default:
            break;
    }
    
    return @"";
}

#pragma mark - 输出CSV字符换
-(NSString *)getCSVString
{
    NSMutableString * outPush = @"".mutableCopy;
    
    for (HHRow *row in _rows) {
        NSMutableString * rowString = @"".mutableCopy;
        for (NSInteger i = self.startColumn; i<= self.endColumn; i++) {
            NSPredicate * predicate = [NSPredicate predicateWithFormat:@"column = %li",i];
            HHCell * cell = [[row.cells filteredArrayUsingPredicate:predicate] firstObject];
            if (cell) {
                [rowString appendFormat:@",%@",cell.text];
            }else{
                [rowString appendFormat:@","];
            }
        }
        [outPush appendString:rowString];
        [outPush appendString:@"\n"];
    }
    return outPush;
}

#pragma mark - 得到行和列
-(void)getRowAndColumn:(NSString *)string row:(NSInteger *)row column:(NSInteger *)column
{
    NSInteger starNum =0;//开始出现数字时的下标
    for (int i = 0; i < string.length; i++) {
        char ch = [string characterAtIndex:i];
        if (ch >= '0' && ch <= '9') {
            starNum = i;
            break;
        }
    }
    
    NSString * rowString = [string substringFromIndex:starNum];
    *row = rowString.integerValue;
    NSString * columnString = [string substringToIndex:starNum];
    *column = [HHTool conversionInt:columnString];
}
@end
