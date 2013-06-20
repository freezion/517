//
//  ShopTabViewController.m
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-8.
//
//

#import "ShopTabViewController.h"

@interface ShopTabViewController ()

@end

@implementation ShopTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self addCenterButtonWithImage:[UIImage imageNamed:@"517logo"] highlightImage:[UIImage imageNamed:@"517logo"]];
}

-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    UIImage *imageLight = [UIImage imageNamed:@"cam_light"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:imageLight];
    imageView.frame = CGRectMake(0.0, 0.0, imageLight.size.width, imageLight.size.height);
    if (heightDifference < 0) {
        button.center = self.tabBar.center;
        imageView.center = self.tabBar.center;
    } else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0 - 5;
        button.center = center;
        imageView.center = center;
    }
    
    [self.view addSubview:button];
    
    
}

@end
