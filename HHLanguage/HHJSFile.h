//
//  HHJSFile.h
//  HHLanguage
//
//  Created by caohuihui on 16/1/12.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol HHJSFileExport <JSExport>

@property NSString * arciiString;
@property NSString * name;

-(void)ocLog:(JSValue *)value;

@end

@interface HHJSFile : NSObject<HHJSFileExport>{
    JSContext * context;
}

-(instancetype)initWithContext:(JSContext *)ctx;
@end
