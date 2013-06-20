//
//  SearchViewController.m
//  OrderAssistant
//
//  Created by flybird on 12-10-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import "PopoverView.h"
#import "MenuView.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize totalBtn;
@synthesize topButton;
@synthesize bottomButton;
@synthesize arrowButton;
@synthesize expanding;


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
    
    UIImage *topbuttonImage = [[UIImage imageNamed:@"main_queryview_btn_bg.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    UIImage *topbuttonPressedImage = [[UIImage imageNamed:@"main_queryview_btn_bg.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    [topButton setBackgroundImage:topbuttonImage forState:UIControlStateNormal];
    [topButton setBackgroundImage:topbuttonPressedImage forState:UIControlStateHighlighted];
    CGRect topbuttonFrame = [topButton frame];
    topbuttonFrame.size.width = topbuttonImage.size.width + 210;
    topbuttonFrame.size.height = topbuttonImage.size.height;
    [topButton setFrame:topbuttonFrame];

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


- (IBAction)menuButton:(id)sender
{
    float angle = self.isExpanding ? -M_PI : 0.0f;
    [UIView animateWithDuration:0.1f animations:^{
        arrowButton.transform = CGAffineTransformMakeRotation(angle);
    }];
    
    CGPoint point = CGPointMake(160.0, 360.0);
    MenuView *menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, 280, 120)];
    [PopoverView showPopoverAtPoint:point inView:self.view withContentView:menuView delegate:self];
    
}



- (BOOL)isExpanding
{
    if (expanding) {
        expanding = NO;
    } else {
        expanding = YES;
    }
    return expanding;
}

- (void)popoverViewDidDismiss:(PopoverView *)popoverView {
    float angle = self.isExpanding ? -M_PI : 0.0f;
    [UIView animateWithDuration:0.1f animations:^{
        arrowButton.transform = CGAffineTransformMakeRotation(angle);
    }];
}

- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"345");
}

@end
