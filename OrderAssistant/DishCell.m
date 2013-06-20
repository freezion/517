//
//  DishCell.m
//  OrderAssistant
//
//  Created by Li Feng on 13-4-19.
//
//

#import "DishCell.h"

@implementation DishCell
@synthesize image;
@synthesize dishName;
@synthesize dishPriceS;
@synthesize dishPrice;
@synthesize dishUnit;
@synthesize dishUnitS;
@synthesize num;
@synthesize isFeatureDish;
@synthesize plusButton;
@synthesize minusButton;
@synthesize loadMoreLbl;
@synthesize activityView;
@synthesize dishPriceLbl;
@synthesize dishPriceSLbl;
@synthesize moneyUnit;
@synthesize moneyUnitS;
@synthesize dishEntity;

- (IBAction)pluseBtn:(id)sender{
    if ([num.text intValue]>=0) {
        num.text=[NSString stringWithFormat:@"%d",[num.text intValue] +1];
        
    }
    
}
- (IBAction)minusBtn:(id)sender{
    if ([num.text intValue]>0) {
        num.text=[NSString stringWithFormat:@"%d",[num.text intValue] -1];

    }
    
}
@end
