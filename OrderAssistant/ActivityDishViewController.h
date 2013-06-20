//
//  ActivityDishViewController.h
//  OrderAssistant
//
//  Created by Li Feng on 13-4-23.
//
//

#import <UIKit/UIKit.h>
#import "ActivityEntity.h"
#import "WebServices.h"
#import "ActivityDishCell.h"
#import "DishEntity.h"

@interface ActivityDishViewController : UITableViewController{
    ActivityEntity *activityEntity;
    NSMutableArray *activityDishes;
    DishEntity *dishEntity;
}

@property (nonatomic, retain) ActivityEntity *activityEntity;
@property (nonatomic, retain) NSMutableArray *activityDishes;
@property (nonatomic, retain) DishEntity *dishEntity;

@end
