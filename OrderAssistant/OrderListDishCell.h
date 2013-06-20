//
//  OrderListDishCell.h
//  OrderAssistant
//
//  Created by Li Feng on 13-4-24.
//
//

#import <UIKit/UIKit.h>

@interface OrderListDishCell : UITableViewCell{
    UIImageView *imageUrl;
    UILabel *dishName;
    UILabel *priceLbl;
    UILabel *priceNum;
    UILabel *priceUnit;
    UILabel *numLbl;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageUrl;
@property (nonatomic, retain) IBOutlet UILabel *dishName;
@property (nonatomic, retain) IBOutlet UILabel *priceLbl;
@property (nonatomic, retain) IBOutlet UILabel *priceNum;
@property (nonatomic, retain) IBOutlet UILabel *priceUnit;
@property (nonatomic, retain) IBOutlet UILabel *numLbl;
@end
