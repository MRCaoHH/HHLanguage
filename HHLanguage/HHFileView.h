//
//  HHFileView.h
//  HHLanguage
//
//  Created by caohuihui on 16/1/11.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol HHFileViewDelegate;

@interface HHFileView : NSView
@property (nonatomic, assign) id<HHFileViewDelegate> delegate;
@end

@protocol HHFileViewDelegate <NSObject>

- (void)HHFileViewDraggingWithNames:(NSArray<NSString *> *)names;

@end