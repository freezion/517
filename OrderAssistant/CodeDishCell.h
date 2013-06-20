//
//  CodeDishCell.h
//  OrderAssistant
//
//  Created by Li Feng on 13-6-9.
//
//

#import <UIKit/UIKit.h>
#import "DishEntity.h"

@interface CodeDishCell : UITableViewCell
{
    UIImageView *image;
    UILabel *dishName;
    UILabel *dishPrice;
    UILabel *dishUnit;
    UILabel *num;
    UIImageView *isFeatureDish;
    UIButton *plusButton;
    UIButton *minusButton;
    UILabel *loadMoreLbl;
    UIActivityIndicatorView *activityView;
    
    UILabel *dishPriceLbl;
    UILabel *moneyUnit;
    
    DishEntity *dishEntity;
    
    
}

@property (nonatomic, retain) IBOutlet UIImageView *image;
@property (nonatomic, retain) IBOutlet UILabel *dishName;
@property (nonatomic, retain) IBOutlet UILabel *dishPrice;
@property (nonatomic, retain) IBOutlet UILabel *dishUnit;
@property (nonatomic, retain) IBOutlet UILabel *num;
@property (nonatomic, retain) IBOutlet UIImageView *isFeatureDish;
@property (nonatomic, retain) IBOutlet UIButton *plusButton;
@property (nonatomic, retain) IBOutlet UIButton *minusButton;
@property (nonatomic, retain) IBOutlet UILabel *loadMoreLbl;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) IBOutlet UILabel *dishPriceLbl;
@property (nonatomic, retain) IBOutlet UILabel *moneyUnit;
@property (nonatomic, retain) DishEntity *dishEntity;

//- (IBAction)pluseBtn:(id)sender;
//- (IBAction)minusBtn:(id)sender;

@end
