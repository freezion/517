//
//  WDCouponViewController.h
//  OrderAssistant
//
//  Created by Li Feng on 13-5-9.
//
//

#import <UIKit/UIKit.h>
#import "WebServices.h"
#import "CouponEntity.h"
#import "CouponCell.h"
#import "PersonalViewController.h"
#import "EventDetailViewController.h"

@interface WDCouponViewController : UITableViewController<UITabBarControllerDelegate,UITabBarDelegate,PersonalViewQRCodeDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    NSMutableArray *couponLists;
    CouponEntity *couponEntity;
    NSArray *couArrayPicker;
    
    UIPickerView *pickerCouponKind;
    int btnChoiceRow;
}

@property (nonatomic, retain) NSMutableArray *couponLists;
@property (nonatomic, retain) CouponEntity *couponEntity;
@property (nonatomic, retain) NSArray *couArrayPicker;
@property (nonatomic, retain) UIPickerView *pickerCouponKind;
@property(nonatomic) int btnChoiceRow;


@end
