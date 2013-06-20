//
//  DishDetailViewController.h
//  OrderAssistant
//
//  Created by Li Feng on 13-4-19.
//
//

#import <UIKit/UIKit.h>
#import "WebServices.h"
#import "ResEntity.h"
#import "DishCell.h"
#import "DishEntity.h"
//#import "EGORefreshTableHeaderView.h"
#import "PersonalViewController.h"
#import "AddAppointmentViewController.h"


@interface DishDetailViewController : UITableViewController<PersonalViewDelegate,AddAppointmentViewDelegate>{
    
    
    UITableView *tableviewCustom;
    
    ResEntity *resEntity;
    NSMutableArray *dishes;
    
    DishEntity *dishEntity;
    int currentPage;
    NSString *pageSize;
    NSString *pageNow;
    
    NSMutableArray *orderDishes;
    int status;
    //UILabel *numLable;
    
}
@property (nonatomic, retain) IBOutlet UITableView *tableviewCustom;
@property (nonatomic, retain) NSMutableArray *dishes;
@property (nonatomic, retain) ResEntity *resEntity;
@property (nonatomic, retain) DishEntity *dishEntity;
@property (nonatomic) int currentPage;
@property (nonatomic, retain) NSString *pageSize;
@property (nonatomic, retain) NSString *pageNow;
@property (nonatomic, retain) NSMutableArray *orderDishes;
@property(nonatomic) int status;


@end
