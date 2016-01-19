//
//  TableViewController.h
//  HHLanguage
//
//  Created by caohuihui on 16/1/12.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TableViewController : NSViewController
@property (nonatomic, strong) HHBook * book;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, strong) NSViewController * preViewController;
@end
