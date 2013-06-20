//
//  MainViewController.h
//  OrderAssistant
//
//  Created by flybird on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "PopoverView.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "ZXingWidgetController.h"
#import "IntroViewController.h"
#import "CouponSwitvhTabBarController.h"

@interface MainViewController : ViewController<UIApplicationDelegate,PopoverViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate, UITabBarControllerDelegate,ZXingDelegate, IntroViewDelegate> {
    UIButton *topButton;
    
    UIButton *bottomButton;
    UIButton *arrowButton;
    BOOL expanding;
    UILabel *menuChoiceLbl;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D curLocation;
    
    int shopCode;
    UIButton *recommendButton;  //每日推荐
    
    
    UIButton *couponButton;  //优惠券
    UIButton *exitButton;
    UIButton *searchButton;   //搜周边
    
    NSString *deviceTokenNum;
    UIButton *scanButton;   //扫一扫
    
    NSString *type;
    NSString *SDCode;
    NSString *roomCode;
    NSString *tableNum;
    
    NSArray *codeArray;
    
    UIButton *collectionButton;
    UIButton *aboutButton;
    
}
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *SDCode;
@property (nonatomic, retain) NSString *roomCode;
@property (nonatomic, retain) NSString *tableNum;
@property (nonatomic, retain) NSArray *codeArray;
@property (nonatomic, retain) IBOutlet UIButton *scanButton;
@property (nonatomic) int shopCode;
@property (nonatomic, retain) IBOutlet UIButton *recommendButton;

@property (nonatomic) BOOL expanding;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D curLocation;
@property (nonatomic, retain) IntroViewController *introViewController;

@property (nonatomic, retain) IBOutlet UIButton *couponButton;
@property (nonatomic, retain) IBOutlet UIButton *exitButton;
@property (nonatomic, retain) IBOutlet UIButton *searchButton;
@property (nonatomic, retain) NSString *deviceTokenNum;

@property (nonatomic, retain) IBOutlet UIButton *collectionButton;
@property (nonatomic, retain) IBOutlet UIButton *aboutButton;

//- (IBAction)menuButton:(id)sender;
-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender;
- (IBAction)exitBtnPress:(id)sender;
- (IBAction)showMyCollection:(id)sender;

//- (IBAction)showRecommendShopList:(id)sender;

@end
