//
//  DishCell.h
//  OrderAssistant
//
//  Created by Li Feng on 13-4-19.
//
//

#import <UIKit/UIKit.h>
#import "DishEntity.h"
@interface DishCell : UITableViewCell
{
    UIImageView *image;
    UILabel *dishName;
    UILabel *dishPrice;
    UILabel *dishPriceS;
    UILabel *dishUnit;
    UILabel *dishUnitS;
    UILabel *num;
    UIImageView *isFeatureDish;
    UIButton *plusButton;
    UIButton *minusButton;
    UILabel *loadMoreLbl;
    UIActivityIndicatorView *activityView;
    
    UILabel *dishPriceLbl;
    UILabel *dishPriceSLbl;
    UILabel *moneyUnit;
    UILabel *moneyUnitS;
    
    DishEntity *dishEntity;
    
   
}

@property (nonatomic, retain) IBOutlet UIImageView *image;
@property (nonatomic, retain) IBOutlet UILabel *dishName;
@property (nonatomic, retain) IBOutlet UILabel *dishPrice;
@property (nonatomic, retain) IBOutlet UILabel *dishPriceS;
@property (nonatomic, retain) IBOutlet UILabel *dishUnit;
@property (nonatomic, retain) IBOutlet UILabel *dishUnitS;
@property (nonatomic, retain) IBOutlet UILabel *num;
@property (nonatomic, retain) IBOutlet UIImageView *isFeatureDish;
@property (nonatomic, retain) IBOutlet UIButton *plusButton;
@property (nonatomic, retain) IBOutlet UIButton *minusButton;
@property (nonatomic, retain) IBOutlet UILabel *loadMoreLbl;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) IBOutlet UILabel *dishPriceLbl;
@property (nonatomic, retain) IBOutlet UILabel *dishPriceSLbl;
@property (nonatomic, retain) IBOutlet UILabel *moneyUnit;
@property (nonatomic, retain) IBOutlet UILabel *moneyUnitS;
@property (nonatomic, retain) DishEntity *dishEntity;

- (IBAction)pluseBtn:(id)sender;
- (IBAction)minusBtn:(id)sender;

@end
