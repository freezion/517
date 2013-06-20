//
//  QRCodeViewController.h
//  OrderAssistant
//
//  Created by Li Feng on 13-5-9.
//
//

#import <UIKit/UIKit.h>
#import "CouponEntity.h"
#import "AppDelegate.h"
#import "ZXingWidgetController.h"

@interface QRCodeViewController : UIViewController<UIApplicationDelegate, ZXingDelegate>{
    CouponEntity *couponEntity;
    UIImageView *codeImage;
    //UILabel *sdNameLable;
    UIWebView *couponIntroWebView;
    UILabel *couponNameLable;
    NSMutableArray *couponStringArray;
    UIButton *appBtn;
    
    NSString *btnType;
}

@property (nonatomic, retain) CouponEntity *couponEntity;
@property (nonatomic, retain) IBOutlet UIImageView *codeImage;
//@property (nonatomic, retain) IBOutlet UILabel *sdNameLable;
@property (nonatomic, retain) IBOutlet UIWebView *couponIntroWebView;
@property (nonatomic, retain) IBOutlet UILabel *couponNameLable;
@property (nonatomic, retain) NSMutableArray *couponStringArray;
@property (nonatomic, retain) UIButton *appBtn;
@property (nonatomic, retain) NSString *btnType;

@end
