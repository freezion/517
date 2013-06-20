//
//  ResIntroViewController.m
//  OrderAssistant
//
//  Created by flybird on 12-11-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ResIntroViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "CommonUtil.h"

@interface ResIntroViewController ()

@end

@implementation ResIntroViewController

@synthesize resIntroTextView;
@synthesize resEntity;
@synthesize nocontImageView;



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
    self.navigationItem.title=@"餐厅简介";
	
    //[resIntroTextView.layer setCornerRadius:10];
    
    if (![@"" isEqual:resEntity.resIntro]) {
        self.nocontImageView.hidden=YES;
        //resIntroTextView=[[UITextView alloc] initWithFrame:self.view.frame];//初始化大小
        //self.resIntroTextView.delegate=self;
        resIntroTextView.text=resEntity.resIntro;
        self.resIntroTextView.scrollEnabled = YES;//是否可以拖动
        self.resIntroTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
        
        //self.resIntroTextView.font = [UIFont fontWithName:@"Kailasa" size:15.0];//设置字体名字和字体大小
        
        self.resIntroTextView.editable = NO;//设置文字内容不可编辑
        //[self.view addSubview: self.resIntroTextView];//加入到整个页面中
    }
    else{
        self.resIntroTextView.hidden=YES;
    }
    
       
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


@end
