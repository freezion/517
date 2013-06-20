//
//  IntroViewController.m
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-9.
//
//

#import "IntroViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

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
    UIImage *buttonAgree = [[UIImage imageNamed:@"action_button_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(3, 4, 3, 5)];
    [self.btnAgree setBackgroundImage:buttonAgree forState:UIControlStateNormal];
    UIImage *buttonAgreeHigh = [[UIImage imageNamed:@"action_button_bg_highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(3, 5, 3, 5)];
    [self.btnAgree setBackgroundImage:buttonAgreeHigh forState:UIControlStateHighlighted];
    [self.btnAgree addTarget:self action:@selector(buttonPressd:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnDisagree setBackgroundImage:buttonAgree forState:UIControlStateNormal];
    [self.btnDisagree setBackgroundImage:buttonAgreeHigh forState:UIControlStateHighlighted];
    [self.btnDisagree addTarget:self action:@selector(buttonPressd:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *urlString = [WEBSITE_URL stringByAppendingString:@"/Pages/others/wandaProtocal.html"];
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    [self hideGradientBackground:self.webView];
}

- (void)buttonPressd:(id)sender {
    int tg = ((UIButton *)sender).tag;
    [self.delegate agreeMentPress:tg];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) hideGradientBackground:(UIView*)theView
{
    for (UIView * subview in theView.subviews)
    {
        if ([subview isKindOfClass:[UIImageView class]])
            subview.hidden = YES;
        
        [self hideGradientBackground:subview];
    }
}

@end
