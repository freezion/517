//
//  FinishDetailViewController.h
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-8.
//
//

#import <UIKit/UIKit.h>

@interface FinishDetailViewController : UIViewController {
    NSUInteger page;
    NSArray *dataList;
}

@property (nonatomic) NSUInteger page;
@property (nonatomic, retain) NSArray *dataList;

@end
