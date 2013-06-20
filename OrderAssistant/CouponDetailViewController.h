//
//  CouponDetailViewController.h
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-7.
//
//

#import <UIKit/UIKit.h>

@interface CouponDetailViewController : UIViewController {
    NSUInteger page;
    NSArray *dataList;
}

@property (nonatomic) NSUInteger page;
@property (nonatomic, retain) NSArray *dataList;

@end
