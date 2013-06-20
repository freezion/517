//
//  AppointmentCell.m
//  OrderAssistant
//
//  Created by flybird on 12-12-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppointmentCell.h"

@implementation AppointmentCell
@synthesize appTableCountLbl;
@synthesize appointmentTimeLbl;
@synthesize appCustomerCountLbl;
@synthesize nameLbl;
@synthesize shopNameLbl;
@synthesize appStatusNameLbl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
