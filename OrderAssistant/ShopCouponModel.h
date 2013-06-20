//
//  ShopCouponModel.h
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-8.
//
//

#import <Foundation/Foundation.h>

@interface ShopCouponModel : NSObject {
    NSString *wandaCode;
    NSString *imageUrl;
    NSString *viewCount;
    NSString *time;
}

@property (nonatomic, retain) NSString *wandaCode;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *viewCount;
@property (nonatomic, retain) NSString *time;

+ (NSArray *) barcodeList;
+ (NSArray *) scandList:(NSString *) code;

+ (NSString *) scandBarcode:(NSString *) cCode withWandaCode:(NSString *) wandaCode;

@end
