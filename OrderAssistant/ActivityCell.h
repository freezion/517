//
//  ActivityCell.h
//  OrderAssistant
//
//  Created by Li Feng on 13-4-22.
//
//

#import <UIKit/UIKit.h>

@interface ActivityCell : UITableViewCell{
    UILabel *eventName;
    UILabel *eventPrice;
    UIImageView *imageUrl;
    
    
}

@property (nonatomic, retain) IBOutlet UILabel *eventName;
@property (nonatomic, retain) IBOutlet UILabel *eventPrice;
@property (nonatomic, retain) IBOutlet UIImageView *imageUrl;


@end
