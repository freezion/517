//
//  PersonalViewController.h
//  OrderAssistant
//
//  Created by flybird on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"
#import "RegisterViewController.h"
//#import "CouponEntity.h"

@class PersonalViewController;

@protocol PersonalViewDelegate <NSObject>
- (void) dismissViewController:(PersonalViewController *) viewController;
@end

@protocol PersonalViewQRCodeDelegate <NSObject>
- (void) toQRCodeViewController:(PersonalViewController *) viewController;
@end

@protocol CouponMainDelegate <NSObject>
- (void) dismissSelf:(PersonalViewController *) viewController withFlag:(NSString *) flag;
@end

@interface PersonalViewController : UIViewController<UIAlertViewDelegate,UITabBarControllerDelegate,RegisterViewDelegate>{
    UITextField *userNameText;
    UITextField *passwordText;
    UIButton *loginBtn;
    UIButton *forgetPassWordBtn;
    UIButton *registerBtn;
    
    UserEntity *userEntity;
    
    NSString *loadKey;
    
    id<PersonalViewDelegate> delegate;
    
    
    id<PersonalViewQRCodeDelegate> QRdelegate;
    //CouponEntity *couponEntity;
    
    NSString *deviceTokenNum;
    NSString *model;
    
}


@property (nonatomic, retain) id<PersonalViewDelegate> delegate;
@property (nonatomic, retain) id<PersonalViewQRCodeDelegate> QRdelegate;
@property (nonatomic, assign) id delegateMain;
@property (nonatomic, retain) IBOutlet UITextField *userNameText;
@property (nonatomic, retain) IBOutlet UITextField *passwordText;
@property (nonatomic, retain) IBOutlet UIButton *loginBtn;
@property (nonatomic, retain) IBOutlet UIButton *forgetPassWordBtn;
@property (nonatomic, retain) IBOutlet UIButton *registerBtn;
@property (nonatomic, retain) UserEntity *userEntity;
@property (nonatomic, retain) NSString *loadKey;
@property (nonatomic, retain) NSString *deviceTokenNum;
@property (nonatomic, retain) NSString *model;

//@property (nonatomic, retain) CouponEntity *couponEntity;

- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;

- (IBAction)loginCheck:(id)sender;
- (IBAction)forgetPsdBtn:(id)sender;


@end
