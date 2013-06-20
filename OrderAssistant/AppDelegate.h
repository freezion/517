//
//  AppDelegate.h
//  OrderAssistant
//
//  Created by flybird on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import <sqlite3.h>
#import "CouponEntity.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>{
    NSString *appCode;
    NSString *shopCode;
    NSMutableArray *collectCoupons;
    
    NSString *databasePath;
    NSString *deviceTokenNum;
    //sqlite3 *hzoaDB;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSString *appCode;
@property (nonatomic, retain) NSString *shopCode;
@property (nonatomic, retain) NSMutableArray *collectCoupons;
@property (strong, nonatomic) NSString *deviceTokenNum;

@end
