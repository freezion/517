//
//  PersonalViewController.m
//  OrderAssistant
//
//  Created by flybird on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PersonalViewController.h"
#import "WebServices.h"
#import "PersonalInformationViewController.h"
#import "SwitchTabBarViewController.h"
#import "ArrResViewController.h"
#import "AddAppointmentViewController.h"
#import "RegisterViewController.h"
#import "QRCodeViewController.h"

@interface PersonalViewController (){
    UITextField *forgetPsdText;
    UITextField *isActiveText;
    
    NSString *modifyResult;
    NSString *temporaryPsd;
}

@end

@implementation PersonalViewController

@synthesize userNameText;
@synthesize passwordText;
@synthesize loginBtn;
@synthesize forgetPassWordBtn;
@synthesize userEntity;
@synthesize registerBtn;
@synthesize loadKey;
@synthesize delegate;
@synthesize QRdelegate;
@synthesize deviceTokenNum;
@synthesize model;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //login界面手机号码，密码框内的提示
    userNameText.placeholder=@" 请输入手机号码";
    passwordText.placeholder=@" 请输入密码";
    
    UIImage *buttonImage = [[UIImage imageNamed:@"trip_bar_right"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    UIButton *backBtn=[[UIButton alloc] init];
    [backBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    CGRect buttonFrame1 = [backBtn frame];
    buttonFrame1.size.width = buttonImage.size.width;
    buttonFrame1.size.height = buttonImage.size.height;
    [backBtn setFrame:buttonFrame1];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    backBtn.titleLabel.font=[UIFont fontWithName:@"Kailasa" size:13];
    [backBtn addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:backBarButton];
    
    self.navigationItem.title=@"登录";
    
}

- (void)turnBack{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//}
//判断输入号码，密码后点击登录后的状态
- (IBAction)loginCheck:(id)sender
{
    if ([@"" isEqual:userNameText.text]||[@"" isEqual:passwordText.text]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入您的用户名或密码！" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        // NSString *deviceToken=@"234534";
        deviceTokenNum = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).deviceTokenNum;
        NSLog(@"%@",deviceTokenNum);
        userEntity=[WebServices login:userNameText.text :passwordText.text :deviceTokenNum :@"2"];
        
        if (userEntity.userFlag.intValue==-1) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码错误！" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [alert show];
        }
        if (userEntity.userFlag.intValue==0) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的号码还未注册！" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [alert show];
        }
        if (userEntity.userFlag.intValue==1) {
            if (userEntity.userIsActive.intValue==0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户激活" message:@"您的号码还未激活" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"获取验证码", nil];
                alert.tag=1;
                [alert show];
                
            }
            else if (userEntity.userIsActive.intValue==1) {
                
                //用户名和密码存入keychain
                model = [[UIDevice currentDevice] model];
                if ([model isEqualToString:@"iPhone Simulator"]) {
                    
                    deviceTokenNum = @"999";
                }
                
                NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
                [usernamepasswordKVPairs setObject:userNameText.text forKey:KEY_USERID];
                [usernamepasswordKVPairs setObject:userEntity.userCCode forKey:KEY_CCODE];
                [usernamepasswordKVPairs setObject:passwordText.text forKey:KEY_PASSWORD];
                [usernamepasswordKVPairs setObject:deviceTokenNum forKey:KEY_DEVICETOKEN];
                //save session
                [UserKeychain save:KEY_USERID_CCODE data:usernamepasswordKVPairs];
                
                loadKey=@"OK";
                //[self dismissModalViewControllerAnimated:YES];
                
                if (self.delegateMain) {
                    [self.delegateMain dismissSelf:self withFlag:@"1"];
                } else if (delegate) {
                    [delegate dismissViewController:self];
                } else if (QRdelegate) {
                    [QRdelegate toQRCodeViewController:self];
                } else {
                    [self dismissModalViewControllerAnimated:YES];
                }
                
            }
        }
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    RegisterViewController *registerViewController = [storyborad instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    registerViewController.delegate=self;
}
//- (void) dismissViewController:(RegisterViewController *) viewController
//{
//    [viewController dismissModalViewControllerAnimated:YES];
//    //status = 1;
//    loadKey=@"OK";
//}

- (void)viewDidAppear:(BOOL)animated
{
    
}
- (IBAction)forgetPsdBtn:(id)sender
{
    forgetPsdText=[[UITextField alloc] init];
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"忘记密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"获取密码", nil];
    alert.tag=3;
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    forgetPsdText=[alert textFieldAtIndex:0];
    forgetPsdText.placeholder=@"请输入您的手机号";
    forgetPsdText.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag==1) {
        
        if (buttonIndex==1) {
            
            [WebServices resendMessage:userNameText.text];
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"获取验证码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag=2;
            [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            isActiveText=[alert textFieldAtIndex:0];
            isActiveText.placeholder=@"请输入您获取的验证码";
            isActiveText.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            [alert show];
        }
    }
    if (alertView.tag==2) {
        if (buttonIndex==1) {
            
            modifyResult= [WebServices modifyCustomer:userEntity.userCCode :userNameText.text :isActiveText.text];
            
            if ([modifyResult isEqualToString:@"false"]) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的验证码输入错误，请重新操作" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if([modifyResult isEqualToString:@"true"]){
                
                if (delegate == nil) {
                    //用户名和密码存入keychain
                    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
                    [usernamepasswordKVPairs setObject:userNameText.text forKey:KEY_USERID];
                    [usernamepasswordKVPairs setObject:userEntity.userCCode forKey:KEY_CCODE];
                    [usernamepasswordKVPairs setObject:passwordText.text forKey:KEY_PASSWORD];
                    //save session
                    [UserKeychain save:KEY_USERID_CCODE data:usernamepasswordKVPairs];
                    
                    loadKey=@"OK";
                    [self dismissModalViewControllerAnimated:YES];
                } else {
                    [delegate dismissViewController:self];
                }
                
            }
        }
    }
    if (alertView.tag==3) {
        if (buttonIndex==1) {
            
            if (![forgetPsdText.text isEqualToString:@""]&&![forgetPsdText.text isEqualToString:nil]) {
                
                temporaryPsd=[WebServices findPassword:forgetPsdText.text];
                
                if ([temporaryPsd isEqualToString:@"-1"]) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"对不起，没有该用户的用户信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [alert show];
                }
                else if ([temporaryPsd isEqualToString:@"0"]) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"修改数据库失败！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [alert show];
                }
                
                else if ([temporaryPsd isEqualToString:@"1"]) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"修改成功" message:@"请注意查收您的临时密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [alert show];
                }
                
            }
            else {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请正确输入您的号码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
            }
        }
        
    }
}

//在ASCII码状态下，输入完成后点击键盘上的return按钮，键盘消失
- (IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

//输入完成后再次点击输入框的背景 键盘消失
- (IBAction)backgroundTap:(id)sender
{
    [userNameText resignFirstResponder];
    [passwordText resignFirstResponder];
}

@end
