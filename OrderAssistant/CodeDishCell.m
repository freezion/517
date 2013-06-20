//
//  CodeDishCell.m
//  OrderAssistant
//
//  Created by Li Feng on 13-6-9.
//
//

#import "CodeDishCell.h"

@implementation CodeDishCell
@synthesize image;
@synthesize dishName;
@synthesize dishPrice;
@synthesize dishUnit;
@synthesize num;
@synthesize isFeatureDish;
@synthesize plusButton;
@synthesize minusButton;
@synthesize loadMoreLbl;
@synthesize activityView;
@synthesize dishPriceLbl;
@synthesize moneyUnit;
@synthesize dishEntity;

//- (IBAction)pluseBtn:(id)sender{
//    if ([num.text intValue]>=0) {
//        num.text=[NSString stringWithFormat:@"%d",[num.text intValue] +1];
//    
//    }
//    
//}
//- (IBAction)minusBtn:(id)sender{
//    if ([num.text intValue]>0) {
//        num.text=[NSString stringWithFormat:@"%d",[num.text intValue] -1];
//        
//    }
//    
//}

@end
