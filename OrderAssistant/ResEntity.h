//
//  ResEntity.h
//  OrderAssistant
//
//  Created by flybird on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResEntity : NSObject{
    NSString *resNameTxt;
    NSString *resPriceTxt;
    NSString *resDistanceTxt;
    NSString *resImg;
    NSString *ResStarGradeTxt;
    NSString *resStarImg;   
    NSString *ResTasteTxt;
    NSString *ResEnTxt;
    NSString *ResServeTxt;
    NSString *ResOrderTxt;
    NSString *ResAddressTxt;
    NSString *ResTelTxt;
    
    NSString *resSdArea;
    NSString *resSdRegion;
    NSString *resIntro;
    NSString *resBusRoute;
    
    NSString *resCode;
    
    NSString *latitude;
    NSString *longitude;
    
    NSString *totalNum;
    NSString *totalPage;
    NSString *workTime;
    
}

@property(nonatomic,retain)  NSString *resNameTxt;
@property(nonatomic,retain)  NSString *resPriceTxt;
@property(nonatomic,retain)  NSString *resDistanceTxt;
@property(nonatomic,retain)  NSString *ResStarGradeTxt;
@property(nonatomic,retain)  NSString *ResTasteTxt;
@property(nonatomic,retain)  NSString *ResEnTxt;
@property(nonatomic,retain)  NSString *ResServeTxt;
@property(nonatomic,retain)  NSString *ResOrderTxt;
@property(nonatomic,retain)  NSString *resImg;
@property(nonatomic,retain)  NSString *resStarImg;
@property(nonatomic,retain)  NSString *ResAddressTxt;
@property(nonatomic,retain)  NSString *ResTelTxt;

@property(nonatomic,retain)  NSString *resSdArea;
@property(nonatomic,retain)  NSString *resSdRegion;
@property(nonatomic,retain)  NSString *resIntro;
@property(nonatomic,retain)  NSString *resBusRoute;

@property(nonatomic,retain)  NSString *resCode;

@property(nonatomic,retain)  NSString *latitude;
@property(nonatomic,retain)  NSString *longitude;

@property(nonatomic,retain)  NSString *totalNum;
@property(nonatomic,retain)  NSString *totalPage;
@property(nonatomic,retain)  NSString *workTime;


@end
