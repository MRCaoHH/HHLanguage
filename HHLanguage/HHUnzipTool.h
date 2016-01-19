//
//  HHUnzipTool.h
//  HHLanguage
//
//  Created by caohuihui on 16/1/18.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHUnzipTool : NSObject

+(BOOL)unzip:(NSString *)path;
+(NSString *)tempFilePath;
+(void)clearTempFile;
@end
