//
//  CouponSwitvhTabBarController.m
//  OrderAssistant
//
//  Created by Li Feng on 13-5-9.
//
//

#import "CouponSwitvhTabBarController.h"
#import "WDCouponViewController.h"
#import "WDFavoritesCouponsViewController.h"

@implementation CouponSwitvhTabBarController
@synthesize collectionType;

- (void)viewDidLoad
{
    [super viewDidLoad];
//    if (self.tabBarController.selectedIndex == 0){
//        self.tabBarController.title = @"优惠券";
//    }else if (self.tabBarController.selectedIndex==1){
//        self.tabBarController.title = @"我的收藏";
//        //self.tabBarController.navigationItem.rightBarButtonItem=nil;
//    }

}


-(void)viewWillAppear:(BOOL)animated
{
    [self addCenterButtonWithImage:[UIImage imageNamed:@"517logo"] highlightImage:[UIImage imageNamed:@"517logo"]];
   
    
}

-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    UIImage *imageLight = [UIImage imageNamed:@"cam_light"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:imageLight];
    imageView.frame = CGRectMake(0.0, 0.0, imageLight.size.width, imageLight.size.height);
    if (heightDifference < 0) {
        button.center = self.tabBar.center;
        imageView.center = self.tabBar.center;
    } else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0 - 5;
        button.center = center;
        imageView.center = center;
    }
    
    [self.view addSubview:button];
    
    
}

@end
