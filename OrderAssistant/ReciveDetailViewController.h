//
//  ReciveDetailViewController.h
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-14.
//
//

#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"
#import "CouponEntity.h"
#import "UIImageView+WebCache.h"

@interface ReciveDetailViewController : UIViewController <ZXingDelegate, UIAlertViewDelegate> {
    CouponEntity *entity;
    NSString *cCode;
    NSString *type;
    NSString *sdCode;
}

@property (nonatomic, weak) IBOutlet UIImageView *imageUrl;
@property (nonatomic, retain) IBOutlet UILabel *lblPrice;
@property (nonatomic, retain) IBOutlet UILabel *lblEventPrice;
@property (nonatomic, retain) IBOutlet UILabel *lblEventName;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIButton *btnPress;
@property (nonatomic, retain) UITextField *txtPwd;
@property (nonatomic, retain) CouponEntity *entity;
@property (nonatomic, retain) NSString *cCode;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *sdCode;

- (void)showCamera;

@end
