//
//  ActivityDishViewController.m
//  OrderAssistant
//
//  Created by Li Feng on 13-4-23.
//
//

#import "ActivityDishViewController.h"
#import "UIImageView+WebCache.h"


@implementation ActivityDishViewController
@synthesize activityEntity;
@synthesize activityDishes;
@synthesize dishEntity;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"商家活动套餐详细";
    activityDishes=[WebServices getDishsByEventCode:activityEntity.eventCode];
    
    
}


//-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender{
//    QRCodeViewController *qrCodeViewController = [segue destinationViewController];
//    qrCodeViewController.dishEntity=dishEntity;
//    NSLog(@"%@",dishEntity.dishCode);
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
	// Return the number of rows as there are in the resentities array.
	return [self.activityDishes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActivityDishCell";
    ActivityDishCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    //点击cell按下去的状态时背景图片变换
//    UIImage *selectedCell = [[UIImage imageNamed:@"lottery_cellBg_hall_focus"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 1, 5, 1)];
//    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:selectedCell];
    
    dishEntity=[self.activityDishes objectAtIndex:indexPath.row];
    
    cell.dishName.text=dishEntity.dishName;
    cell.dishPrice.text=dishEntity.dishPrice;
    if (dishEntity.imageUrl==nil) {
        cell.imageUrl.image=[UIImage imageNamed:@"picture_load"];
    }else{
        [cell.imageUrl setImageWithURL:[NSURL URLWithString:[WEBSITE_URL stringByAppendingString:dishEntity.imageUrl]]
                      placeholderImage:[UIImage imageNamed:@"picture_load"]];
    }

    return cell;
    
}


@end
