//
//  ActivityDishCell.h
//  OrderAssistant
//
//  Created by Li Feng on 13-4-23.
//
//

#import <UIKit/UIKit.h>

@interface ActivityDishCell : UITableViewCell{
    UILabel *dishName;
    UILabel *dishPrice;
    UIImageView *imageUrl;
}

@property (nonatomic, retain) IBOutlet UILabel *dishName;
@property (nonatomic, retain) IBOutlet UILabel *dishPrice;
@property (nonatomic, retain) IBOutlet UIImageView *imageUrl;

@end
