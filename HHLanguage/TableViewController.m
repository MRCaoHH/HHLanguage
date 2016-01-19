//
//  TableViewController.m
//  HHLanguage
//
//  Created by caohuihui on 16/1/12.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import "TableViewController.h"
#import "AppDelegate.h"

@interface TableViewController()
{

    NSArrayController *arrayController;
    HHSheet * _sheet;
    NSInteger _sheetIndex;
    NSInteger _rowIndex;
    NSInteger _columnIndex;
    NSArray * _rowArr;
    NSArray * _columnArr;
    NSArray * _sheetArr;
    __weak IBOutlet NSMenu *_menu;
    __weak IBOutlet NSPopUpButton *sheetButton;
    __weak IBOutlet NSPopUpButton *rowButton;
    __weak IBOutlet NSPopUpButton *columnButton;
}
@end

@implementation TableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    _sheetIndex = 0;
    _sheet = _book.sheets.firstObject;
    
    NSMutableArray * sheets = @[].mutableCopy;
    for (HHSheet * aSheet in _book.sheets) {
        [sheets addObject:aSheet.name];
    }
    _sheetArr = sheets;
    
    for (NSInteger i = 0; i< [_sheetArr count]; i++) {
        NSString *string = _sheetArr[i];
        [sheetButton.menu addItemWithTitle:[NSString stringWithFormat:@"sheet:%@",string] action:@selector(clickSheetMenuItem:) keyEquivalent:@""];
    }
    
    [self loadSheet];
    
}

-(void)loadSheet
{
    _rowIndex = 0;
    _columnIndex = 0;
    [self loadRow];
}


-(void)loadRow
{
    NSString *contents = [_sheet outPushWithStyle:HHSheetOutPushStyle_CSV];;
    _rowArr = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    [rowButton.menu removeAllItems];
    for (NSInteger i = 0; i< [_rowArr count]; i++) {
        NSString *string = _rowArr[i];
        [rowButton.menu addItemWithTitle:[NSString stringWithFormat:@"column%li:%@",i+1,string] action:@selector(clickRowMenuItem:) keyEquivalent:@""];
    }
    [self loadColumn];
}

-(void)loadColumn
{
    if (_rowIndex < [_rowArr count]) {
        _columnArr = [_rowArr[_rowIndex] componentsSeparatedByString:@","];
    }
    
    [columnButton.menu removeAllItems];
    for (NSInteger i = 0; i< [_columnArr count]; i++) {
        NSString *string = _columnArr[i];
        [_menu addItemWithTitle:[NSString stringWithFormat:@"column%li:%@",i+1,string] action:@selector(clickColumnMenuItem:) keyEquivalent:@""];
    }
}

- (IBAction)clickButton:(id)sender {
    
    NSSavePanel * savePanel = [NSSavePanel savePanel];
    [savePanel setDirectoryURL:[NSURL fileURLWithPath:@"~/Desktop"]];
    [savePanel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton)
        {
            if ([[savePanel URL] isFileURL])
            {
                NSFileManager * fileManager = [NSFileManager defaultManager];
                [fileManager createDirectoryAtURL:[savePanel URL] withIntermediateDirectories:NO attributes:nil error:nil];
                [self saveFile:savePanel.URL.path];
            }
        }
    }];
}

- (IBAction)clickBackButton:(id)sender {
    NSWindow *window = [NSApplication sharedApplication].keyWindow;
    window.contentViewController = self.preViewController;
}

#pragma mark - 选择表
-(void)clickSheetMenuItem:(NSMenuItem *)menuItem{
    _sheetIndex  = [sheetButton.menu indexOfItem:menuItem];
    _sheet = _book.sheets[_sheetIndex];
    [self loadSheet];
}

#pragma mark - 选择行
-(void)clickRowMenuItem:(NSMenuItem *)menuItem{
    _rowIndex = [rowButton.menu indexOfItem:menuItem];
    [self loadColumn];
}

#pragma mark - 选择列
-(void)clickColumnMenuItem:(NSMenuItem *)menuItem
{
    _columnIndex = [columnButton.menu indexOfItem:menuItem];

}

-(void)saveFile:(NSString *)path
{
    NSMutableArray * rowArr = _rowArr.mutableCopy;
    for (int i = 0; i <= _rowIndex; i++) {
        if ([_rowArr count] > i) {
            [rowArr removeObjectAtIndex:i];
        }
    }

    NSArray * columnArr = [[rowArr firstObject] componentsSeparatedByString:@","];

    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    ///记录有内容的列
    NSMutableDictionary * recordArr = @{}.mutableCopy;
    for (int i = 0; i<[columnArr count]; i++) {
        NSString * string = columnArr[i];
        if (string.length) {
            [recordArr setObject:string forKey:@(i)];
            NSString * filePathString = [NSString stringWithFormat:@"%@/%@",path,string];
            [fileManager createFileAtPath:filePathString contents:nil attributes:nil];
        }
    }
    
    
    
    for (NSString * rowString in rowArr) {
        
        if (![rowString length]) {
            continue;
        }
        
        NSArray * arr = [rowString componentsSeparatedByString:@","];
        if ([arr count]<_columnIndex) {
            continue;
        }
    
        NSString * key = arr[_columnIndex];
        
        for (NSNumber * number in recordArr.allKeys) {
            if ([arr count]>number.intValue) {
                NSMutableString * mutableString = [[NSMutableString alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,recordArr[number]] encoding:NSUTF8StringEncoding error:nil];
                [mutableString appendFormat:@"\n\"%@\"=\"%@\"",key,arr[number.intValue]];
                [mutableString writeToFile:[NSString stringWithFormat:@"%@/%@",path,recordArr[number]] atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
        }
    }
    
    NSString *cmdStr = [NSString stringWithFormat:@"open %@",path];
    
    system([cmdStr UTF8String]);
    

}

@end
