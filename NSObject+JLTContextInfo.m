//
//  NSObject+JLTContextInfo.m
//  JLTContextInfoDemo
//
//  Created by Jeffery Thomas on 3/7/13.
//  Copyright (c) 2013 JLT Source. All rights reserved.
//

#import "NSObject+JLTContextInfo.h"
#import "objc/runtime.h"

@implementation NSObject (JLTContextInfo)

- (NSMutableDictionary *)JLT_contextInfo
{
    static char key;
    NSMutableDictionary *contextInfo = objc_getAssociatedObject(self, &key);
    if (!contextInfo) {
        contextInfo = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &key, contextInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return contextInfo;
}

#if defined(JLT_SHORTHAND)
- (NSMutableDictionary *)contextInfo
{
    return [self JLT_contextInfo];
}
#endif


@end
