//
//  SwitchTabBarViewController.m
//  OrderAssistant
//
//  Created by Gong Lingxiao on 12-11-28.
//
//

#import "SwitchTabBarViewController.h"
#import "ArrResViewController.h"


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

@interface SwitchTabBarViewController ()

@end

@implementation SwitchTabBarViewController
@synthesize userEntity;
@synthesize shopCode;


- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"%@",shopCode);
    //self.navigationController.navigationBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(showActionDistance)];
    
//    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    ArrResViewController *arrResViewController = [storyborad instantiateViewControllerWithIdentifier:@"ArrResViewController"];
//    arrResViewController.shopListCode=self.shopCode;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self addCenterButtonWithImage:[UIImage imageNamed:@"517logo"] highlightImage:[UIImage imageNamed:@"517logo"]];
    //self.navigationController.navigationBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(showActionDistance)];
    
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
    //[button addTarget:self action:@selector(scanPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}
//
//- (void)scanPressed:(id)sender {
//    
//    
//    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
//    
//    NSMutableSet *readers = [[NSMutableSet alloc ] init];
//    
//#if ZXQR
//    QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
//    [readers addObject:qrcodeReader];
//    //[qrcodeReader release];
//#endif
//    
//#if ZXAZ
//    AztecReader *aztecReader = [[AztecReader alloc] init];
//    [readers addObject:aztecReader];
//    
//#endif
//    
//    widController.readers = readers;
//    
//    
//    NSBundle *mainBundle = [NSBundle mainBundle];
//    widController.soundToPlay =
//    [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
//    [self presentViewController:widController animated:YES completion:nil];
//    //[self presentModalViewController:widController animated:YES];
//}
//
//#pragma mark -
//#pragma mark ZXingDelegateMethods
//
//- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
//    //NSString *urlTitle;
//    if (self.isViewLoaded) {
//
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        NSLog(@"appcode = %@",appDelegate.appCode);
//        
//        //[WebServices getAppointmentByAppCode:appDelegate.appCode];
//        //        [WebServices getAppointments:result];
//        
//        NSString *str = [appDelegate.appCode stringByAppendingString:@","];
//        str = [str stringByAppendingString:result];
//        NSLog(@"str= %@",str);
//        [WebServices checkAppInfo:str];
//        
//    }
//
//    
//    [self dismissModalViewControllerAnimated:YES];
//    
//}
//
//- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//}



@end
