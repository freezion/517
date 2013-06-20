//
//  GuideViewController.h
//  OrderAssistant
//
//  Created by Li Feng on 13-5-23.
//
//

#import <UIKit/UIKit.h>

@interface GuideViewController : UIViewController<UIScrollViewDelegate>{
    UIScrollView *guideScrollView;
	UIPageControl *guidePageControl;
    UIImageView *guideImageView;
    
}

@property (nonatomic, retain) IBOutlet UIScrollView *guideScrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *guidePageControl;
@property (nonatomic, retain) IBOutlet UIImageView *guideImageView;

@end
