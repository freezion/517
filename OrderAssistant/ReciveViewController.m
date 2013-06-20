//
//  ReciveViewController.m
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-14.
//
//

#import "ReciveViewController.h"
#import "CouponEntity.h"
#import "NewCouponCell.h"
#import "UIImageView+WebCache.h"
#import "ReciveDetailViewController.h"

@interface ReciveViewController ()

@end

@implementation ReciveViewController

@synthesize couponLists;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"获奖查看";
    UIButton *appBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [[UIImage imageNamed:@"trip_bar_right"] resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
    [appBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    appBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [appBtn setTitle:@"关闭" forState:UIControlStateNormal];
    //[appBtn setImage:[UIImage imageNamed:@"two_dimension_code" ] forState:UIControlStateNormal];
    CGRect appBtnFrame = [appBtn frame];
    appBtnFrame.size.width = buttonImage.size.width;
    appBtnFrame.size.height = buttonImage.size.height;
    [appBtn setFrame:appBtnFrame];
    [appBtn addTarget:self action:@selector(closeThis) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonBar = [[UIBarButtonItem alloc] initWithCustomView:appBtn];
    [self.navigationItem setRightBarButtonItem:buttonBar];
    
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
    NSString *ccode = [usernamepasswordKVPairs objectForKey:KEY_CCODE];
    couponLists = [CouponEntity getCouponListByCCode:ccode];
}

-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    CouponEntity *entity = [couponLists objectAtIndex:[indexPath row]];
    ReciveDetailViewController *controller = segue.destinationViewController;
    controller.entity = entity;
}

- (void) closeThis {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [couponLists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewCouponCell";
    NewCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //点击cell按下去的状态时背景图片变换
    UIImage *selectedCell = [[UIImage imageNamed:@"lottery_cellBg_hall_focus"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 1, 5, 1)];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:selectedCell];
    CouponEntity *couponEntity = [self.couponLists objectAtIndex:indexPath.row];
    cell.sdName.text = couponEntity.sdName;
    cell.eventName.text = couponEntity.couponName;
    cell.eventPrice.text = couponEntity.eventPrice;
    cell.price.text = [NSString stringWithFormat:@"原价 %@ 元", couponEntity.price];
    if (couponEntity.imageUrl==nil) {
        cell.imageUrl.image=[UIImage imageNamed:@"picture_load"];
    }else{
        [cell.imageUrl setImageWithURL:[NSURL URLWithString:[WEBSITE_URL stringByAppendingString:couponEntity.imageUrl]]
                      placeholderImage:[UIImage imageNamed:@"picture_load"]];
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
