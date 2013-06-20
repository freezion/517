//
//  PersonalInformationViewController.h
//  OrderAssistant
//
//  Created by flybird on 12-11-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"
#import "AppointmentModel.h"
#import "PersonalViewController.h"
#import "ZXingWidgetController.h"
#import "WebServices.h"
#import "AppDelegate.h"

@protocol PersonalInformationViewControllerDelegate <NSObject>

@optional
- (void) getAppCode:(NSString *)appCode;

@end

@interface PersonalInformationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UITabBarControllerDelegate>{
    UserEntity *userEntity;
    UILabel *nickName;
    UILabel *score;
    UILabel *devoteName;
    
    AppointmentModel *appointmentModel;
    AppointmentModel *appointmentmodel;
    NSMutableArray *appointments;
    UITableView *appTableView;
    id <PersonalInformationViewControllerDelegate> delegate;
    
}
@property (nonatomic, retain)IBOutlet UILabel *nickName;
@property (nonatomic, retain)IBOutlet UILabel *score;
@property (nonatomic, retain)IBOutlet UILabel *devoteName;
@property (nonatomic, retain)UserEntity *userEntity;
@property (nonatomic, retain)IBOutlet UITableView *appTableView;

@property (nonatomic, retain)AppointmentModel *appointmentModel;
@property (nonatomic, retain)AppointmentModel *appointmentmodel;
@property (nonatomic, retain)NSMutableArray *appointments;
@property(nonatomic,retain) id <PersonalInformationViewControllerDelegate> delegate;

@end
