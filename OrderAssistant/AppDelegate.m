//
//  AppDelegate.m
//  OrderAssistant
//
//  Created by flybird on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "BMapKit.h"
#import "GuideViewController.h"
#import "WebServices.h"


#define iphone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size): NO)

BMKMapManager *_mapManager;
@implementation AppDelegate

@synthesize window = _window;
@synthesize appCode;
@synthesize shopCode;
@synthesize collectCoupons;
@synthesize deviceTokenNum;

- (void)customizeAppearance
{
    // Create resizable images
    [[UIApplication sharedApplication] 
     setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
    
    
    UIImage *navigationBarImage = [[UIImage imageNamed:@"navigationbar_bg"] 
                                   resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    

    
    // Set the background image for *all* UINavigationBars
    [[UINavigationBar appearance] setBackgroundImage:navigationBarImage 
                                       forBarMetrics:UIBarMetricsDefault];
    
    UIImage *buttonBack30 = [[UIImage imageNamed:@"trip_bar_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack30 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIImage *tabBackground = [[UIImage imageNamed:@"mainbar_bg"]
                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UITabBar appearance] setBackgroundImage:tabBackground];
    
}

//当程序载入后最开始的时候执行
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    // Override point for customization after application launch.
    [self customizeAppearance];
    //[UserKeychain delete:KEY_USERID_CCODE];
    
    //[UserKeychain delete:KEY_USERID_CCODE];    // 要使用百度地图，请先启动BaiduMapManager
	_mapManager = [[BMKMapManager alloc]init];
	BOOL ret = [_mapManager start:@"4B5D7C0FE52C8FB8CB150868D18724C8008B5F03" generalDelegate:self];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
    
    //当前版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVer = infoDictionary[@"CFBundleVersion"];
    
    //已存版本号
    NSString *savedVerStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"SAVED_VERSION"];
    
    //版本号相等取反  即为第一次或者升级后的情况
    if (![savedVerStr isEqualToString:currentAppVer]) {
        UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        GuideViewController *guideViewController= [storyborad instantiateViewControllerWithIdentifier:@"GuideViewController"];
//        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        [self.window addSubview:guideViewController.view];
        if (iphone5) {
            guideViewController.view.frame = CGRectMake(0, 20, 320, 568);
            guideViewController.guideImageView.frame = CGRectMake(0, 0, 320, 568);
            guideViewController.guideScrollView.frame = CGRectMake(0, 0, 320, 568);
        }else{
            guideViewController.view.frame = CGRectMake(0, 20, 320, 460);
        }
        self.window.rootViewController=guideViewController;
        //保存该版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentAppVer forKey:@"SAVED_VERSION"];
    }
    
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"order.db"]];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath:databasePath] == NO)
    {
        [DishEntity createDishTable];
        [DishMenu createMenuTable];
    }
    
    return YES;
   
}

//当应用程序将要入非活动状态执行，在此期间，应用程序不接收消息或事件，比如来电话了							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// 当程序被推送到后台的时候调用。所以要设置后台继续运行，则在这个函数里面设置即可
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

//当程序从后台将要重新回到前台时候调用，这个刚好跟上面的那个方法相反。
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

// 当应用程序入活动状态执行，这个刚好跟上面2方法相反
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

//当程序将要退出是被调用，通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值。
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //[UserKeychain delete:KEY_USERID_CCODE];
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    NSString *dToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    dToken = [dToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"STR == %@",dToken);
    
    deviceTokenNum = dToken;
    //NSLog(@"%@",deviceTokenNum);
    
    [WebServices addDeviceToken:deviceTokenNum :@"2"];
    
}
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

@end
