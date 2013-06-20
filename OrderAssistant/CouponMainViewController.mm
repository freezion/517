//
//  CouponMainViewController.m
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-7.
//
//

#import "CouponMainViewController.h"
#import "ShopCouponModel.h"
#import "PersonalViewController.h"
#import "IntroViewController.h"

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

@interface CouponMainViewController ()

@end

@implementation CouponMainViewController

@synthesize pageTotalNum;
@synthesize camFlag;

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
    
    //    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    //    IntroViewController *controller = [storyborad instantiateViewControllerWithIdentifier:@"IntroViewController"];
    //    [self.tabBarController.navigationController presentViewController:controller animated:YES completion:nil];
    
    
	// Do any additional setup after loading the view.
    self.tabBarController.navigationItem.title = @"寻宝乐翻天";
    
    
    self.contentList = [self listToPage:[ShopCouponModel barcodeList]];
    NSUInteger numberPages = self.contentList.count;
    
    // view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < numberPages; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    // a page is the width of the scroll view
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * numberPages, 300.0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    
    self.pageControl.numberOfPages = numberPages;
    self.pageControl.currentPage = 0;
    
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    //
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}

- (void) viewDidAppear:(BOOL)animated {
    UIButton *appBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [[UIImage imageNamed:@"trip_bar_right"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    [appBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [appBtn setImage:[UIImage imageNamed:@"two_dimension_code" ] forState:UIControlStateNormal];
    CGRect appBtnFrame = [appBtn frame];
    appBtnFrame.size.width = buttonImage.size.width;
    appBtnFrame.size.height = buttonImage.size.height;
    [appBtn setFrame:appBtnFrame];
    [appBtn addTarget:self action:@selector(showCamera) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonBar = [[UIBarButtonItem alloc] initWithCustomView:appBtn];
    [self.tabBarController.navigationItem setRightBarButtonItem:buttonBar];
}

- (void) dismissSelf:(PersonalViewController *) viewController withFlag:(NSString *) flag {
    if ([@"1" isEqualToString:flag]) {
        [viewController dismissViewControllerAnimated:YES completion:^{
            [self showCamera];
        }];
        camFlag = flag;
    }
}

- (void) showCamera {
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
    NSString *userName = [usernamepasswordKVPairs objectForKey:KEY_USERID];
    if (userName) {
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
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"参加本次活动需要您是唔要吃会员，请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    } else {
        UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        PersonalViewController *personalViewController = [storyborad instantiateViewControllerWithIdentifier:@"PersonalViewController"];
        personalViewController.delegateMain = self;
        UINavigationController *navPersonalViewController=[[UINavigationController alloc] initWithRootViewController:personalViewController];
        [self presentModalViewController:navPersonalViewController animated:YES];
    }
}

- (NSMutableArray *) listToPage:(NSArray *) dataList {
    NSMutableArray *retList = [[NSMutableArray alloc] init];
    NSMutableArray *rowList = nil;
    for (int i = 0; i < [dataList count]; i ++) {
        if ((i % 9) > 0) {
            [rowList addObject:[dataList objectAtIndex:i]];
            if (i == ([dataList count] - 1)) {
                [retList addObject:rowList];
            }
        } else {
            if (i > 0) {
                [retList addObject:rowList];
            }
            rowList = [[NSMutableArray alloc] init];
            [rowList addObject:[dataList objectAtIndex:i]];
            if (i == 0) {
                [retList addObject:rowList];
            }
        }
    }
    return retList;
}

- (NSMutableArray *) listForPage:(int) pageNum {
    NSMutableArray *pageList = [[NSMutableArray alloc] init];
    int start = pageNum * 9;
    int end = (pageNum + 1) * 9;
    for (int i = start; i < end; i ++) {
        if (i <= ([self.contentList count] - 1))
            [pageList addObject:[self.contentList objectAtIndex:i]];
    }
    return pageList;
}

- (NSUInteger) getTotalPage:(NSArray *) listData {
    NSUInteger numberPages = listData.count;
    NSUInteger retNum = 0;
    
    float fltNum = numberPages / 9.0;
    int intNum = numberPages / 9.0;
    if (fltNum > intNum) {
        retNum = intNum + 1;
    } else {
        retNum = intNum;
    }
    self.pageTotalNum = retNum;
    return retNum;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // remove all the subviews from our scrollview
    for (UIView *view in self.scrollView.subviews)
    {
        [view removeFromSuperview];
    }
    
    NSUInteger numPages = self.contentList.count;
    
    // adjust the contentSize (larger or smaller) depending on the orientation
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * numPages, CGRectGetHeight(self.scrollView.frame));
    
    // clear out and reload our pages
    self.viewControllers = nil;
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < numPages; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    [self loadScrollViewWithPage:self.pageControl.currentPage - 1];
    [self loadScrollViewWithPage:self.pageControl.currentPage];
    [self loadScrollViewWithPage:self.pageControl.currentPage + 1];
    [self gotoPage:NO]; // remain at the same page (don't animate)
}

- (void)loadScrollViewWithPage:(NSUInteger)page
{
    if (page >= self.contentList.count)
        return;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    // replace the placeholder if necessary
    CouponDetailViewController *controller = [self.viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [storyboard instantiateViewControllerWithIdentifier:@"CouponDetailViewController"];
        controller.dataList = [self.contentList objectAtIndex:page];
        controller.page = page;
        [self.viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        
        [self addChildViewController:controller];
        [self.scrollView addSubview:controller.view];
        [controller didMoveToParentViewController:self];
    }
}

// at the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // a possible optimization would be to unload the views+controllers which are no longer visible
}

- (void)gotoPage:(BOOL)animated
{
    NSInteger page = self.pageControl.currentPage;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = 0;
    [self.scrollView scrollRectToVisible:bounds animated:animated];
}

- (IBAction)changePage:(id)sender
{
    [self gotoPage:YES];    // YES = animate
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark ZXingDelegateMethods

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
    NSString *retVal = @"";
    if (self.isViewLoaded) {
        NSString *type = @"";
        NSString *wandaCode = @"";
        NSRange range = [result rangeOfString:@"?"];
        if (range.length > 0) {
            NSString *str = [result substringFromIndex:range.location + 1];
            NSArray *val = [str componentsSeparatedByString:@","];
            type = [val objectAtIndex:0];
            if ([@"2" isEqualToString:type]) {
                for (int i = 0; i < [val count]; i ++) {
                    type = [val objectAtIndex:0];
                    wandaCode = [val objectAtIndex:1];
                }
                NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
                NSString *ccode = [usernamepasswordKVPairs objectForKey:KEY_CCODE];
                retVal = [ShopCouponModel scandBarcode:ccode withWandaCode:wandaCode];
            }
        }
    }
    [self dismissViewControllerAnimated:YES completion:^{
        if ([@"true" isEqualToString:retVal]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"扫码成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"扫码失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
