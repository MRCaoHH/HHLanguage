//
//  HHFileView.m
//  HHLanguage
//
//  Created by caohuihui on 16/1/11.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import "HHFileView.h"

@implementation HHFileView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType,
                                   nil]];
    // Drawing code here.
}

-(NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    return NSDragOperationCopy;
}

-(NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender
{
    return [self draggingEntered:sender];
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender{
    NSPasteboard * pasteboardboard = [sender draggingPasteboard];;
    
    if([[pasteboardboard types]containsObject:NSFilenamesPboardType])
    {
        if ([self.delegate respondsToSelector:@selector(HHFileViewDraggingWithNames:)]) {
            NSArray*filenames = [pasteboardboard  propertyListForType:NSFilenamesPboardType];
            [self.delegate HHFileViewDraggingWithNames:filenames];
        }
        return YES;
    }
    return NO;
}
@end
