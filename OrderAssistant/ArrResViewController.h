//
//  ArrResViewController.h
//  OrderAssistant
//
//  Created by flybird on 12-10-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ResCell.h"
#import "ResEntity.h"
#import "PopoverView.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PersonalViewController.h"
#import "MBProgressHUD.h"
#import "RegisterViewController.h"
//#import "EGORefreshTableHeaderView.h"
#import "AreaEntity.h"
#import "CookStyleEntity.h"


@interface ArrResViewController : ViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIActionSheetDelegate,PopoverViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate, UITabBarControllerDelegate, UITabBarDelegate, MBProgressHUDDelegate,RegisterViewDelegate>{
   

    ResCell  *rescell;
    ResEntity *resEntity;
    NSMutableArray *resentities;
    UITableView *tableviewCustom;

    UIActionSheet *actionSheet;
    
//    NSArray *myPickerData1;
//    NSArray *myPickerData2;
    NSString *result;
    
    int btnChoice;
    int btnChoice_DistanceRow;
    int btnChoice_CookingRow;
    int btnChoice_CookingSubRow;
    int btnChoice_AreaRow;
    int currentPage;

    
    CLLocationManager *locationManager;
    CLLocationCoordinate2D curLocation;
    UITabBar *tabBar;
    UITabBarController *tabBarController;
    UINavigationItem *item;
    
    PersonalViewController *personalViewController;
    ArrResViewController *arrResViewController;
   
    NSString *pageSize;
    NSString *pageNow;
   
    
    NSString *shopKindCode;
    
    MBProgressHUD *HUD;
    
    UIPickerView *picker_distant;
    UIPickerView *picker_area;
    UIPickerView *picker_cooking;
    
    int status;
    
    NSString *shopListCode;
    NSString *shopType;
    
   // UISearchBar *searchBar;
  
    UIButton *cookingStyleBtn;
    UIButton *businessAreaBtn;
    UIButton *distanceBtn;
    UILabel *cookingStyleLable;
    UILabel *businessAreaLable;
    UILabel *distanceLable;
    NSString *distantText;
    
    AreaEntity *areaEntity;
    CookStyleEntity *cookEntity;
    
    NSMutableArray *cookStyleLists;
    NSMutableArray *areaLists;
    
    NSMutableArray *pickDateArray;
    NSMutableArray *pickDateCodeArray;
    NSMutableArray *subPickDateArray;
    NSMutableArray *subPickDateCodeArray;
   // NSUInteger pickerType;
    NSDictionary *dicPicker;
    
}
//@property (nonatomic) NSUInteger pickerType;
@property (nonatomic, retain) NSDictionary *dicPicker;
@property (nonatomic, retain) NSMutableArray *pickDateArray;
@property (nonatomic, retain) NSMutableArray *pickDateCodeArray;
@property (nonatomic, retain) NSMutableArray *subPickDateArray;
@property (nonatomic, retain) NSMutableArray *subPickDateCodeArray;
@property (nonatomic, retain) AreaEntity *areaEntity;
@property (nonatomic, retain) CookStyleEntity *cookEntity;
@property (nonatomic, retain) NSMutableArray *cookStyleLists;
@property (nonatomic, retain) NSMutableArray *areaLists;
@property (nonatomic, retain) IBOutlet UIButton *cookingStyleBtn;
@property (nonatomic, retain) IBOutlet UIButton *businessAreaBtn;
@property (nonatomic, retain) IBOutlet UIButton *distanceBtn;
@property (nonatomic, retain) IBOutlet UILabel *cookingStyleLable;
@property (nonatomic, retain) IBOutlet UILabel *businessAreaLable;
@property (nonatomic, retain) IBOutlet UILabel *distanceLable;
@property (nonatomic, retain) NSString *distantText;
//@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) NSString *shopListCode;
@property (nonatomic, retain) NSString *shopType;
@property(nonatomic) int status;
@property (nonatomic, retain) ResCell  *rescell;
@property (nonatomic, retain) ResEntity *resEntity;
@property (nonatomic, retain) NSMutableArray *resentities;
@property (nonatomic, retain) IBOutlet UITableView *tableviewCustom;

//@property (nonatomic, retain) NSArray *myPickerData1;
//@property (nonatomic, retain) NSArray *myPickerData2;
@property (nonatomic, retain) UIActionSheet *actionSheet;
@property (nonatomic, retain) NSString *result;
@property (nonatomic) int btnChoice;
@property (nonatomic) int currentPage;
@property (nonatomic) int btnChoice_DistanceRow;
@property (nonatomic) int btnChoice_CookingRow;
@property (nonatomic) int btnChoice_CookingSubRow;
@property (nonatomic) int btnChoice_AreaRow;

@property (nonatomic, retain) NSString *pageNow;
@property (nonatomic, retain) NSString *pageSize;


@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D curLocation;

@property (nonatomic, retain) NSString *curLad;
@property (nonatomic, retain) NSString *curLgd;

@property (nonatomic, retain) NSString *shopKindCode;
@property (nonatomic, retain) UIPickerView *picker_distant;
@property (nonatomic, retain) UIPickerView *picker_area;
@property (nonatomic, retain) UIPickerView *picker_cooking;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)buttonPress:(UIButton *)sender;


//- (void)reloadTableViewDataSource;
//- (void)doneLoadingTableViewData;

//- (void)searchBar:(UISearchBar *)searchBar activate:(BOOL) active;

@end
