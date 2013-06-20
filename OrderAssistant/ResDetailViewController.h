//
//  ResDetailViewController.h
//  OrderAssistant
//
//  Created by flybird on 12-11-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResEntity.h"
#import "PersonalViewController.h"
#import "AddAppointmentViewController.h"
#import "ZxingDishViewController.h"

@interface ResDetailViewController : UITableViewController<UIActionSheetDelegate,PersonalViewDelegate,AddAppointmentViewDelegate>{
    UILabel *ResNameLbl;
    UILabel *ResTasteLbl;
    UILabel *ResEnLbl;
    UILabel *ResServeLbl;
    UILabel *ResPriceLbl;
    UILabel *ResStarGradeLbl;
    UILabel *ResTasteTitleLbl;
    UILabel *ResEnTitleLbl;
    UILabel *ResServeTitleLbl;
    UILabel *ResPriceTitleLbl;
    UIButton *ResOrderBtn;
    UIButton *ResPicBtn;
    UIImageView *ResImgView;
    UIImageView *ResStarImgView;
    
    UILabel *ResInfoLbl;
    UILabel *ResAddressLbl;
    UILabel *ResTelLbl;
    UILabel *ResAddDetailLbl;
    UILabel *ResTelDetailLbl;
    UIButton *ResOtherBtn;
    
    UILabel *ResCusImgLbl;
    UILabel *ResCusImgDetailLbl;
    
    UIButton *ResTransportBtn;
    UIButton *ResRoadBtn;
    UIButton *ResMistakeBtn;
    
    UIButton *mapNavigationBtn;
    int status;
    
    
    UIButton *locationButton;
    UIButton *phoneButton;
    UIButton *shopDishButton;
    UIButton *shopActivityButton;
}

@property (nonatomic, retain) IBOutlet UIButton *locationButton;
@property (nonatomic, retain) IBOutlet UIButton *phoneButton;
@property (nonatomic, retain) IBOutlet UIButton *shopDishButton;
@property (nonatomic, retain) IBOutlet UIButton *shopActivityButton;
@property(nonatomic) int status;
@property(nonatomic,retain) ResEntity *resEntity;

@property(nonatomic,retain) IBOutlet UILabel *ResNameLbl;

@property(nonatomic,retain) IBOutlet UILabel *ResTasteTitleLbl;
@property(nonatomic,retain) IBOutlet UILabel *ResEnTitleLbl;
@property(nonatomic,retain) IBOutlet UILabel *ResServeTitleLbl;
@property(nonatomic,retain) IBOutlet UILabel *ResPriceTitleLbl;

@property(nonatomic,retain) IBOutlet UILabel *ResTasteLbl;
@property(nonatomic,retain) IBOutlet UILabel *ResEnLbl;
@property(nonatomic,retain) IBOutlet UILabel *ResServeLbl;
@property(nonatomic,retain) IBOutlet UILabel *ResPriceLbl;

@property(nonatomic,retain) IBOutlet UILabel *ResStarGradeLbl;
@property(nonatomic,retain) IBOutlet UIButton *ResOrderBtn;
@property(nonatomic,retain) IBOutlet UIButton *ResPicBtn;
@property(nonatomic,retain) IBOutlet UIImageView *ResImgView;
@property(nonatomic,retain) IBOutlet UIImageView *ResStarImgView;


@property(nonatomic,retain) IBOutlet UILabel *ResInfoLbl;
@property(nonatomic,retain) IBOutlet UILabel *ResAddressLbl;
@property(nonatomic,retain) IBOutlet UILabel *ResTelLbl;
@property(nonatomic,retain) IBOutlet UILabel *ResAddDetailLbl;
@property(nonatomic,retain) IBOutlet UILabel *ResTelDetailLbl;
@property(nonatomic,retain) IBOutlet UIButton *ResOtherBtn;


@property(nonatomic,retain)IBOutlet UILabel *ResCusImgLbl;
@property(nonatomic,retain)IBOutlet UILabel *ResCusImgDetailLbl;


@property(nonatomic,retain) IBOutlet UIButton *ResTransportBtn;
@property(nonatomic,retain) IBOutlet UIButton *ResRoadBtn;
@property(nonatomic,retain) IBOutlet UIButton *ResMistakeBtn;

//- (IBAction)showShopActivity:(id)sender;
- (IBAction)showMap:(id)sender;
- (IBAction)makePhonecall:(id)sender;
- (IBAction)showMenu:(id)sender;


@end
