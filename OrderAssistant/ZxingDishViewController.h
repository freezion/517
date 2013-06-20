//
//  ZxingDishViewController.h
//  OrderAssistant
//
//  Created by Li Feng on 13-6-8.
//
//

#import <UIKit/UIKit.h>
#import "CodeDishCell.h"
#import "DishEntity.h"
#import "WebServices.h"
#import "DishMenu.h"
#import "PersonalViewController.h"
#import "ResEntity.h"
#import "AddAppointmentViewController.h"

@interface ZxingDishViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate,PersonalViewDelegate,AddAppointmentViewDelegate>{
    DishEntity *dishEntity;
    NSMutableArray *dishes;
    NSString *pageSize;
    NSString *pageNow;
    int currentPage;
    NSString *SDCode;
    UITableView *tableviewCustom;
    //NSString *codeType;
    
    NSMutableArray *menuList;
    NSMutableArray *pickDateArray;
    NSMutableArray *pickDateCodeArray;
    
    DishMenu *dishMenu;
    UIPickerView *menuPicker;
    int btnChoice_menuRow;
    UIButton *distanceBtn;
    
    int btnChoose;
    NSMutableArray *dishJSonArray;
    NSString *roomJSonStr;
    NSString *dishJSonStr;
    
    NSArray *codeArray;
    
    NSString *addAppointmentResult;
    NSString *submitType;   //预约点菜-1  扫码点菜-0
    
    ResEntity *resEntity;
    int status;
}

@property (nonatomic, retain) UIButton *distanceBtn;
@property (nonatomic, retain) DishEntity *dishEntity;
@property (nonatomic, retain) NSMutableArray *dishes;
@property (nonatomic, retain) NSString *pageSize;
@property (nonatomic, retain) NSString *pageNow;
@property (nonatomic) int currentPage;
@property (nonatomic, retain) NSString *SDCode;
//@property (nonatomic, retain) NSString *codeType;
@property (nonatomic, retain) NSMutableArray *menuList;
@property (nonatomic, retain) NSMutableArray *pickDateArray;
@property (nonatomic, retain) NSMutableArray *pickDateCodeArray;
@property (nonatomic, retain) DishMenu *dishMenu;
@property (nonatomic, retain) UIPickerView *menuPicker;
@property (nonatomic) int btnChoice_menuRow;
@property (nonatomic) int btnChoose;
@property (nonatomic, retain) NSMutableArray *dishJSonArray;
@property (nonatomic, retain) NSString *roomJSonStr;
@property (nonatomic, retain) NSString *dishJSonStr;
@property (nonatomic, retain) NSArray *codeArray;
@property (nonatomic, retain) NSString *addAppointmentResult;
@property (nonatomic, retain) NSString *submitType;
@property (nonatomic, retain) ResEntity *resEntity;
@property (nonatomic) int status;

@property (nonatomic, retain) IBOutlet UITableView *tableviewCustom;
- (IBAction)plusDish:(id)sender;
- (IBAction)minusDish:(id)sender;

@end
