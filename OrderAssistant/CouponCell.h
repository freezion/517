//
//  CouponCell.h
//  OrderAssistant
//
//  Created by Li Feng on 13-5-10.
//
//

#import <UIKit/UIKit.h>

@interface CouponCell : UITableViewCell{
    UIImageView *imageUrl;
    UILabel *sdName;
    UILabel *couponName;
}

@property (nonatomic, retain) IBOutlet UILabel *sdName;
@property (nonatomic, retain) IBOutlet UILabel *couponName;
@property (nonatomic, retain) IBOutlet UIImageView *imageUrl;

@end
