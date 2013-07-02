//
//  ResDetailViewController.m
//  OrderAssistant
//
//  Created by flybird on 12-11-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ResDetailViewController.h"
#import "CommonUtil.h"
#import "ResIntroViewController.h"
#import "AddAppointmentViewController.h"
#import "PersonalViewController.h"
#import "MapViewController.h"
#import "BaiduMapViewController.h"
#import "DishDetailViewController.h"
#import "ActivityViewController.h"


@interface ResDetailViewController ()
@end
@implementation ResDetailViewController
{
    NSString *addAppointmentResult;
    NSString *telOne;
    NSString *telTwo;
    NSString *telThree;
}

@synthesize resEntity;
@synthesize status;
@synthesize ResNameLbl;
@synthesize ResTasteLbl;
@synthesize ResEnLbl;
@synthesize ResServeLbl;
@synthesize ResPriceLbl;
@synthesize ResStarGradeLbl;
@synthesize ResTasteTitleLbl;
@synthesize ResPriceTitleLbl;
@synthesize ResServeTitleLbl;
@synthesize ResEnTitleLbl;
@synthesize ResOrderBtn;
@synthesize ResPicBtn;
@synthesize ResImgView;
@synthesize ResStarImgView;

@synthesize ResInfoLbl;
@synthesize ResAddressLbl;
@synthesize ResTelDetailLbl;
@synthesize ResTelLbl;
@synthesize ResOtherBtn;
@synthesize ResAddDetailLbl;

@synthesize  ResCusImgLbl;
@synthesize ResCusImgDetailLbl;

@synthesize ResMistakeBtn;
@synthesize ResRoadBtn;
@synthesize ResTransportBtn;


@synthesize locationButton;
@synthesize phoneButton;
@synthesize shopActivityButton;
@synthesize shopDishButton;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [[UIImage imageNamed:@"trip_bar_right"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size: 12.0];
    [button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setShadowOffset:CGSizeMake(0, -0.25f)];
    [button setTitle:@" 地图导航" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"mealcombo_loc_icon"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showMap) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect buttonFrame = [button frame];
    buttonFrame.size.width = 70.0;
    buttonFrame.size.height = buttonImage.size.height;
    [button setFrame:buttonFrame];
    UIBarButtonItem *buttonBar = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonBar;

    ResEnTitleLbl.text=@"环境";
    ResEnLbl.text=@"3.0";
    ResPriceTitleLbl.text=@"人均消费";
    
    ResServeTitleLbl.text=@"服务";
    ResServeLbl.text=@"3.0";
    ResTasteTitleLbl.text=@"口味";
    ResTasteLbl.text=@"3.0";
    ResAddressLbl.text=@"地址：";
    ResTelLbl.text=@"电话：";
    
    ResNameLbl.text=resEntity.resNameTxt;
    
    ResImgView.image=[CommonUtil getImageFromURL:resEntity.resImg];
    
    ResStarGradeLbl.text=resEntity.ResStarGradeTxt;
    ResPriceLbl.text=resEntity.resPriceTxt;
    ResAddDetailLbl.text=resEntity.ResAddressTxt;
    ResTelDetailLbl.text=resEntity.ResTelTxt;
    
    ResInfoLbl.text=@"餐厅信息";
    ResCusImgLbl.text=@"网友印象";
    ResCusImgDetailLbl.text=@"在同价位自助中中等水平";
    ResAddressLbl.text=@"地址：";
    ResTelLbl.text=@"电话：";
    
    NSLog(@"%@",resEntity.resCode);
       
    
    [ResOrderBtn addTarget:self action:@selector(showTelOrderAction) forControlEvents:UIControlEventTouchUpInside];
//    [ResPicBtn addTarget:self action:@selector(showPictureAction) forControlEvents:UIControlEventTouchUpInside];
    [ResPicBtn addTarget:self action:@selector(showPictureAlert) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.title=resEntity.resNameTxt;
     
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)showMap
{
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    BaiduMapViewController *baiduMapViewController = [storyborad instantiateViewControllerWithIdentifier:@"BaiduMapViewController"];
    baiduMapViewController.resEntity=resEntity;
    [self.navigationController pushViewController:baiduMapViewController animated:YES];
}
- (IBAction)showMap:(id)sender{

    [self showMap];
}

- (IBAction)makePhonecall:(id)sender{
    if (resEntity.ResTelTxt==nil||[@"" isEqual:resEntity.ResTelTxt]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"该商家未提供电话预定" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        //将"/"分隔的字符串转换成数组
        NSArray*array = [resEntity.ResTelTxt componentsSeparatedByString:@"/"];
        if ([array count]==1) {
            telOne=[array objectAtIndex:0];
            telTwo=nil;
        }else if ([array count]==2){
            telOne=[array objectAtIndex:0];
            telTwo=[array objectAtIndex:1];
        }else if ([array count]==3){
            telOne=[array objectAtIndex:0];
            telTwo=[array objectAtIndex:1];
            telThree=[array objectAtIndex:2];
        }
        UIActionSheet *telActionSheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:telOne,telTwo,telThree,nil];
        telActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        telActionSheet.tag=5;
        [telActionSheet showInView:self.view.window];
    }
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ResIntro"])
    {
        ResIntroViewController *resIntroViewController = [segue destinationViewController];
        resIntroViewController.resEntity=resEntity;
    }
    if ([segue.identifier isEqualToString:@"DishDetail"]){
        
        DishDetailViewController *dishDetailViewController  = [segue destinationViewController];
        dishDetailViewController.resEntity=resEntity;
    }
    if ([segue.identifier isEqualToString:@"shopActivity"]){
        
        ActivityViewController *activityViewController  = [segue destinationViewController];
        activityViewController.resEntity=resEntity;
    }
}

//- (IBAction)showShopActivity:(id)sender{
//    [WebServices getEventInfoBySDCode:resEntity.resCode];
//}

- (void)showTelOrderAction
{
    UIActionSheet *telActionSheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"点击预定", @"电话预定", nil];
    telActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    telActionSheet.tag=1;
	[telActionSheet showInView:self.view.window];    
}

- (void)showPictureAction
{
    UIActionSheet *picActionSheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照传图", @"手机传图", nil];
	picActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    picActionSheet.tag=2;
	[picActionSheet showInView:self.view.window]; 
}
- (void)showPictureAlert
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"此功能正在开发中" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag==1) {
        if (buttonIndex == actionSheet.cancelButtonIndex) {
            return;
        }
        switch (buttonIndex) {
            case 0: {
                
                NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
                NSString *userName=[usernamepasswordKVPairs objectForKey:KEY_USERID];
                
                if (userName==nil) {
                    
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录后再操作！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
                    alert.tag=5;
                    [alert show];
                    
                }else {
                    //点击预定后进入预定信息的填写页面
                    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                    AddAppointmentViewController *addAppointmentViewController = [storyborad instantiateViewControllerWithIdentifier:@"AddAppointmentViewController"];
                    UINavigationController *navController=[[UINavigationController alloc] initWithRootViewController:addAppointmentViewController];
                    addAppointmentViewController.resEntity=resEntity;
                    addAppointmentViewController.appType=@"0";
                   NSLog(@"%@",addAppointmentViewController.appType);
                    [self presentModalViewController:navController animated:YES];
                }
                break;
            }
            case 1: {
                NSString *tel=resEntity.ResTelTxt;
                if (tel==nil||[@"" isEqual:tel]) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"该商家未提供电话预定" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    break;
                }else{
                    NSString *mess=@"确定拨打电话";
                    NSString *messages=[mess stringByAppendingString:tel];
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:messages delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alert.tag=6;
                    [alert show];
                    break;
                }
                
            }
        }
    }
    
    if (actionSheet.tag==5) {
        if (buttonIndex == actionSheet.cancelButtonIndex) {
            return;
        }
        switch (buttonIndex) {
            case 0: {
                NSString *tel=telOne;
                NSString *mess=@"tel://";
                NSString *messages=[mess stringByAppendingString:tel];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:messages]];
                
                break;
            }
            case 1:{
                NSString *tel=telTwo;
                NSString *mess=@"tel://";
                NSString *messages=[mess stringByAppendingString:tel];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:messages]];
                
                break;
            }
            case 2:{
                NSString *tel=telThree;
                NSString *mess=@"tel://";
                NSString *messages=[mess stringByAppendingString:tel];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:messages]];
                
                break;
            }
            
        }
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==5) {
        
        if (buttonIndex==1) {
            //在未登录的状态下点击预定，需要先登录
            UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            PersonalViewController *personalViewController = [storyborad instantiateViewControllerWithIdentifier:@"PersonalViewController"];
            personalViewController.delegate = self;
            UINavigationController *navPersonalViewController=[[UINavigationController alloc] initWithRootViewController:personalViewController];
            [self presentModalViewController:navPersonalViewController animated:NO];        }
    }
    if (alertView.tag==6) {
        
        if (buttonIndex==1) {
            
            NSString *tel=resEntity.ResTelTxt;
            NSString *mess=@"tel://";
            NSString *messages=[mess stringByAppendingString:tel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:messages]];
        }
    }
}
- (IBAction)showMenu:(id)sender{
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    ZxingDishViewController *zxingDishViewController= [storyborad instantiateViewControllerWithIdentifier:@"ZxingDishViewController"];
    zxingDishViewController.resEntity=self.resEntity;
    zxingDishViewController.submitType=@"1";
    [self.navigationController pushViewController:zxingDishViewController animated:YES];
}

- (void) dismissViewController:(PersonalViewController *) viewController {
    [viewController dismissModalViewControllerAnimated:YES];
    status = 1;    
}
- (void) dismissAddappointmentViewController:(AddAppointmentViewController *) viewController {
    [viewController dismissModalViewControllerAnimated:YES];
    status = 0;
}

- (void) viewDidAppear:(BOOL)animated {
    if (status == 1) {
        UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        AddAppointmentViewController *addAppointmentViewController = [storyborad instantiateViewControllerWithIdentifier:@"AddAppointmentViewController"];
        UINavigationController *navController=[[UINavigationController alloc] initWithRootViewController:addAppointmentViewController];
        addAppointmentViewController.resEntity=resEntity;
        addAppointmentViewController.appType=@"0";
        addAppointmentViewController.addAppoint_delegate = self;
        [self presentModalViewController:navController animated:YES];
    }else{
        
    }
}

@end
