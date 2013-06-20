//
//  FinishDetailViewController.m
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-8.
//
//

#import "FinishDetailViewController.h"
#import "ShopCouponModel.h"
#import "UIImageView+WebCache.h"

@interface FinishDetailViewController ()

@end

@implementation FinishDetailViewController

@synthesize page;
@synthesize dataList;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    int j = 0;
    if ([UIScreen mainScreen].bounds.size.height == 480.0) {
        for (int i = 0; i < [dataList count]; i ++) {
            
            if (i % 3 == 0 && i != 0) {
                j ++;
            }
            ShopCouponModel *model = [dataList objectAtIndex:i];
            UIImageView *frameOpen = [[UIImageView alloc] initWithFrame:CGRectMake((95.0 + 10.0) * (i % 3) + 5.0, 3.0 + 120.0 * j, 100.0, 100.0)];
            frameOpen.image = [UIImage imageNamed:@"feed_frame_opened.png"];
            [self.view addSubview:frameOpen];
            
            UIImageView *frameTitle = [[UIImageView alloc] initWithFrame:CGRectMake((95.0 + 10.0) * (i % 3) + 5.0, 102.0 + 120.0 * j, 100.0, 20.0)];
            frameTitle.image = [UIImage imageNamed:@"feed_frame_title.png"];
            [self.view addSubview:frameTitle];
            
            UIImageView *shopLogo = [[UIImageView alloc] initWithFrame:CGRectMake((95.0 + 10.0) * (i % 3) + 8.0, 6.0 + 120.0 * j, 94.0, 94.0)];
            [shopLogo setImageWithURL:[NSURL URLWithString:model.imageUrl]
                     placeholderImage:[UIImage imageNamed:@"sns_my_pic"]];
            [self.view addSubview:shopLogo];
            
            
            UILabel *lblFindCount = [[UILabel alloc] initWithFrame:CGRectMake((95.0 + 10.0) * (i % 3) + 10.0, 104.0 + 120.0 * j, 90.0, 15.0)];
            lblFindCount.text = [NSString stringWithFormat:@"%@", model.time];
            lblFindCount.textAlignment = UITextAlignmentCenter;
            lblFindCount.font = [UIFont fontWithName:@"HelveticaNeue" size:11.f];
            [self.view addSubview:lblFindCount];
            
        }
    } else {
        for (int i = 0; i < [dataList count]; i ++) {
            
            if (i % 3 == 0 && i != 0) {
                j ++;
            }
            ShopCouponModel *model = [dataList objectAtIndex:i];
            UIImageView *frameOpen = [[UIImageView alloc] initWithFrame:CGRectMake((105.0 + 2.0) * (i % 3) + 1.0, 10.0 + 150.0 * j, 106.0, 106.0)];
            frameOpen.image = [UIImage imageNamed:@"feed_frame_opened.png"];
            [self.view addSubview:frameOpen];
            
            UIImageView *frameTitle = [[UIImageView alloc] initWithFrame:CGRectMake((105.0 + 2.0) * (i % 3) + 1.0, 116.0 + 150.0 * j, 106.0, 26.0)];
            frameTitle.image = [UIImage imageNamed:@"feed_frame_title.png"];
            [self.view addSubview:frameTitle];
            
            UIImageView *shopLogo = [[UIImageView alloc] initWithFrame:CGRectMake((105.0 + 2.0) * (i % 3) + 4.0, 13.0 + 150.0 * j, 100.0, 100.0)];
            [shopLogo setImageWithURL:[NSURL URLWithString:model.imageUrl]
                     placeholderImage:[UIImage imageNamed:@"sns_my_pic"]];
            [self.view addSubview:shopLogo];
            
            
            UILabel *lblFindCount = [[UILabel alloc] initWithFrame:CGRectMake((105.0 + 2.0) * (i % 3) + 16.0, 120.0 + 150.0 * j, 90.0, 15.0)];
            lblFindCount.text = [NSString stringWithFormat:@"%@", model.time];
            lblFindCount.font = [UIFont fontWithName:@"HelveticaNeue" size:11.f];
            lblFindCount.center = frameTitle.center;
            [self.view addSubview:lblFindCount];
            
        }
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
