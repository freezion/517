//
//  RegisterViewController.h
//  OrderAssistant
//
//  Created by flybird on 12-12-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"
@class RegisterViewController;

@protocol RegisterViewDelegate <NSObject>
- (void) dismissViewController:(RegisterViewController *) viewController;
@end
@interface RegisterViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>{
    UILabel *userNameLbl;
    UILabel *userPasswordLbl;
    UITextField *userNameText;
    UITextField *userPasswordText;
    UIButton *submitBtn;
    
    UILabel *idCodeLbl;
    UITextField *idCodeText;
    UIButton *getIdentifyingCode;
    
    UserEntity *userEntity;
    
    NSString *registerKey;
    
    id<RegisterViewDelegate> delegate;
}

@property (nonatomic, retain) id<RegisterViewDelegate> delegate;
@property (nonatomic, retain) IBOutlet UILabel *userNameLbl;
@property (nonatomic, retain) IBOutlet UILabel *userPasswordLbl;
@property (nonatomic, retain) IBOutlet UITextField *userNameText;
@property (nonatomic, retain) IBOutlet UITextField *userPasswordText;
@property (nonatomic, retain) IBOutlet UIButton *submitBtn;
@property (nonatomic, retain) IBOutlet UILabel *idCodeLbl;
@property (nonatomic, retain) IBOutlet UITextField *idCodeText;
@property (nonatomic, retain) IBOutlet UIButton *getIdentifyingCode;

@property (nonatomic, retain) UserEntity *userEntity;
@property (nonatomic, retain) NSString *registerKey;

- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;

- (IBAction)submitBtnPress:(id)sender;
- (IBAction)getIdentifyingCode:(id)sender;
@end
