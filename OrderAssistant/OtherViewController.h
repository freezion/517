//
//  OtherViewController.h
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-3-27.
//
//

#import <UIKit/UIKit.h>
#import "ResEntity.h"

@interface OtherViewController : UITableViewController{

    ResEntity *resEntity;
    IBOutlet UILabel *NameLabel;    
    IBOutlet UILabel *OpenTimeLabel;
    IBOutlet UILabel *SpecialServiceLabel;
    IBOutlet UILabel *AddressLabel;
    IBOutlet UILabel *TransportLabel;
    IBOutlet UILabel *DiningPurposeLabel;
}

@property(nonatomic,retain) ResEntity *resEntity;

@end
