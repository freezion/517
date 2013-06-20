//
//  ResCell.m
//  OrderAssistant
//
//  Created by flybird on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ResCell.h"

@implementation ResCell
@synthesize resNameLbl;
@synthesize resPriceLbl;
@synthesize resDistanceLbl;
@synthesize resPhoneLbl;
@synthesize resImgView;
@synthesize resSdAreaLbl;
@synthesize resPriceTitleLbl;
@synthesize resPhoneNumber;
//@synthesize backgroundImgView;
@synthesize activityView;
@synthesize loadMoreLbl;  
@synthesize miles;

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
