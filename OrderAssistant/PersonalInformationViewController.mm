//
//  PersonalInformationViewController.m
//  OrderAssistant
//
//  Created by flybird on 12-11-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "WebServices.h"
#import "PersonalViewController.h"
#import "SwitchTabBarViewController.h"
#import "AddAppointmentViewController.h"
#import "AppointmentCell.h"
#import "OrderListDetailViewController.h"


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

@interface PersonalInformationViewController ()

@end

@implementation PersonalInformationViewController

@synthesize nickName;
@synthesize devoteName;
@synthesize score;
@synthesize userEntity;
@synthesize appTableView;
@synthesize appointmentModel;
@synthesize appointmentmodel;
@synthesize appointments;
@synthesize delegate;

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
	// Do any additional setup after loading the view.
        

}



- (void)viewDidAppear:(BOOL)animated {
    
    
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
    NSString *userTel=[usernamepasswordKVPairs objectForKey:KEY_USERID];
    NSString *userPsd=[usernamepasswordKVPairs objectForKey:KEY_PASSWORD];
    NSString *deviceToken=[usernamepasswordKVPairs objectForKey:KEY_DEVICETOKEN];
    
    NSString *model = [[UIDevice currentDevice] model];
    if ([model isEqualToString:@"iPhone Simulator"]) {
        
        deviceToken = @"999";
    }
    
    NSLog(@"%@",deviceToken);
    userEntity=[WebServices login:userTel :userPsd :deviceToken :@"2"];
    
    nickName.text=userEntity.userNickName;
    devoteName.text=userEntity.userDevoteName;
    score.text=userEntity.userScore;
    
    appointments=[WebServices getAppointments:userEntity.userCCode];
    
    [self.appTableView reloadData]; 
   
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    //logout
//    UIImage *buttonImage = [[UIImage imageNamed:@"trip_bar_right"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
//    UIButton *logoutBtn=[[UIButton alloc] init];
//    [logoutBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    CGRect buttonFrame1 = [logoutBtn frame];
//    buttonFrame1.size.width = buttonImage.size.width;
//    buttonFrame1.size.height = buttonImage.size.height;
//    [logoutBtn setFrame:buttonFrame1];
//    [logoutBtn setTitle:@"注销" forState:UIControlStateNormal];
//    logoutBtn.titleLabel.font=[UIFont fontWithName:@"Kailasa" size:13];
//    [logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *logoutBarButton = [[UIBarButtonItem alloc] initWithCustomView:logoutBtn];
//    [self.navigationItem setRightBarButtonItem:logoutBarButton];
//}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//- (void)logout
//{
//    NSLog(@"jjjjjj");
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [appointments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AppointmentCell";
    AppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    appointmentModel=[self.appointments objectAtIndex:indexPath.row];   
    //点击cell按下去的状态时背景图片变换
    UIImage *selectedCell = [[UIImage imageNamed:@"lottery_cellBg_hall_focus"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 1, 5, 1)];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:selectedCell];
    
    cell.shopNameLbl.text=appointmentModel.shopName;
    
    NSString *date=appointmentModel.appTime;
    NSString *dateYear=[date substringToIndex:10];
    NSString *dateDay=[date substringWithRange:NSMakeRange(11, 8)];
    cell.appointmentTimeLbl.text=[dateYear stringByAppendingFormat:@"%@ %@",@"",dateDay];
    
    cell.appCustomerCountLbl.text=appointmentModel.appCustomerCount;
    
    if ([appointmentModel.sex isEqualToString:@"0"]) {
        cell.nameLbl.text=[appointmentModel.name stringByAppendingFormat:@"女士"];
    }else if ([appointmentModel.sex isEqualToString:@"1"]) {
        cell.nameLbl.text=[appointmentModel.name stringByAppendingFormat:@"先生"];
    }
    
    cell.appTableCountLbl.text=appointmentModel.appTableCount;
    cell.appStatusNameLbl.text=appointmentModel.appStatusName;
    
    if ([appointmentModel.appStatusName isEqualToString:@"未付款"]) {
        cell.appStatusNameLbl.textColor=[UIColor redColor];
    }else{
        cell.appStatusNameLbl.textColor=[UIColor greenColor];
    }
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //appointmentmodel =[appointments objectAtIndex:indexPath.row];
    appointmentModel=[self.appointments objectAtIndex:indexPath.row];
    NSLog(@"appcode = %@",appointmentModel.appCode);
    myDelegate.appCode = appointmentModel.appCode;
//    SwitchTabBarViewController *switchTabBarViewController = [[SwitchTabBarViewController alloc]init];
//    self.delegate = switchTabBarViewController;
//    [self.delegate getAppCode:appointmentmodel.appCode];
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    OrderListDetailViewController *orderListDetailViewController = [storyborad instantiateViewControllerWithIdentifier:@"OrderListDetailViewController"];
    orderListDetailViewController.appointmentModel=appointmentModel;
//    NSLog(@"%@",appointmentModel.appDate);
//    NSLog(@"%@",appointmentModel.appTime);
    [self.navigationController pushViewController:orderListDetailViewController animated:YES];
    
    //点击cell按下去的状态时背景图片变换，控制返回时图片恢复
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}






@end
