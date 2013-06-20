//
//  WebServices.h
//  OrderAssistant
//
//  Created by 潘 群 on 12-11-12.
//
//

#import <Foundation/Foundation.h>
#import "ResEntity.h"
#import "UserEntity.h"
#import "AppointmentModel.h"
#import "DishEntity.h"
#import "ActivityEntity.h"
#import "CouponEntity.h"
#import "CookStyleEntity.h"
#import "AreaEntity.h"
#import "DishMenu.h" 

@interface WebServices : NSObject
{
    ResEntity *resEntity;
    NSMutableArray *restaurants;
    
    UserEntity *userEntity;
    
    AppointmentModel *appointmentModel;
    NSMutableArray *registList;
    
    DishEntity *dishEntity;
    ActivityEntity *activityEntity;
    
    CouponEntity *couponEntity;

}

@property (nonatomic, retain) ResEntity *resEntity;
@property (nonatomic, retain) DishEntity *dishEntity;
@property (nonatomic, retain) ActivityEntity *activityEntity;
@property (nonatomic, retain) NSMutableArray *restaurants;
@property (nonatomic, retain) UserEntity *userEntity;
@property (nonatomic, retain) AppointmentModel *appointmentModel;
@property (nonatomic, retain) NSMutableArray *registList;
@property (nonatomic, retain) CouponEntity *couponEntity;

+(NSMutableArray *) getNearShopForIOS:(NSString *) pageNow :(NSString *) pageSize :(NSString *) lad :(NSString *)lgd :(NSString *)dis;
//+(NSMutableArray *) getNearShop;
//+(NSMutableArray *) testService;

+(UserEntity *) login:(NSString *)myPhone :(NSString *)myPassWord :(NSString *)deviceToken :(NSString *)type;
+(UserEntity *) addCustomer:(NSString *)myPhone :(NSString *)myPassWord;
+(void)resendMessage:(NSString *)myPhone;
+(NSString *)modifyCustomer:(NSString *)myCCode :(NSString *)myPhone :(NSString *)strNum;
+(NSString *)findPassword:(NSString *)myPhone;
+(NSString *)addAppointment:(NSString *)appInfo;
+(NSMutableArray *) getAppointments:(NSString *)customerCode;
+(NSMutableArray *) getShopsForIOS:(NSString *) pageNow :(NSString *) pageSize :(NSString *) code;
+(NSMutableArray *) getShopDetailInfoByIsRecommedForIOS:(NSString *) pageNow :(NSString *) pageSize;

+(NSMutableArray *) getDishInfoBySDCodeForIOS:(NSString *)pageNow :(NSString *)pageSize :(NSString *)resCode;
+(NSMutableArray *) getEventInfoBySDCode:(NSString *)resCode;
+(NSMutableArray *) getDishsByEventCode:(NSString *)evenCode;
+(NSMutableArray *) getAppointmentByAppCode:(NSString *)appointmentCode;

+(NSString *)addAppointmentForPhone:(NSString *)appInfo;

+ (void) checkAppInfo:(NSString *)Info;
//+ (void) getAppointmentByAppCode:(NSString *)code;

+ (NSMutableArray *) getCoupons;
+ (NSMutableArray *) getCouponsByType:(NSString *)type;
+ (NSMutableArray *) getFavoritesCoupons:(NSString *)couponString;
+ (NSMutableArray *) getShopsBySDName:(NSString *)sdName;
+ (void) addDeviceToken:(NSString *)deviceToken :(NSString *)type;

//获取菜系分类
+ (NSMutableArray *) getFlavorInfo;
+ (NSMutableArray *) getAreaInfo;

//组合条件查询
+ (NSMutableArray *) getShopListByPSConditionForIos:(NSString *) pageNow :(NSString *) pageSize :(NSString *)lng :(NSString *)lat :(NSString *)dis :(NSString *)flavorCode :(NSString *)areaCode;

//获取菜单分类
+ (void) getMenuInfoBySDCode:(NSString *) sdCode;
//根据menuCode获取不同类别的菜单
+ (void) getDishInfoByMenuCode:(NSString *) menuCode;

//商圈搜索，首页  万达、常发 
+ (NSMutableArray *) getShopsByArea:(NSString *)type;

//根据聚会类型搜索商家，大型宴请、小型聚会、自助餐
+ (NSMutableArray *) getShopDetailsByEtCode:(NSString *)type;

//获取版本号
+ (NSString *) getIOSUpdateVersion;


@end
