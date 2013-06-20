//
//  ReciveDetailViewController.m
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-14.
//
//

#import "ReciveDetailViewController.h"

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

@interface ReciveDetailViewController ()

@end

@implementation ReciveDetailViewController

@synthesize entity;
@synthesize btnPress;
@synthesize cCode;
@synthesize type;
@synthesize sdCode;

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    if (entity.imageUrl) {
        [self.imageUrl setImageWithURL:[NSURL URLWithString:[WEBSITE_URL stringByAppendingString:entity.imageUrl]] placeholderImage:[UIImage imageNamed:@"picture_load"]];
    } else {
        [self.imageUrl setImageWithURL:[NSURL URLWithString:[WEBSITE_URL stringByAppendingString:@"picture_load"]] placeholderImage:[UIImage imageNamed:@"picture_load"]];
    }

    if ([@"0" isEqualToString:entity.isUsed]) {
        [self.btnPress setTitle:@"立即使用" forState:UIControlStateNormal];
        [self.btnPress setBackgroundImage:[UIImage imageNamed:@"sns_follow_button"] forState:UIControlStateNormal];
        [self.btnPress addTarget:self action:@selector(showCamera) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.btnPress setTitle:@"已使用" forState:UIControlStateNormal];
        [self.btnPress setBackgroundImage:[UIImage imageNamed:@"defaultButton"] forState:UIControlStateNormal];
    }
}

- (void)showCamera {
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
    cCode = @"";
    if (self.isViewLoaded) {
        type = @"";
        sdCode = @"";
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
                cCode = [usernamepasswordKVPairs objectForKey:KEY_CCODE];
                //retVal = [CouponEntity scanBarcode:ccode withEventCode:entity.eventCode withShopCode:sdCode withIsChange:@"1"];
            }
        }
    }
    [self dismissViewControllerAnimated:YES completion:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"输入密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"使用", nil];
        alert.tag = 2;
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        self.txtPwd = [alert textFieldAtIndex:0];
        self.txtPwd.placeholder = @"输入密码";
        self.txtPwd.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        self.txtPwd.secureTextEntry = YES;
        [alert show];
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *retVal = @"";
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        if (alertView.tag == 2) {
            retVal = [CouponEntity scanBarcode:cCode withEventCode:entity.eventCode withShopCode:sdCode withIsChange:@"1" withPwd:self.txtPwd.text];
            if ([@"true" isEqualToString:retVal]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"消费成功" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [alert show];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"消费失败" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
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
