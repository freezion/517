//
//  EventDetailViewController.h
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-14.
//
//

#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"
#import "CouponEntity.h"
#import "UIImageView+WebCache.h"
#import "JSNotifier.h"

@interface EventDetailViewController : UIViewController <ZXingDelegate> {
    CouponEntity *entity;
    NSString *btnType;
}

@property (nonatomic, weak) IBOutlet UIImageView *imageUrl;
@property (nonatomic, retain) IBOutlet UILabel *lblPrice;
@property (nonatomic, retain) IBOutlet UILabel *lblEventPrice;
@property (nonatomic, retain) IBOutlet UILabel *lblEventName;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) CouponEntity *entity;
@property (nonatomic, retain) NSString *btnType;
@property (nonatomic, retain) NSMutableArray *couponStringArray;

- (IBAction)showCamera:(id)sender;

@end
