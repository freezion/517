//
//  OrderListDetailViewController.h
//  OrderAssistant
//
//  Created by Li Feng on 13-4-23.
//
//

#import <UIKit/UIKit.h>
#import "AppointmentModel.h"
#import "WebServices.h"
#import "OrderListDishCell.h"
#import "DishEntity.h"
#import "ZXingWidgetController.h"


@interface OrderListDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ZXingDelegate>{
    UILabel *shopName;
    UILabel *arriveDate;
    UILabel *arriveTime;
    UILabel *customerNum;
    UILabel *tableNum;
    UILabel *isRoom;
    UILabel *isPark;
    UILabel *isProxyDrive;
    UILabel *appStatus;
    UILabel *statusDetail;
    
    AppointmentModel *appointmentModel;
    DishEntity *dishEntity;
    NSMutableArray *appointments;

}
@property (nonatomic, retain) AppointmentModel *appointmentModel;
@property (nonatomic, retain) NSMutableArray *appointments;
@property (nonatomic, retain) DishEntity *dishEntity;

@property (nonatomic, retain) IBOutlet UILabel *shopName;
@property (nonatomic, retain) IBOutlet UILabel *arriveDate;
@property (nonatomic, retain) IBOutlet UILabel *arriveTime;
@property (nonatomic, retain) IBOutlet UILabel *customerNum;
@property (nonatomic, retain) IBOutlet UILabel *isRoom;
@property (nonatomic, retain) IBOutlet UILabel *isPark;
@property (nonatomic, retain) IBOutlet UILabel *isProxyDrive;
@property (nonatomic, retain) IBOutlet UILabel *appStatus;
@property (nonatomic, retain) IBOutlet UILabel *statusDetail;
@property (nonatomic, retain) IBOutlet UILabel *tableNum;

@end
