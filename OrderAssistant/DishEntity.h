//
//  DishEntity.h
//  OrderAssistant
//
//  Created by Li Feng on 13-4-18.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "NSUtil.h"

@interface DishEntity : NSObject{
    NSString *discount;
    NSString *dishCode;
    NSString *dishName;
    NSString *dishNum;
    NSString *dishPoint;
    NSString *dishPrice;   //原价
    NSString *dishPriceS;  //优惠价
    NSString *dishScore;
    NSString *dishUnit;    //单位
    NSString *imageCode;
    NSString *imageUrl;
    NSString *isDelete;
    NSString *isDiscount;
    NSString *isDishPoint;
    NSString *isFeatureDish;  //是否是特色菜
    NSString *menuCode;
    NSString *menuName;
    NSString *num;         //数量
    NSString *pyDishName;
    NSString *shopCode;
    NSString *shopName;
    
    NSString *totalNum;
    NSString *totalPage;
}

@property (nonatomic, retain) NSString *discount;
@property (nonatomic, retain) NSString *dishCode;
@property (nonatomic, retain) NSString *dishName;
@property (nonatomic, retain) NSString *dishNum;
@property (nonatomic, retain) NSString *dishPoint;
@property (nonatomic, retain) NSString *dishPrice;
@property (nonatomic, retain) NSString *dishPriceS;
@property (nonatomic, retain) NSString *dishScore;
@property (nonatomic, retain) NSString *dishUnit;
@property (nonatomic, retain) NSString *imageCode;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *isDelete;
@property (nonatomic, retain) NSString *isDiscount;
@property (nonatomic, retain) NSString *isDishPoint;
@property (nonatomic, retain) NSString *isFeatureDish;
@property (nonatomic, retain) NSString *menuCode;
@property (nonatomic, retain) NSString *menuName;
@property (nonatomic, retain) NSString *num;
@property (nonatomic, retain) NSString *pyDishName;
@property (nonatomic, retain) NSString *shopCode;
@property (nonatomic, retain) NSString *shopName;
@property (nonatomic, retain)  NSString *totalNum;
@property (nonatomic, retain)  NSString *totalPage;

+ (void)createDishTable;
+ (void)insertDish:(DishEntity *) dishEntity;
+ (void)deleteAllDish;
+ (void)dropDishTable;
+ (NSMutableArray *) getAllDish;
+ (NSMutableArray *) selectMenuDish:(NSString *) menuCode;
+ (void)updateDish:(NSString *)dishNum :(NSString *)dishCode;
+ (NSMutableArray *) selectOrderDish;




@end
