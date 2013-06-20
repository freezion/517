//
//  CommonUtil.m
//  OrderAssistant
//
//  Created by flybird on 12-11-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil

+ (UIImage *) getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[@"http://www.0519517.com" stringByAppendingString:fileURL]]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}
+ (NSArray *) getZxingCode:(NSString *)resultCode{
    NSRange range = [resultCode rangeOfString:@"?"];
    NSArray *codeArray=[[NSArray alloc] init];
    if (range.length > 0) {
        NSString *str = [resultCode substringFromIndex:range.location + 1];
        codeArray = [str componentsSeparatedByString:@","];
    }
    return codeArray;
}

@end
