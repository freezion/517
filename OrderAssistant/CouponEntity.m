//
//  CouponEntity.m
//  OrderAssistant
//
//  Created by Li Feng on 13-5-10.
//
//

#import "CouponEntity.h"

@implementation CouponEntity

@synthesize couponCode;
@synthesize couponIntro;
@synthesize couponName;
@synthesize sdName;
@synthesize views;
@synthesize imageUrl;
@synthesize price;
@synthesize eventPrice;
@synthesize sdCode;
@synthesize eventCode;
@synthesize isUsed;

+ (NSMutableArray *) getAllCouponList {
    NSMutableArray *coupons = [[NSMutableArray alloc] init];
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"event"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getEventInfos xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             </getEventInfos>\
                             </soap:Body>\
                             </soap:Envelope>"];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"SOAPAction" value:@""];
    [request addRequestHeader:@"Content-Length" value:msgLength];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    //同步调用
    [request startSynchronous];
    NSData *responseData = [request responseData];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:&error];
    NSLog(@"%@", [doc rootElement]);
    
    NSArray *couponMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    
    for (GDataXMLElement *couponElement in couponMembers) {
        CouponEntity *couponEntity=[[CouponEntity alloc] init];
        //etCode
        NSArray *etCodes = [couponElement elementsForName:@"eventCode"];
        if (etCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [etCodes objectAtIndex:0];
            couponEntity.eventCode = [firstId stringValue];
        } else {
            
        }
        //sdCode
        NSArray *sdCodes = [couponElement elementsForName:@"code"];
        if (sdCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [sdCodes objectAtIndex:0];
            couponEntity.sdCode = [firstId stringValue];
        } else {
            
        }
        //eventPrice
        NSArray *eventPrices = [couponElement elementsForName:@"eventPrice"];
        if (eventPrices.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [eventPrices objectAtIndex:0];
            couponEntity.eventPrice = [firstId stringValue];
        } else {
            
        }
        //price
        NSArray *prices = [couponElement elementsForName:@"price"];
        if (prices.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [prices objectAtIndex:0];
            couponEntity.price = [firstId stringValue];
        } else {
            
        }
        //imageUrl
        NSArray *imageUrls = [couponElement elementsForName:@"imageUrl"];
        if (imageUrls.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
            couponEntity.imageUrl = [firstId stringValue];
        } else {
            
        }
        //sdName
        NSArray *sdNames = [couponElement elementsForName:@"name"];
        if (sdNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [sdNames objectAtIndex:0];
            couponEntity.sdName = [firstId stringValue];
        } else {
            
        }
        //couponName
        NSArray *couponNames = [couponElement elementsForName:@"eventName"];
        if (couponNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [couponNames objectAtIndex:0];
            couponEntity.couponName = [firstId stringValue];
        } else {
            
        }
        //eventIntro
        NSArray *eventIntros = [couponElement elementsForName:@"eventIntro"];
        if (eventIntros.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [eventIntros objectAtIndex:0];
            couponEntity.couponIntro = [firstId stringValue];
        } else {
            
        }
        couponEntity.couponCode = couponEntity.eventCode;
        [coupons addObject:couponEntity];
    }
    return coupons;
}

+ (NSString *) scanBarcode:(NSString *) cCode withEventCode:(NSString *) etCode withShopCode:(NSString *) sdCode withIsChange:(NSString *) flag withPwd:(NSString *) password {
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"customerRegister"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <useCustomerEvent xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             <arg1>%@</arg1>\
                             <arg2>%@</arg2>\
                             <arg3>%@</arg3>\
                             <arg4>%@</arg4>\
                             </useCustomerEvent>\
                             </soap:Body>\
                             </soap:Envelope>", cCode, etCode, sdCode, flag, password];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"SOAPAction" value:@""];
    [request addRequestHeader:@"Content-Length" value:msgLength];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    //同步调用
    [request startSynchronous];
    NSData *responseData = [request responseData];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:&error];
    NSLog(@"%@", [[doc rootElement] stringValue]);
    return [[doc rootElement] stringValue];
}

+ (NSMutableArray *) getCouponListByCCode:(NSString *) cCode {
    NSMutableArray *coupons = [[NSMutableArray alloc] init];
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"customerRegister"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getCustomerEvents xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </getCustomerEvents>\
                             </soap:Body>\
                             </soap:Envelope>", cCode];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"SOAPAction" value:@""];
    [request addRequestHeader:@"Content-Length" value:msgLength];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    //同步调用
    [request startSynchronous];
    NSData *responseData = [request responseData];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:&error];
    
    NSLog(@"%@", [doc rootElement]);
    NSArray *couponMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    
    for (GDataXMLElement *couponElement in couponMembers) {
        CouponEntity *couponEntity=[[CouponEntity alloc] init];
        //etCode
        NSArray *etCodes = [couponElement elementsForName:@"eventCode"];
        if (etCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [etCodes objectAtIndex:0];
            couponEntity.eventCode = [firstId stringValue];
        } else {
            
        }
        //sdCode
        NSArray *sdCodes = [couponElement elementsForName:@"code"];
        if (sdCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [sdCodes objectAtIndex:0];
            couponEntity.sdCode = [firstId stringValue];
        } else {
            
        }
        //eventPrice
        NSArray *eventPrices = [couponElement elementsForName:@"eventPrice"];
        if (eventPrices.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [eventPrices objectAtIndex:0];
            couponEntity.eventPrice = [firstId stringValue];
        } else {
            
        }
        //price
        NSArray *prices = [couponElement elementsForName:@"price"];
        if (prices.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [prices objectAtIndex:0];
            couponEntity.price = [firstId stringValue];
        } else {
            
        }
        //imageUrl
        NSArray *imageUrls = [couponElement elementsForName:@"imageUrl"];
        if (imageUrls.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
            couponEntity.imageUrl = [firstId stringValue];
        } else {
            
        }
        //sdName
        NSArray *sdNames = [couponElement elementsForName:@"name"];
        if (sdNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [sdNames objectAtIndex:0];
            couponEntity.sdName = [firstId stringValue];
        } else {
            
        }
        //couponName
        NSArray *couponNames = [couponElement elementsForName:@"eventName"];
        if (couponNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [couponNames objectAtIndex:0];
            couponEntity.couponName = [firstId stringValue];
        } else {
            
        }
        //eventIntro
        NSArray *eventIntros = [couponElement elementsForName:@"eventIntro"];
        if (eventIntros.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [eventIntros objectAtIndex:0];
            couponEntity.couponIntro = [firstId stringValue];
        } else {
            
        }
        //isUse
        NSArray *isUsies = [couponElement elementsForName:@"isUse"];
        if (isUsies.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [isUsies objectAtIndex:0];
            couponEntity.isUsed = [firstId stringValue];
        } else {
            
        }
        couponEntity.couponCode = couponEntity.eventCode;
        [coupons addObject:couponEntity];
    }
    return coupons;
}

+ (NSMutableArray *) getFavoriteByCode:(NSString *) code {
    NSMutableArray *coupons = [[NSMutableArray alloc] init];
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"coupon"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getFavoritesCoupons xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </getFavoritesCoupons>\
                             </soap:Body>\
                             </soap:Envelope>", code];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"SOAPAction" value:@""];
    [request addRequestHeader:@"Content-Length" value:msgLength];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    //同步调用
    [request startSynchronous];
    NSData *responseData = [request responseData];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:&error];
    
    //NSLog(@"%@", [doc rootElement]);
    NSArray *couponMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    
    for (GDataXMLElement *couponElement in couponMembers) {
        CouponEntity *couponEntity=[[CouponEntity alloc] init];
        //etCode
        NSArray *etCodes = [couponElement elementsForName:@"eventCode"];
        if (etCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [etCodes objectAtIndex:0];
            couponEntity.eventCode = [firstId stringValue];
        } else {
            
        }
        //sdCode
        NSArray *sdCodes = [couponElement elementsForName:@"code"];
        if (sdCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [sdCodes objectAtIndex:0];
            couponEntity.sdCode = [firstId stringValue];
        } else {
            
        }
        //eventPrice
        NSArray *eventPrices = [couponElement elementsForName:@"eventPrice"];
        if (eventPrices.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [eventPrices objectAtIndex:0];
            couponEntity.eventPrice = [firstId stringValue];
        } else {
            
        }
        //price
        NSArray *prices = [couponElement elementsForName:@"price"];
        if (prices.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [prices objectAtIndex:0];
            couponEntity.price = [firstId stringValue];
        } else {
            
        }
        //imageUrl
        NSArray *imageUrls = [couponElement elementsForName:@"imageUrl"];
        if (imageUrls.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
            couponEntity.imageUrl = [firstId stringValue];
        } else {
            
        }
        //sdName
        NSArray *sdNames = [couponElement elementsForName:@"name"];
        if (sdNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [sdNames objectAtIndex:0];
            couponEntity.sdName = [firstId stringValue];
        } else {
            
        }
        //couponName
        NSArray *couponNames = [couponElement elementsForName:@"eventName"];
        if (couponNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [couponNames objectAtIndex:0];
            couponEntity.couponName = [firstId stringValue];
        } else {
            
        }
        //eventIntro
        NSArray *eventIntros = [couponElement elementsForName:@"eventIntro"];
        if (eventIntros.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [eventIntros objectAtIndex:0];
            couponEntity.couponIntro = [firstId stringValue];
        } else {
            
        }
        couponEntity.couponCode = couponEntity.eventCode;
        [coupons addObject:couponEntity];
    }
    return coupons;
}

//+ (void)createCouponTable{
//    NSString *databasePath = [NSUtil getDBPath];
//    sqlite3 *hzoaDB;
//    const char *dbpath = [databasePath UTF8String];
//
//    if (sqlite3_open(dbpath, &hzoaDB)==SQLITE_OK)
//    {
//        char *errMsg;
//        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS COUPON(ID VARCHAR(20) PRIMARY KEY, NAME TEXT, CODE TEXT);";
//        if (sqlite3_exec(hzoaDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK) {
//            NSLog(@"create failed!\n");
//        }
//    }
//    else
//    {
//        NSLog(@"创建/打开数据库失败");
//    }
//}

//+ (void)insertCoupon:(CouponEntity *) couponEntity{
//    NSString *databasePath = [NSUtil getDBPath];
//    sqlite3 *hzoaDB;
//    sqlite3_stmt *statement;
//    const char *dbpath = [databasePath UTF8String];
//
//    if (sqlite3_open(dbpath, &hzoaDB)==SQLITE_OK) {
//        NSString *couponCode = couponEntity.couponCode;
//        NSString *couponName = couponEntity.couponName;
//
//
//        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO COUPON VALUES(\"%@\",\"%@\")", couponName,couponCode];
//
//        const char *insert_stmt = [insertSQL UTF8String];
//        sqlite3_prepare_v2(hzoaDB, insert_stmt, -1, &statement, NULL);
//        if (sqlite3_step(statement) == SQLITE_DONE) {
//
//        }
//        sqlite3_finalize(statement);
//        sqlite3_close(hzoaDB);
//    }
//}
//
//+ (NSMutableArray *) getAllCoupon{
//    NSMutableArray *couponList = [[NSMutableArray alloc] initWithCapacity:0];
//    NSString *databasePath = [NSUtil getDBPath];
//    sqlite3 *hzoaDB;
//    const char *dbpath = [databasePath UTF8String];
//    sqlite3_stmt *statement;
//
//    if (sqlite3_open(dbpath, &hzoaDB) == SQLITE_OK)
//    {
//        NSString *querySQL = @"SELECT * FROM COUPON;";
//        const char *query_stmt = [querySQL UTF8String];
//        if (sqlite3_prepare_v2(hzoaDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
//        {
//            while (sqlite3_step(statement) == SQLITE_ROW)
//            {
//                CouponEntity *couponEntity = [[CouponEntity alloc] init];
//                // id
//                NSString *nameField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
//                couponEntity.couponName = nameField;
//                // name
//                NSString *codeField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
//                couponEntity.couponCode = codeField;
//                [couponList addObject:couponEntity];
//            }
//            sqlite3_finalize(statement);
//        }
//
//        sqlite3_close(hzoaDB);
//    }
//
//    return couponList;
//}

@end
