//
//  RegisterViewController.m
//  OrderAssistant
//
//  Created by flybird on 12-12-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RegisterViewController.h"
#import "WebServices.h"
#import "PersonalInformationViewController.h"

@interface RegisterViewController ()
{
    NSString *modifyResult;
}

@end

@implementation RegisterViewController

@synthesize userNameLbl;
@synthesize userNameText;
@synthesize userPasswordLbl;
@synthesize userPasswordText;
@synthesize submitBtn;
@synthesize idCodeLbl;
@synthesize idCodeText;
@synthesize getIdentifyingCode;
@synthesize userEntity;
@synthesize registerKey;
@synthesize delegate;

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
	// Do any additional setup after loading the view.
    userNameText.placeholder=@" 请输入手机号码";
    userPasswordText.placeholder=@" 请输入密码";
    
    self.navigationItem.title=@"注册";
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (IBAction)submitBtnPress:(id)sender
{
    if ([@"" isEqual:userNameText.text]||[@"" isEqual:userPasswordText.text]) {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入您需要注册的用户名或密码！" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if ([@"" isEqual:idCodeText.text]){
    
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请获取验证码！" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [alert show];
        
    }else {
        
        modifyResult= [WebServices modifyCustomer:userEntity.userCCode :userNameText.text :idCodeText.text];
        
        if ([modifyResult isEqualToString:@"false"]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"注册失败，请重新操作" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            alert.tag=1;
            [alert show];
        }
        else if([modifyResult isEqualToString:@"true"]){
           
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            alert.tag=6;
            [alert show];
            
        }
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (alertView.tag==6) {
        
        if (buttonIndex==alertView.cancelButtonIndex) {
            NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
            [usernamepasswordKVPairs setObject:userNameText.text forKey:KEY_USERID];
            [usernamepasswordKVPairs setObject:userEntity.userCCode forKey:KEY_CCODE];
            [usernamepasswordKVPairs setObject:userPasswordText.text forKey:KEY_PASSWORD];
            //save session
            [UserKeychain save:KEY_USERID_CCODE data:usernamepasswordKVPairs];
            
            UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
           PersonalViewController *personalViewController = [storyborad instantiateViewControllerWithIdentifier:@"PersonalViewController"];
           personalViewController.loadKey=@"OK";
           NSLog(@"%@",personalViewController.loadKey);
           
            registerKey=@"OK";
            if (delegate == nil) {
                [self dismissModalViewControllerAnimated:YES];
            } else {
                [delegate dismissViewController:self];
            }
//            UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//            RegisterViewController *registerViewController = [storyborad instantiateViewControllerWithIdentifier:@"RegisterViewController"];
//            registerViewController.delegate=self;
//            [delegate dismissViewController:self];
        }
    }
    if (alertView.tag==7) {
        if (buttonIndex==alertView.cancelButtonIndex) {
            registerKey=@"OK";
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (IBAction)getIdentifyingCode:(id)sender
{
    if ([@"" isEqual:userNameText.text]||[@"" isEqual:userPasswordText.text]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入您需要注册的用户名或密码！" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        //手机号以13， 15，18开头，八个 \d 数字字符
        NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        BOOL isMatch=[phoneTest evaluateWithObject:userNameText.text];
        if (!isMatch) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请正确输入您的手机号！" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [alert show];
        }else if([userPasswordText.text length]>32){
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入小于32位的密码！" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            userEntity=[WebServices addCustomer:userNameText.text :userPasswordText.text];
            
            if (userEntity.userFlag.intValue==4) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"该用户已经存在" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                alert.tag=7;
                [alert show];
            }
        }
        
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - Table view data source


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
    [userPasswordText resignFirstResponder];
}
@end
