//
//  FavoritesCouponsCell.h
//  OrderAssistant
//
//  Created by Li Feng on 13-5-11.
//
//

#import <UIKit/UIKit.h>

@interface FavoritesCouponsCell : UITableViewCell{
    UIImageView *imageUrl;
    UILabel *sdName;
    UILabel *couponName;
}

@property (nonatomic, retain) IBOutlet UILabel *sdName;
@property (nonatomic, retain) IBOutlet UILabel *couponName;
@property (nonatomic, retain) IBOutlet UIImageView *imageUrl;

@end
