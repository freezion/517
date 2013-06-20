//
//  ActivityViewController.h
//  OrderAssistant
//
//  Created by Li Feng on 13-4-22.
//
//

#import <UIKit/UIKit.h>
#import "ActivityEntity.h"
#import "ActivityCell.h"
#import "ResEntity.h"
#import "WebServices.h"

@interface ActivityViewController : UITableViewController{
    ActivityEntity *activityEntity;
    NSMutableArray *activities;
    ResEntity *resEntity;
}
@property (nonatomic, retain) ActivityEntity *activityEntity;
@property (nonatomic, retain) NSMutableArray *activities;
@property (nonatomic, retain) ResEntity *resEntity;

@end
