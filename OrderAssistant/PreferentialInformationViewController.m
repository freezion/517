//
//  PreferentialInformationViewController.m
//  OrderAssistant
//
//  Created by flybird on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PreferentialInformationViewController.h"

@interface PreferentialInformationViewController ()

@end

@implementation PreferentialInformationViewController

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
    //[self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"rest_detail_bm_3_hot.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"rest_detail_bm_3.png"]];
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
