//
//  AddAppointmentViewController.m
//  OrderAssistant
//
//  Created by flybird on 12-12-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AddAppointmentViewController.h"
#import "PersonalInformationViewController.h"
#import "WebServices.h"
#import "SwitchTabBarViewController.h"
#import "PersonalViewController.h"

@interface AddAppointmentViewController ()

@end

@implementation AddAppointmentViewController
{
    NSString *CCode;
    NSString *sdCode;
    NSString *phone;
    NSString *appDate;
    NSString *empty;
    
    NSString *isPark;
    NSString *isProxyDrive;
    NSString *sex;
  
    NSString *addAppointmentResult;
}

@synthesize firstName;
@synthesize sexSegControl;
@synthesize isParkSegControl;
@synthesize isProxyDriveSegControl;
@synthesize appTableCount;
@synthesize appCustomerCount;
@synthesize showDateBtn;
@synthesize showTimeBtn;
@synthesize dateLbl;
@synthesize timeLbl;
@synthesize datePicker;
@synthesize timePicker;
@synthesize userEntity;
@synthesize resEntity;
@synthesize addAppoint_delegate;
@synthesize dataLblBtn;
@synthesize appType;
@synthesize orderDishList;
@synthesize dishEntity;
@synthesize dishJSon;
@synthesize dishJSonArray;
@synthesize roomJSon;
@synthesize codeArray;

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
    UIButton *appBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [[UIImage imageNamed:@"trip_bar_right"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    [appBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [appBtn setTitle:@"提交" forState:UIControlStateNormal];
    appBtn.titleLabel.font=[UIFont fontWithName:@"Kailasa" size:13];
    CGRect appBtnFrame = [appBtn frame];
    appBtnFrame.size.width = buttonImage.size.width;
    appBtnFrame.size.height = buttonImage.size.height;
    [appBtn setFrame:appBtnFrame];
    if ([appType isEqualToString:@"0"]) {
        [appBtn addTarget:self action:@selector(submitAppointment) forControlEvents:UIControlEventTouchUpInside];
    }else if ([appType isEqualToString:@"1"]){
        [appBtn addTarget:self action:@selector(submitAppointmentAndDish) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIBarButtonItem *buttonBar = [[UIBarButtonItem alloc] initWithCustomView:appBtn];
    self.navigationItem.rightBarButtonItem = buttonBar;
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    UIImage *cancelBtnImage = [[UIImage imageNamed:@"trip_bar_right"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    [cancelBtn setBackgroundImage:cancelBtnImage forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font=[UIFont fontWithName:@"Kailasa" size:13];
    CGRect cancelBtnFrame = [cancelBtn frame];
    cancelBtnFrame.size.width = cancelBtnImage.size.width;
    cancelBtnFrame.size.height = cancelBtnImage.size.height;
    [cancelBtn setFrame:cancelBtnFrame];
    [cancelBtn addTarget:self action:@selector(cancelAppointment) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancelBtnBar = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    self.navigationItem.leftBarButtonItem = cancelBtnBar;

    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString* sysDate = [formatter stringFromDate:date];
    dateLbl.text=sysDate;
    [formatter setDateFormat:@"HH:MM"];
    NSString *sysTime=[formatter stringFromDate:date];
    timeLbl.text=sysTime;
    
    
    //设置默认选择项索引 
    sexSegControl.selectedSegmentIndex = 0;
    isParkSegControl.selectedSegmentIndex=0;
    isProxyDriveSegControl.selectedSegmentIndex=0;
    
    if (sexSegControl.selectedSegmentIndex==0) {
        sex=@"0";
    }else if (sexSegControl.selectedSegmentIndex==1) {
        sex=@"1";
    }
    if (isParkSegControl.selectedSegmentIndex==0) {
        isPark=@"0";
    }else if (isParkSegControl.selectedSegmentIndex==1) {
        isPark=@"1";
    }
    if (isProxyDriveSegControl.selectedSegmentIndex==0) {
        isProxyDrive=@"0";
    }else if (isProxyDriveSegControl.selectedSegmentIndex==1) {
        isProxyDrive=@"1";
    }
}
-(IBAction)sexSegControlAction:(id)sender{
    if (sexSegControl.selectedSegmentIndex==0) {
        sex=@"0";
    }else if (sexSegControl.selectedSegmentIndex==1) {
        sex=@"1";
    }
}
-(IBAction)isParkSegControlAction:(id)sender{
    if (isParkSegControl.selectedSegmentIndex==0) {
        isPark=@"0";
    }else if (isParkSegControl.selectedSegmentIndex==1) {
        isPark=@"1";
    }
}
-(IBAction)isProxyDriveSegControlAction:(id)sender{
    if (isProxyDriveSegControl.selectedSegmentIndex==0) {
        isProxyDrive=@"0"; 
    }else if (isProxyDriveSegControl.selectedSegmentIndex==1) {
        isProxyDrive=@"1";  
    }
}

- (void)cancelAppointment
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)submitAppointmentAndDish{
    
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
    
    CCode=[usernamepasswordKVPairs objectForKey:KEY_CCODE];
    phone=[usernamepasswordKVPairs objectForKey:KEY_USERID];
    empty=@" ";
    appDate=[[dateLbl.text stringByAppendingString:empty] stringByAppendingString:timeLbl.text];
    sdCode=resEntity.resCode;
    
    if ( [@"" isEqual:firstName.text]||[@"" isEqual:appCustomerCount.text]||[@"" isEqual:appTableCount.text])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请完整填写预定信息" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        dishJSonArray=[[NSMutableArray alloc] init];
        for (int i=0; i<[orderDishList count]; i++) {
            dishEntity=[self.orderDishList objectAtIndex:i];
            NSDictionary *jsonDic=[NSDictionary dictionaryWithObjectsAndKeys:
                                   dishEntity.dishCode,@"dishCode",
                                   dishEntity.dishName,@"dishName",
                                   dishEntity.dishPrice,@"dishPrice",
                                   dishEntity.num,@"dishNum",
                                   nil];
            [dishJSonArray addObject:jsonDic];            
        }
        
        NSError *error;      
        NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        CCode, @"CCode",
                                        sdCode, @"sdCode",
                                        appDate, @"appDate",
                                        timeLbl.text, @"arriveTime",
                                        appCustomerCount.text, @"appCustomerCount",
                                        firstName.text, @"name",
                                        phone, @"phone",
                                        isProxyDrive, @"isProxyDrive",
                                        isPark, @"isPark",
                                        sex, @"sex",
                                        appTableCount.text, @"appTableCount",
                                        dishJSonArray,@"dishList",
                                        nil,@"eventCode",
                                        nil, @"way",
                                        nil];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                           options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        addAppointmentResult=[WebServices addAppointmentForPhone:jsonString];
        if ([addAppointmentResult isEqualToString:@"false"]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"预约失败，请重新操作" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        else if ([addAppointmentResult isEqualToString:@"true"]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"预约成功" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            alert.tag=20;
            [alert show];
        }
        
    }
}
- (void)submitAppointment
{
    
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
   
    CCode=[usernamepasswordKVPairs objectForKey:KEY_CCODE];
    phone=[usernamepasswordKVPairs objectForKey:KEY_USERID];
    empty=@" ";
    appDate=[[dateLbl.text stringByAppendingString:empty] stringByAppendingString:timeLbl.text];
    sdCode=resEntity.resCode;

    if ( [@"" isEqual:firstName.text]||[@"" isEqual:appCustomerCount.text]||[@"" isEqual:appTableCount.text])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请完整填写预定信息" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        CCode, @"CCode",
                                        sdCode, @"sdCode",
                                        appDate, @"appDate",
                                        timeLbl.text, @"arriveTime",
                                        appCustomerCount.text, @"appCustomerCount",
                                        firstName.text, @"name",
                                        phone, @"phone",
                                        isProxyDrive, @"isProxyDrive",
                                        isPark, @"isPark",
                                        sex, @"sex",
                                        appTableCount.text, @"appTableCount",
                                        nil, @"isRoom",
                                        nil, @"way",
                                        nil];
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                           options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        addAppointmentResult=[WebServices addAppointment:jsonString];
        
        if ([addAppointmentResult isEqualToString:@"false"]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"预约失败，请重新操作" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        else if ([addAppointmentResult isEqualToString:@"true"]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"预约成功" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            alert.tag=15;
            [alert show];
        }

    }
       
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==20) {
        if (buttonIndex==alertView.cancelButtonIndex) {
            
            [addAppoint_delegate dismissAddappointmentViewController:self];
        }
    }
    if (alertView.tag==15) {
        if (buttonIndex==alertView.cancelButtonIndex) {
            
            //[addAppoint_delegate dismissAddappointmentViewController:self];
            
            [self dismissModalViewControllerAnimated:YES];
        }
    }
}
- (IBAction)showDateAction:(id)sender
{
    [appTableCount resignFirstResponder];
    [appCustomerCount resignFirstResponder];
    [firstName resignFirstResponder];
    
    CGRect toolbarTargetFrame=CGRectMake(0, self.view.bounds.size.height-204, self.view.bounds.size.width, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height - 160, self.view.bounds.size.width, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    darkView.alpha = 0;//设置透明的view
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPicker)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 320, 206)];
    datePicker.tag=10;
    datePicker.datePickerMode=UIDatePickerModeDate; 
    [self.view addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonSystemItemDone target:self action:@selector(dismissPicker)];
    
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2];//使PickerView控件从底部升起动画的时间为0.2秒
    //使PickerView控件从底部升起动画
    [datePicker setFrame:CGRectMake(0.0, self.view.frame.size.height, datePicker.frame.size.width, datePicker.frame.size.height)];
    
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.5;
    [UIView commitAnimations];
  
}

- (IBAction)showTimeAction:(id)sender
{
    [appTableCount resignFirstResponder];
    [appCustomerCount resignFirstResponder];
    [firstName resignFirstResponder];
    
    CGRect toolbarTargetFrame=CGRectMake(0, self.view.bounds.size.height-204, self.view.bounds.size.width, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height - 160, self.view.bounds.size.width, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    darkView.alpha = 0;//设置透明的view
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPicker)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    timePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 320, 206)];
    timePicker.tag=10;
    timePicker.datePickerMode=UIDatePickerModeTime; 
    [self.view addSubview:timePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonSystemItemDone target:self action:@selector(dismissPicker)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2];//使PickerView控件从底部升起动画的时间为0.2秒
    //使PickerView控件从底部升起动画
    [timePicker setFrame:CGRectMake(0.0, self.view.frame.size.height, timePicker.frame.size.width, timePicker.frame.size.height)];
    
    toolBar.frame = toolbarTargetFrame;
    timePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.5;
    [UIView commitAnimations];
}

- (void)dismissPicker {
    //控制pickerview下降
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.2];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
   
    NSDate *selectDate = [datePicker date];  
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];  
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];  
    dateLbl.text =  [dateFormatter stringFromDate:selectDate]; 
    
    NSDate *selectTime = [timePicker date];  
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];  
    [timeFormatter setDateFormat:@"HH:mm"];  
    timeLbl.text =  [timeFormatter stringFromDate:selectTime];
}

- (void)removeViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//在ASCII码状态下，输入完成后点击键盘上的return按钮，键盘消失
- (IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

//输入完成后再次点击输入框的背景 键盘消失
- (IBAction)backgroundTap:(id)sender
{
    [appTableCount resignFirstResponder];
    [appCustomerCount resignFirstResponder];
    [firstName resignFirstResponder];
    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    // Configure the cell...
//    
//    return cell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
