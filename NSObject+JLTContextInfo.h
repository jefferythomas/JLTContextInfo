//
//  NSObject+JLTContextInfo.h
//  JLTContextInfoDemo
//
//  Created by Jeffery Thomas on 3/7/13.
//  Copyright (c) 2013 JLT Source. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JLTContextInfo)

- (NSMutableDictionary *)JLT_contextInfo;

#if defined(JLT_SHORTHAND)
- (NSMutableDictionary *)contextInfo;
#endif

@end
