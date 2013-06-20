//
//  CommonUtil.h
//  OrderAssistant
//
//  Created by flybird on 12-11-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtil : NSObject

+ (UIImage *) getImageFromURL:(NSString *)fileURL;

+ (NSArray *) getZxingCode:(NSString *)resultCode;

@end
