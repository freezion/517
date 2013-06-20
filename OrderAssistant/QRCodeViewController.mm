//
//  QRCodeViewController.m
//  OrderAssistant
//
//  Created by Li Feng on 13-5-9.
//
//

#import "QRCodeViewController.h"
#import "QRCodeGenerator.h"
#import "WDFavoritesCouponsViewController.h"
#import "JSNotifier.h"

@implementation QRCodeViewController
@synthesize couponEntity;
@synthesize codeImage;
//@synthesize sdNameLable;
@synthesize couponIntroWebView;
@synthesize couponNameLable;
@synthesize couponStringArray;
@synthesize appBtn;
@synthesize btnType;

- (void) viewDidLoad{
    [super viewDidLoad];
    
    couponStringArray=[[NSMutableArray alloc] init];
    self.navigationItem.title=couponEntity.sdName;
    //sdNameLable.text=couponEntity.sdName;
    couponNameLable.text=couponEntity.couponName;
    [couponIntroWebView loadHTMLString:couponEntity.couponIntro baseURL:nil];
    [couponIntroWebView setBackgroundColor:[UIColor clearColor]];
    [couponIntroWebView setOpaque:NO];
    [self hideGradientBackground:couponIntroWebView];
    
    NSString *qrCodeStr=couponEntity.couponCode;
    NSLog(@"%@",couponEntity.couponCode);
    //UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 300, 300)];
	codeImage.image = [QRCodeGenerator qrImageForString:qrCodeStr imageSize:codeImage.bounds.size.width];
	[self.view addSubview: codeImage];
    
    if ([btnType isEqualToString:@"1"]) {
        appBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *buttonImage = [[UIImage imageNamed:@"trip_bar_right"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        [appBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [appBtn setTitle:@"收藏" forState:UIControlStateNormal];
        appBtn.titleLabel.font=[UIFont fontWithName:@"Kailasa" size:13];
        CGRect appBtnFrame = [appBtn frame];
        appBtnFrame.size.width = buttonImage.size.width;
        appBtnFrame.size.height = buttonImage.size.height;
        [appBtn setFrame:appBtnFrame];
        [appBtn addTarget:self action:@selector(collectionCoupons) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *buttonBar = [[UIBarButtonItem alloc] initWithCustomView:appBtn];
        self.navigationItem.rightBarButtonItem = buttonBar;
    }else{
        
    }
    
    
}

- (void) showCamera {
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    NSMutableSet *readers = [[NSMutableSet alloc ] init];
    
#if ZXQR
    QRCodeReader *qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
#endif
    
#if ZXAZ
    AztecReader *aztecReader = [[AztecReader alloc] init];
    [readers addObject:aztecReader];
    
#endif
    widController.readers = readers;
    NSBundle *mainBundle = [NSBundle mainBundle];
    widController.soundToPlay = [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
    [self presentViewController:widController animated:YES completion:nil];
}

- (void) collectionCoupons{
    
    //    JSNotifier *notify = [[JSNotifier alloc]initWithTitle:@"已成功添加至您的收藏列表"];
    //    notify.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NotifyCheck.png"]];
    //    [notify showFor:2.0];
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    if (couponStringArray!=nil) {
        couponStringArray=[accountDefaults objectForKey:@"coupon"];
    }else{
        
    }
    
    BOOL isContain=[couponStringArray containsObject:couponEntity.couponCode];
    if (isContain) {
        JSNotifier *notify = [[JSNotifier alloc]initWithTitle:@"该优惠券已存在于您的收藏夹！"];
        [notify showFor:2.0];
    }else{
        JSNotifier *notify = [[JSNotifier alloc]initWithTitle:@"收藏成功！"];
        notify.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NotifyCheck.png"]];
        [notify showFor:2.0];
        NSMutableArray *tempArray=[[NSMutableArray alloc] initWithArray:couponStringArray];
        [tempArray addObject:couponEntity.couponCode];
        [accountDefaults setObject:tempArray forKey:@"coupon"];
        [accountDefaults synchronize];
    }
    
    
    
    
    
    //    couponString=@"sssss";
    //    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    //    WDFavoritesCouponsViewController *favoritesCouponsViewController = [storyborad instantiateViewControllerWithIdentifier:@"WDFavoritesCouponsViewController"];
    //    favoritesCouponsViewController.favoritCouponStr=couponString;
    
    //    [((AppDelegate *)[[UIApplication sharedApplication] delegate]).collectCoupons addObject:couponEntity.couponCode];
    //    NSLog(@"%d",[((AppDelegate *)[[UIApplication sharedApplication] delegate]).collectCoupons count]);
}

- (void) hideGradientBackground:(UIView*)theView
{
    for (UIView * subview in theView.subviews)
    {
        if ([subview isKindOfClass:[UIImageView class]])
            subview.hidden = YES;
        
        [self hideGradientBackground:subview];
    }
}

#pragma mark -
#pragma mark ZXingDelegateMethods

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
    //    if (self.isViewLoaded) {
    //
    //        retVal = [ShopCouponModel scandBarcode:ccode withWandaCode:wandaCode];
    //    }
    //    [self dismissViewControllerAnimated:YES completion:^{
    //        if ([@"true" isEqualToString:retVal]) {
    //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"使用成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //            [alert show];
    //        }
    //
    //    }];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
