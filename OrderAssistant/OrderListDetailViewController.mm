//
//  OrderListDetailViewController.m
//  OrderAssistant
//
//  Created by Li Feng on 13-4-23.
//
//

#import "OrderListDetailViewController.h"
#import "UIImageView+WebCache.h"
//#import <QRCodeReader.h>

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

@implementation OrderListDetailViewController

@synthesize shopName;
@synthesize arriveDate;
@synthesize arriveTime;
@synthesize customerNum;
@synthesize tableNum;
@synthesize isPark;
@synthesize isProxyDrive;
@synthesize isRoom;
@synthesize appStatus;
@synthesize statusDetail;

@synthesize appointmentModel;
@synthesize appointments;
@synthesize dishEntity;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title=@"订单详情";
    
    UIButton *appBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [[UIImage imageNamed:@"trip_bar_right"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    [appBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [appBtn setTitle:@"扫描" forState:UIControlStateNormal];
    appBtn.titleLabel.font=[UIFont fontWithName:@"Kailasa" size:13];
    CGRect appBtnFrame = [appBtn frame];
    appBtnFrame.size.width = buttonImage.size.width;
    appBtnFrame.size.height = buttonImage.size.height;
    [appBtn setFrame:appBtnFrame];
    [appBtn addTarget:self action:@selector(scanPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonBar = [[UIBarButtonItem alloc] initWithCustomView:appBtn];
    self.navigationItem.rightBarButtonItem = buttonBar;
    
    
    NSString *date=appointmentModel.appDate;
    NSString *dateYear=[date substringToIndex:10];
    NSString *dateDay=[date substringWithRange:NSMakeRange(11, 5)];
    
    shopName.text=appointmentModel.shopName;
    arriveDate.text=dateYear;
    arriveTime.text=dateDay;
    customerNum.text=appointmentModel.appCustomerCount;
    tableNum.text=appointmentModel.appTableCount;
    if ([appointmentModel.isPark isEqualToString:@"0"]) {
        isPark.text=@"否";
    }else if ([appointmentModel.isPark isEqualToString:@"1"]){
        isPark.text=@"是";
    }else{
        isPark.text=@"";
    }
    if ([appointmentModel.isProxyDrive isEqualToString:@"0"]) {
        isProxyDrive.text=@"否";
    }else if ([appointmentModel.isProxyDrive isEqualToString:@"1"]){
        isProxyDrive.text=@"是";
    }else{
        isProxyDrive.text=@"";
    }
    if ([appointmentModel.isRoom isEqualToString:@"0"]) {
        isRoom.text=@"否";
    }else if ([appointmentModel.isRoom isEqualToString:@"1"]){
        isRoom.text=@"是";
    }else{
        isRoom.text=@"";
    }
    appStatus.text=@"订单状态:";
    statusDetail.text=appointmentModel.appStatusName;
    
    if ([appointmentModel.appStatusName isEqualToString:@"未付款"]) {
        appStatus.textColor=[UIColor redColor];
        statusDetail.textColor=[UIColor redColor];
    }else{
        appStatus.textColor=[UIColor greenColor];
        statusDetail.textColor=[UIColor greenColor];
    }
    
    appointments=[WebServices getAppointmentByAppCode:appointmentModel.appCode];
    NSLog(@"%d",[appointments count]);
}

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
    static NSString *CellIdentifier = @"OrderListDishCell";
    OrderListDishCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    dishEntity=[self.appointments objectAtIndex:indexPath.row];
    
    cell.dishName.text=dishEntity.dishName;
    cell.priceLbl.text=@"优惠价:";
    cell.priceNum.text=dishEntity.dishPrice;
    cell.priceUnit.text=@"元";
    cell.numLbl.text=dishEntity.num;
    if (dishEntity.imageUrl==nil) {
        cell.imageUrl.image=[UIImage imageNamed:@"picture_load"];
    }else{
        [cell.imageUrl setImageWithURL:[NSURL URLWithString:[WEBSITE_URL stringByAppendingString:dishEntity.imageUrl]]
                      placeholderImage:[UIImage imageNamed:@"picture_load"]];
    }
        
    return cell;
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
    //NSString *urlTitle;
    if (self.isViewLoaded) {
        
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        NSLog(@"appcode = %@",appDelegate.appCode);
        
        //[WebServices getAppointmentByAppCode:appDelegate.appCode];
        //        [WebServices getAppointments:result];
        
        NSString *str = [appointmentModel.appCode stringByAppendingString:@","];
        str = [str stringByAppendingString:result];
        NSLog(@"str= %@",str);
        [WebServices checkAppInfo:str];
        
    }
    
    
    [self dismissModalViewControllerAnimated:NO];
    
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
