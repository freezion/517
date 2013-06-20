//
//  ActivityViewController.m
//  OrderAssistant
//
//  Created by Li Feng on 13-4-22.
//
//

#import "ActivityViewController.h"
#import "UIImageView+WebCache.h"
#import "ActivityDishViewController.h"
#import "ActivityIntroViewController.h"


@implementation ActivityViewController
@synthesize activityEntity;
@synthesize activities;
@synthesize resEntity;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"商家活动";
    activities=[WebServices getEventInfoBySDCode:resEntity.resCode];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
	// Return the number of rows as there are in the resentities array.
	return [self.activities count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActivityCell";
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //点击cell按下去的状态时背景图片变换
    UIImage *selectedCell = [[UIImage imageNamed:@"lottery_cellBg_hall_focus"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 1, 5, 1)];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:selectedCell];
        
    activityEntity=[self.activities objectAtIndex:indexPath.row];
    cell.eventName.text=activityEntity.eventName;
    cell.eventPrice.text=activityEntity.eventPrice;
    [cell.imageUrl setImageWithURL:[NSURL URLWithString:[WEBSITE_URL stringByAppendingString:activityEntity.imageUrl]]
               placeholderImage:[UIImage imageNamed:@"loading_throbber_icon"]];
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    activityEntity=[activities objectAtIndex:indexPath.row];
    if ([activityEntity.flage isEqualToString:@"0"]) {
        
        UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        ActivityIntroViewController *activityIntroViewController = [storyborad instantiateViewControllerWithIdentifier:@"ActivityIntroViewController"];
        activityIntroViewController.activityEntity=activityEntity;
        [self.navigationController pushViewController:activityIntroViewController animated:YES];
        
    }else if ([activityEntity.flage isEqualToString:@"1"]) {
        
        UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        ActivityDishViewController *activityDishViewController = [storyborad instantiateViewControllerWithIdentifier:@"ActivityDishViewController"];
        activityDishViewController.activityEntity=activityEntity;
        [self.navigationController pushViewController:activityDishViewController animated:YES];
    }
    //点击cell按下去的状态时背景图片变换，控制返回时图片恢复
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
