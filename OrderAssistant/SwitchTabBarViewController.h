//
//  SwitchTabBarViewController.h
//  OrderAssistant
//
//  Created by flybird on 12-11-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ZXingWidgetController.h"
#import "UserEntity.h"
//#import <QRCodeReader.h>
#import "WebServices.h"
#import "PersonalInformationViewController.h"
#import "AppDelegate.h"


@interface SwitchTabBarViewController : UITabBarController<PersonalInformationViewControllerDelegate>{
    UserEntity *userEntity;
    NSString *shopCode;
}
@property (nonatomic, retain) NSString *shopCode;
@property (nonatomic, retain) UserEntity *userEntity;



@end
