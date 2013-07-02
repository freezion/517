//
//  FinishCouponViewController.h
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-8.
//
//

#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"
#import "JSNotifier.h"

@interface FinishCouponViewController : UIViewController <UIScrollViewDelegate, ZXingDelegate, UIAlertViewDelegate> {
    int pageTotalNum;
    NSString *camFlag;
    UILabel *userTel;
    UILabel *scanNum;
    UIImageView *imageTel;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) NSArray *contentList;
@property (nonatomic) int pageTotalNum;
@property (nonatomic, retain) NSString *camFlag;
@property (nonatomic, retain) IBOutlet UILabel *userTel;
@property (nonatomic, retain) IBOutlet UILabel *scanNum;
@property (nonatomic, retain) IBOutlet UIImageView *imageTel;
@property (nonatomic, retain) JSNotifier *notify;
@property (nonatomic, retain) NSArray *listData;

@end
