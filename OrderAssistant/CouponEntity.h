//
//  CouponEntity.h
//  OrderAssistant
//
//  Created by Li Feng on 13-5-10.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "NSUtil.h"
#import "GDataXMLNode.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"


@interface CouponEntity : NSObject{
    NSString *couponCode;
    NSString *couponIntro;
    NSString *couponName;
    NSString *sdName;
    NSString *views;
    NSString *imageUrl;
    NSString *price;
    NSString *eventPrice;
    NSString *sdCode;
    NSString *eventCode;
    NSString *isUsed;
}

@property (nonatomic, retain) NSString *couponCode;
@property (nonatomic, retain) NSString *couponIntro;
@property (nonatomic, retain) NSString *couponName;
@property (nonatomic, retain) NSString *sdName;
@property (nonatomic, retain) NSString *views;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *eventPrice;
@property (nonatomic, retain) NSString *sdCode;
@property (nonatomic, retain) NSString *eventCode;
@property (nonatomic, retain) NSString *isUsed;


//+ (void)createCouponTable;
//+ (void)insertCoupon:(CouponEntity *) couponEntity;
//+ (NSMutableArray *) getAllCoupon;

+ (NSMutableArray *) getAllCouponList;

+ (NSString *) scanBarcode:(NSString *) cCode withEventCode:(NSString *) etCode withShopCode:(NSString *) sdCode withIsChange:(NSString *) flag withPwd:(NSString *) password;

+ (NSMutableArray *) getCouponListByCCode:(NSString *) cCode;
+ (NSMutableArray *) getFavoriteByCode:(NSString *) code;

@end
