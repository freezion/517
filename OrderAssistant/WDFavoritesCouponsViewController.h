//
//  WDFavoritesCouponsViewController.h
//  OrderAssistant
//
//  Created by Li Feng on 13-5-11.
//
//

#import <UIKit/UIKit.h>
#import "CouponEntity.h"
#import "FavoritesCouponsCell.h"
#import "WebServices.h"
#import "PersonalViewController.h"

@interface WDFavoritesCouponsViewController : UITableViewController<PersonalViewQRCodeDelegate>{
    NSMutableArray *couponLists;
    CouponEntity *couponEntity;
    NSString *favoritCouponStr;
    NSArray *collectCoupons;
}

@property (nonatomic, retain) NSMutableArray *couponLists;
@property (nonatomic, retain) CouponEntity *couponEntity;
@property (nonatomic, retain) NSString *favoritCouponStr;
@property (nonatomic, retain) NSArray *collectCoupons;

@end
