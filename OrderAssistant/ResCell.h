//
//  ResCell.h
//  OrderAssistant
//
//  Created by flybird on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResCell : UITableViewCell{
    UILabel *resNameLbl;
    UILabel *resPriceLbl;
    UILabel *resSdAreaLbl;
    UILabel *resDistanceLbl;
    UILabel *resPriceTitleLbl;
    UILabel *resPhoneLbl;
    UILabel *resPhoneNumber;
    UIImageView *resImgView;
    UILabel *loadMoreLbl;
    UILabel *miles;
    UIActivityIndicatorView *activityView;
    //UIImageView *backgroundImgView;

}

@property(nonatomic,retain) IBOutlet UILabel *miles;
@property(nonatomic,retain) IBOutlet UILabel *resNameLbl;
@property(nonatomic,retain) IBOutlet UILabel *resPriceLbl;
@property(nonatomic,retain) IBOutlet UILabel *resSdAreaLbl;
@property(nonatomic,retain) IBOutlet UILabel *resDistanceLbl;
@property(nonatomic,retain) IBOutlet UILabel *resPriceTitleLbl;
@property(nonatomic,retain) IBOutlet UILabel *resPhoneLbl;
@property(nonatomic,retain) IBOutlet UILabel *resPhoneNumber;
@property(nonatomic,retain) IBOutlet UIImageView *resImgView;
@property(nonatomic,retain) IBOutlet UILabel *loadMoreLbl;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityView;

//@property(nonatomic,retain) IBOutlet UIImageView *backgroundImgView;


@end
