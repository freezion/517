//
//  FinishCouponViewController.h
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-8.
//
//

#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"

@interface FinishCouponViewController : UIViewController <UIScrollViewDelegate, ZXingDelegate, UIAlertViewDelegate> {
    int pageTotalNum;
    NSString *camFlag;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) NSArray *contentList;
@property (nonatomic) int pageTotalNum;
@property (nonatomic, retain) NSString *camFlag;

@end
