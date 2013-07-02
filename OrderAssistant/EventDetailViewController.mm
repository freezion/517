//
//  EventDetailViewController.m
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-14.
//
//

#import "EventDetailViewController.h"

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

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

@synthesize entity;
@synthesize btnType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//iphone/ZXingWidget/Classes
//cpp/core/src
// /usr/include/libxml2
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.couponStringArray = [[NSMutableArray alloc] init];
	// Do any additional setup after loading the view.
    self.navigationItem.title = entity.sdName;
    self.lblEventPrice.text = entity.eventPrice;
    self.lblEventName.text = entity.couponName;
    self.lblPrice.text = [NSString stringWithFormat:@"原价 %@ 元", entity.price];
    [self.webView loadHTMLString:entity.couponIntro baseURL:nil];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    [self hideGradientBackground:self.webView];
    [self.imageUrl setFrame:CGRectMake(0, 0, 320, 237)];
    [self.imageUrl setImageWithURL:[NSURL URLWithString:[WEBSITE_URL stringByAppendingString:entity.imageUrl]] placeholderImage:[UIImage imageNamed:@"picture_load"]];
    if (!btnType) {
        UIButton *appBtn = [UIButton buttonWithType:UIButtonTypeCustom];
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
    }
}

- (void) collectionCoupons {
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    if (self.couponStringArray != nil) {
        self.couponStringArray = [accountDefaults objectForKey:@"coupon"];
    } else {
        
    }
    BOOL isContain = [self.couponStringArray containsObject:entity.eventCode];
    if (isContain) {
        JSNotifier *notify = [[JSNotifier alloc]initWithTitle:@"该优惠券已存在于您的收藏夹！"];
        [notify showFor:2.0];
    }else{
        JSNotifier *notify = [[JSNotifier alloc]initWithTitle:@"收藏成功！"];
        notify.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NotifyCheck.png"]];
        [notify showFor:2.0];
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:self.couponStringArray];
        [tempArray addObject:entity.couponCode];
        [accountDefaults setObject:tempArray forKey:@"coupon"];
        [accountDefaults synchronize];
    }
}

- (IBAction)showCamera:(id)sender {
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
    widController.soundToPlay =
    [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
    [self presentViewController:widController animated:YES completion:nil];
}

#pragma mark ZXingDelegateMethods
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
    NSString *retVal = @"";
    if (self.isViewLoaded) {
        NSString *type = @"";
        NSString *sdCode = @"";
        NSRange range = [result rangeOfString:@"?"];
        if (range.length > 0) {
            NSString *str = [result substringFromIndex:range.location + 1];
            NSArray *val = [str componentsSeparatedByString:@","];
            type = [val objectAtIndex:0];
            if ([@"2" isEqualToString:type]) {
                for (int i = 0; i < [val count]; i ++) {
                    type = [val objectAtIndex:0];
                    sdCode = [val objectAtIndex:1];
                }
                NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
                NSString *ccode = [usernamepasswordKVPairs objectForKey:KEY_CCODE];
                retVal = [CouponEntity scanBarcode:ccode withEventCode:entity.eventCode withShopCode:sdCode withIsChange:@"" withPwd:@""];
            }
        }
    }
    [self dismissViewControllerAnimated:YES completion:^{
        if ([@"true" isEqualToString:retVal]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"使用成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"使用失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
