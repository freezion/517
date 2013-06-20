//
//  ResCommentsViewController.m
//  OrderAssistant
//
//  Created by flybird on 12-11-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ResCommentsViewController.h"

@interface ResCommentsViewController ()

@end

@implementation ResCommentsViewController

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
    //[self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"rest_detail_bm_2_hot.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"rest_detail_bm_2.png"]];
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
