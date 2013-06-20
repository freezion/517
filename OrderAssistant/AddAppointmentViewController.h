//
//  AddAppointmentViewController.h
//  OrderAssistant
//
//  Created by flybird on 12-12-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"
#import "ResEntity.h"
#import "DishEntity.h"

@class AddAppointmentViewController;

@protocol AddAppointmentViewDelegate <NSObject>
- (void) dismissAddappointmentViewController:(AddAppointmentViewController *) viewController;
@end

@interface AddAppointmentViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate>{
    
    UITextField *firstName;
    UITextField *appCustomerCount;
    UITextField *appTableCount;
    
    UISegmentedControl *sexSegControl;
    UISegmentedControl *isParkSegControl;
    UISegmentedControl *isProxyDriveSegControl;
    
    UIButton *showDateBtn;
    UIButton *showTimeBtn;
    
    UILabel *dateLbl;
    UILabel *timeLbl;
    UIButton *dataLblBtn;
    UIButton *timeLblBtn;
    
    UIDatePicker *datePicker;
    UIDatePicker *timePicker;
    
    UserEntity *userEntity;
    ResEntity *resEntity;
    id<AddAppointmentViewDelegate> addAppoint_delegate;
    
    NSString *appType;
    NSMutableArray *orderDishList;
    DishEntity *dishEntity;
    NSString *dishJSon;
    NSMutableArray *dishJSonArray;
    NSString *roomJSon;
    
    NSArray *codeArray;
}
@property (nonatomic, retain) id<AddAppointmentViewDelegate> addAppoint_delegate;
@property (nonatomic, retain) IBOutlet UITextField *firstName;
@property (nonatomic, retain) IBOutlet UITextField *appCustomerCount;
@property (nonatomic, retain) IBOutlet UITextField *appTableCount;
@property (nonatomic, retain) IBOutlet UISegmentedControl *sexSegControl;
@property (nonatomic, retain) IBOutlet UISegmentedControl *isParkSegControl;
@property (nonatomic, retain) IBOutlet UISegmentedControl *isProxyDriveSegControl;
@property (nonatomic, retain) IBOutlet UIButton *showDateBtn;
@property (nonatomic, retain) IBOutlet UIButton *dataLblBtn;
@property (nonatomic, retain) IBOutlet UIButton *timeLblBtn;
@property (nonatomic, retain) IBOutlet UIButton *showTimeBtn;
@property (nonatomic, retain) IBOutlet UILabel *dateLbl;
@property (nonatomic, retain) IBOutlet UILabel *timeLbl;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) UIDatePicker *timePicker;
@property (nonatomic, retain) UserEntity *userEntity;
@property (nonatomic, retain) ResEntity *resEntity;
@property (nonatomic, retain) NSString *appType;
@property (nonatomic, retain) NSMutableArray *orderDishList;
@property (nonatomic, retain) DishEntity *dishEntity;
@property (nonatomic, retain) NSString *dishJSon;
@property (nonatomic, retain) NSMutableArray *dishJSonArray;
@property (nonatomic, retain) NSString *roomJSon;
@property (nonatomic, retain) NSArray *codeArray;

-(IBAction)sexSegControlAction:(id)sender;
-(IBAction)isParkSegControlAction:(id)sender;
-(IBAction)isProxyDriveSegControlAction:(id)sender;


- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;

- (IBAction)showDateAction:(id)sender;
- (IBAction)showTimeAction:(id)sender;

@end
