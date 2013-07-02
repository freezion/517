//
//  MainViewController.m
//  OrderAssistant
//
//  Created by flybird on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "PopoverView.h"
#import "MenuView.h"
#import "WebServices.h"
#import "ArrResViewController.h"
#import "PersonalViewController.h"
#import "PersonalInformationViewController.h"
#import "SwitchTabBarViewController.h"
#import "JSNotifier.h"
#import "ZxingDishViewController.h"
#import "CommonUtil.h"
#import "ShopTabViewController.h"
#import "WDCouponViewController.h"
#import "AboutViewController.h"

#ifndef ZXQR
#define ZXQR 1
#endif

#if ZXQR
#import "QRCodeReader.h"
#endif

#ifndef ZXAZ
#define ZXAZ 0
#endif

#if ZXAZ
#import "AztecReader.h"
#endif


@interface MainViewController ()
@end

@implementation MainViewController

@synthesize expanding;
@synthesize curLocation;
@synthesize locationManager;
@synthesize recommendButton;
@synthesize shopCode;
@synthesize couponButton;
@synthesize exitButton;
@synthesize searchButton;
@synthesize deviceTokenNum;
@synthesize scanButton;
@synthesize type;
@synthesize SDCode;
@synthesize roomCode;
@synthesize tableNum;
@synthesize codeArray;
@synthesize collectionButton;
@synthesize aboutButton;
@synthesize dashboardView;
@synthesize dashLogoView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([UIScreen mainScreen].bounds.size.height == 480.0) {
        [self.dashboardView setFrame:CGRectMake(10, 10, 301, 396)];
    } else {
        UIImage *buttonImage = [UIImage imageNamed:@"dash_logo.png"];
        self.dashLogoView.image = buttonImage;
        self.dashLogoView.frame = CGRectMake(10, 10, 301, 80);
        //[self.view addSubview:dashboardView];
        [self.dashboardView setFrame:CGRectMake(10, 96, 301, 396)];
    }
    
    deviceTokenNum=((AppDelegate *)[[UIApplication sharedApplication] delegate]).deviceTokenNum;

	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.topItem.title = @"唔要吃";
    UIImage *buttonImage = [[UIImage imageNamed:@"main_queryview_btn_bg.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    UIImage *buttonPressedImage = [[UIImage imageNamed:@"main_queryview_btn_bg.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    [topButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [topButton setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    CGRect buttonFrame = [topButton frame];
    buttonFrame.size.width = buttonImage.size.width + 210;
    buttonFrame.size.height = buttonImage.size.height;
    [topButton setFrame:buttonFrame];
    [bottomButton setHidden:YES];
    [arrowButton setHidden:YES];
    [menuChoiceLbl setHidden:YES];
    [self getCurPosition];
    [self locationManager];
    [self getCurVersion];
    
    [scanButton addTarget:self action:@selector(scanPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //[scanButton addTarget:self action:@selector(scanPressed2) forControlEvents:UIControlEventTouchUpInside];
   
}
//- (void)scanPressed2{
//    NSString *string=@"http://10.1.2.110:8080/phone.jsp?1,SDe04bf8bc70424b709b4d492785064986,8f49d58ee3d54242a6fb0c121e27cac8,1ｺﾅﾗﾀ";
//    codeArray=[CommonUtil getZxingCode:string];
//    for (int i = 0; i < [codeArray count]; i ++) {
//        self.type = [codeArray objectAtIndex:0];
//        self.SDCode = [codeArray objectAtIndex:1];
//        self.roomCode=[codeArray objectAtIndex:2];
//        self.tableNum=[codeArray objectAtIndex:3];
//    }
//    
//    if ([self.type isEqualToString:@"1"]) {
//        UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//        ZxingDishViewController *zxingDishViewController= [storyborad instantiateViewControllerWithIdentifier:@"ZxingDishViewController"];
//        zxingDishViewController.codeArray=self.codeArray;
//        zxingDishViewController.submitType=@"0";
//        [self.navigationController pushViewController:zxingDishViewController animated:YES];
//    }
//    self.type=@"";
//}

- (void) viewWillAppear:(BOOL)animated{
    
    if ([self.type isEqualToString:@"1"]) {
        UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        ZxingDishViewController *zxingDishViewController= [storyborad instantiateViewControllerWithIdentifier:@"ZxingDishViewController"];
        zxingDishViewController.codeArray=self.codeArray;
        zxingDishViewController.submitType=@"0";
        [self.navigationController pushViewController:zxingDishViewController animated:YES];
    }
    self.type=@"";
}
//获取最新版本号，提醒更新
- (void) getCurVersion
{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    double app_Ver=[app_Version doubleValue];
    NSString *currVersion = [WebServices getIOSUpdateVersion];
    
    if (app_Ver<[currVersion doubleValue]) {
        NSString *title=[@"发现新版本" stringByAppendingString:currVersion];
        UIAlertView *alertVersion=[[UIAlertView alloc] initWithTitle:title message:@"升级最新版本，享受更多优惠、活动全新体验！" delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"立即更新", nil];
        alertVersion.tag=1;
        [alertVersion show];
        
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        if (buttonIndex==1){
            [self goAppStore];
        }
    }
}
- (void) goAppStore{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/wu-yao-chi/id594774979?mt=8"]];
}

//获得自己的当前的位置信息
- (void) getCurPosition
{
	//开始探测自己的位置
	if (locationManager == nil)
	{
		locationManager =[[CLLocationManager alloc] init];
	}
	
	if ([CLLocationManager locationServicesEnabled])
	{
		locationManager.delegate = self;
		locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
		[locationManager startUpdatingLocation];
	}else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启唔要吃)" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
    }
}

//- (void)viewDidUnload {
//}

//响应当前位置的更新，在这里记录最新的当前位置
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
			fromLocation:(CLLocation *)oldLocation
{
    NSTimeInterval interval = [newLocation.timestamp timeIntervalSinceDate:oldLocation.timestamp];
    NSLog(@"%lf", interval);
    //保存新位置
    curLocation = newLocation.coordinate;
    if (oldLocation == nil) {
        NSString *lad=[NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
        NSString *lgd=[NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
        NSLog(@"latitude === %@", lad);
        NSLog(@"longitude === %@", lgd);
    }
}


- (IBAction)showAboutUs:(id)sender{
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    AboutViewController *aboutViewController = [storyborad instantiateViewControllerWithIdentifier:@"AboutViewController"];
    UINavigationController *navAboutViewController=[[UINavigationController alloc] initWithRootViewController:aboutViewController];
    [self presentModalViewController:navAboutViewController animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{    
    UITabBarController *tabBarController = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"Coupon"]) {
        tabBarController.title=@"优惠券";
    }else{
        tabBarController.title=@"餐厅";
    }
    tabBarController.selectedIndex = 0;
    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode=nil;
    
    if ([segue.identifier isEqualToString:@"SearchDistance"]){
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode=@"1";
    }else if ([segue.identifier isEqualToString:@"Recommond"]){
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode=nil;
    }else if ([segue.identifier isEqualToString:@"WanDa"]){
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode=@"wanda";
    }else if ([segue.identifier isEqualToString:@"ChangFa"]){
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode=@"changfa";
    }else if ([segue.identifier isEqualToString:@"Party"]){
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode=@"party";
    }else if ([segue.identifier isEqualToString:@"FriendMeeting"]){
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode=@"meeting";
    }else if ([segue.identifier isEqualToString:@"SelfService"]){
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode=@"self";
    }

 
}

- (void)scanPressed:(id)sender {
    
    
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    
    NSMutableSet *readers = [[NSMutableSet alloc ] init];
    
#if ZXQR
    QRCodeReader *qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
    //[qrcodeReader release];
#endif
    
#if ZXAZ
    AztecReader *aztecReader = [[AztecReader alloc] init];
    [readers addObject:aztecReader];
    
#endif
    
    widController.readers = readers;
    
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    widController.soundToPlay =
    [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
    [self presentViewController:widController animated:YES completion:nil];
    //[self presentModalViewController:widController animated:YES];
}

#pragma mark -
#pragma mark ZXingDelegateMethods

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
    if (self.isViewLoaded) {
    
        codeArray=[CommonUtil getZxingCode:result];
        for (int i = 0; i < [codeArray count]; i ++) {
            self.type = [codeArray objectAtIndex:0];
            self.SDCode = [codeArray objectAtIndex:1];
            self.roomCode=[codeArray objectAtIndex:2];
            self.tableNum=[codeArray objectAtIndex:3];
        }
    }
    [self dismissModalViewControllerAnimated:NO];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)shopCouponPress:(id)sender {
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
    NSString *agree = [usernamepasswordKVPairs objectForKey:KEY_AGREEMENT];
    if ([@"0" isEqualToString:agree]) {
        UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        ShopTabViewController *controller = [storyborad instantiateViewControllerWithIdentifier:@"ShopTabViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.5;
        //animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionMoveIn;
        animation.subtype = kCATransitionFromBottom;
        UIView *darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        darkView.alpha = 0.7;
        darkView.tag = 9;
        darkView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:darkView];
        
        UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        IntroViewController *controller = [storyborad instantiateViewControllerWithIdentifier:@"IntroViewController"];
        controller.view.frame = CGRectMake(0.0f, 60.0f, 320.0f, 300.0f);
        controller.view.tag = 10;
        controller.delegate = self;
        self.introViewController = controller;
        [self.view addSubview:self.introViewController.view];
        [[controller.view layer] addAnimation:animation forKey:@"animation"];
    }
}

- (void) agreeMentPress:(int) type {
    if (type == 0) {
        [[self.view viewWithTag:9] removeFromSuperview];
        [[self.view viewWithTag:10] removeFromSuperview];
        NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
        if (!usernamepasswordKVPairs) {
            usernamepasswordKVPairs = [NSMutableDictionary dictionary];
        }
        [usernamepasswordKVPairs setObject:@"0" forKey:KEY_AGREEMENT];
        [UserKeychain save:KEY_USERID_CCODE data:usernamepasswordKVPairs];
        UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        ShopTabViewController *controller = [storyborad instantiateViewControllerWithIdentifier:@"ShopTabViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        [[self.view viewWithTag:9] removeFromSuperview];
        [[self.view viewWithTag:10] removeFromSuperview];
    }
}

- (IBAction)showMyCollection:(id)sender{
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    CouponSwitvhTabBarController *couponSwitvhTabBarController = [storyborad instantiateViewControllerWithIdentifier:@"CouponSwitvhTabBarController"];
    couponSwitvhTabBarController.selectedIndex=1;
    couponSwitvhTabBarController.navigationItem.title=@"我的收藏";
    couponSwitvhTabBarController.collectionType=@"collection";
    [self.navigationController pushViewController:couponSwitvhTabBarController animated:YES];
}

//- (IBAction)showRecommendShopList:(id)sender{
//    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    ArrResViewController *arrResViewController = [storyborad instantiateViewControllerWithIdentifier:@"ArrResViewController"];
//    //arrResViewController.resEntity=resEntity;
//    [self.navigationController pushViewController:arrResViewController animated:YES];
//}
////弹出视图
//- (IBAction)menuButton:(id)sender
//{
//    float angle = self.isExpanding ? -M_PI : 0.0f;
//    [UIView animateWithDuration:0.1f animations:^{
//        arrowButton.transform = CGAffineTransformMakeRotation(angle);
//    }];
//
//    CGPoint point = CGPointMake(160.0, 360.0);
//    MenuView *menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, 280, 120)];
//    [PopoverView showPopoverAtPoint:point inView:self.view withContentView:menuView delegate:self];
//
//}
//
//- (BOOL)isExpanding
//{
//    if (expanding) {
//        expanding = NO;
//    } else {
//        expanding = YES;
//    }
//    return expanding;
//}
//
//- (void)popoverViewDidDismiss:(PopoverView *)popoverView {
//    float angle = self.isExpanding ? -M_PI : 0.0f;
//    [UIView animateWithDuration:0.1f animations:^{
//        arrowButton.transform = CGAffineTransformMakeRotation(angle);
//    }];
//}

//- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index {
//
//}


@end
