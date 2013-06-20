//
//  AboutViewController.m
//  OrderAssistant
//
//  Created by Li Feng on 13-6-19.
//
//

#import "AboutViewController.h"

@implementation AboutViewController
@synthesize versionLbl;
@synthesize exitButton;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"关于我们";
    
    [self backgroundTurnRedForButton:exitButton];

    //获取当前版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVer = infoDictionary[@"CFBundleVersion"];
    self.versionLbl.text=currentAppVer;
    
    UIImage *buttonImage = [[UIImage imageNamed:@"trip_bar_right"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    UIButton *backBtn=[[UIButton alloc] init];
    [backBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    CGRect buttonFrame1 = [backBtn frame];
    buttonFrame1.size.width = buttonImage.size.width;
    buttonFrame1.size.height = buttonImage.size.height;
    [backBtn setFrame:buttonFrame1];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.titleLabel.font=[UIFont fontWithName:@"Kailasa" size:13];
    [backBtn addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:backBarButton];
}

- (void)backgroundTurnRedForButton:(UIButton *)button {
    CGSize size = button.frame.size;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.layer.cornerRadius = 6;
    view.clipsToBounds = true;
    view.backgroundColor = [UIColor redColor];
    UIGraphicsBeginImageContext(size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [button setBackgroundImage:screenImage forState:UIControlStateNormal];
}

- (void)turnBack{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)exitPress:(id)sender{
    UIActionSheet *picActionSheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles: nil];
	picActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    picActionSheet.tag=1;
	[picActionSheet showInView:self.view.window];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag==1) {
        if (buttonIndex == actionSheet.cancelButtonIndex) {
            return;
        }
        switch (buttonIndex) {
            case 0: {
                [UserKeychain delete:KEY_USERID_CCODE];
                UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                MainViewController *mainViewController = [storyborad instantiateViewControllerWithIdentifier:@"MainViewController"];
                UINavigationController *navMainViewController=[[UINavigationController alloc] initWithRootViewController:mainViewController];
                [self presentModalViewController:navMainViewController animated:NO];
                break;
            }
            
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
