//
//  ViewController.m
//  HHLanguage
//
//  Created by caohuihui on 16/1/8.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import "ViewController.h"
#import "HHFileView.h"
#import <AppKit/AppKit.h>
#import "AppDelegate.h"
#import "TableViewController.h"
#import "HHUnzipTool.h"

@interface ViewController()<HHFileViewDelegate>
{
    
    __weak IBOutlet NSButton *button;
    __weak IBOutlet NSImageView *_imageView;
    IBOutlet HHFileView *_fileView;
    __weak IBOutlet NSTextField *_label;
    HHBook *_book;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _fileView.delegate = self;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

-(void)HHFileViewDraggingWithNames:(NSArray<NSString *> *)names
{
    for (NSString * filePath in names) {
        NSWorkspace * workspace = [NSWorkspace sharedWorkspace];
        
        NSImage * image = [workspace iconForFile:filePath];
        image.size = NSSizeFromCGSize(CGSizeMake(200,200));
        _imageView.image = image;
        _label.stringValue = filePath;
        [[NSUserDefaults standardUserDefaults]setObject:filePath forKey:kFilePathKey];
        button.enabled = YES;
        [HHUnzipTool clearTempFile];
    }

}

- (IBAction)clickButtonEvent:(id)sender {
    
    _book = [[HHBook alloc]initWithPath:[[NSUserDefaults standardUserDefaults]objectForKey:kFilePathKey]];
    
    NSStoryboard * storyBoard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    TableViewController * tableViewController = [storyBoard instantiateControllerWithIdentifier:@"TableViewController"];
    tableViewController.book = _book;
    tableViewController.preViewController = self;
    NSWindow *window = [NSApplication sharedApplication].keyWindow;
    window.contentViewController = tableViewController;
    
}

@end
