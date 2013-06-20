//
//  AppointmentCell.h
//  OrderAssistant
//
//  Created by flybird on 12-12-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentCell : UITableViewCell{
    UILabel *shopNameLbl;
    UILabel *appointmentTimeLbl;
    UILabel *appCustomerCountLbl;
    UILabel *appTableCountLbl;
    UILabel *nameLbl;
    UILabel *appStatusNameLbl;
}
@property (nonatomic, retain)IBOutlet UILabel *shopNameLbl;
@property (nonatomic, retain)IBOutlet UILabel *appointmentTimeLbl;
@property (nonatomic, retain)IBOutlet UILabel *appCustomerCountLbl;
@property (nonatomic, retain)IBOutlet UILabel *appTableCountLbl;
@property (nonatomic, retain)IBOutlet UILabel *nameLbl;
@property (nonatomic, retain)IBOutlet UILabel *appStatusNameLbl;

@end
