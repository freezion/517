//
//  WDFavoritesCouponsViewController.m
//  OrderAssistant
//
//  Created by Li Feng on 13-5-11.
//
//

#import "WDFavoritesCouponsViewController.h"
#import "QRCodeViewController.h"
#import "PersonalViewController.h"
#import "UIImageView+WebCache.h"
#import "NewCouponCell.h"
#import "EventDetailViewController.h"
#import "CouponEntity.h"

@implementation WDFavoritesCouponsViewController

@synthesize couponEntity;
@synthesize couponLists;
@synthesize favoritCouponStr;
@synthesize collectCoupons;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    collectCoupons=[accountDefaults objectForKey:@"coupon"];
    
    favoritCouponStr=[collectCoupons componentsJoinedByString:@","];
    
    couponLists = [CouponEntity getFavoriteByCode:favoritCouponStr];
    [self.tableView reloadData];
}

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
    couponEntity = [self.couponLists objectAtIndex:indexPath.row];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
    NSString *userName=[usernamepasswordKVPairs objectForKey:KEY_USERID];
    
    couponEntity = [couponLists objectAtIndex:indexPath.row];
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    EventDetailViewController *qrCodeViewController = [storyborad instantiateViewControllerWithIdentifier:@"EventDetailViewController"];
    qrCodeViewController.entity = couponEntity;
    qrCodeViewController.btnType = @"1";
    
    if (userName==nil) {
        UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        PersonalViewController *personalViewController = [storyborad instantiateViewControllerWithIdentifier:@"PersonalViewController"];
        personalViewController.QRdelegate = self;
        UINavigationController *navPersonalViewController=[[UINavigationController alloc] initWithRootViewController:personalViewController];
        [self presentModalViewController:navPersonalViewController animated:NO];
    }else{
        
        [self.navigationController pushViewController:qrCodeViewController animated:YES];
    }
    
    //点击cell按下去的状态时背景图片变换，控制返回时图片恢复
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
        couponEntity=[self.couponLists objectAtIndex:indexPath.row];
        
        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *couponArray=[accountDefaults objectForKey:@"coupon"];
        //NSLog(@"%@",couponArray);
        NSMutableArray *tempArray=[[NSMutableArray alloc] initWithArray:couponArray];
        [tempArray removeObject:couponEntity.couponCode];
        //NSLog(@"%@",tempArray);
        [accountDefaults setObject:tempArray forKey:@"coupon"];
        [accountDefaults synchronize];
        
        [self.couponLists removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void) toQRCodeViewController:(PersonalViewController *) viewController{
    [viewController dismissModalViewControllerAnimated:YES];
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    QRCodeViewController *qrCodeViewController = [storyborad instantiateViewControllerWithIdentifier:@"QRCodeViewController"];
    qrCodeViewController.couponEntity=couponEntity;
    qrCodeViewController.btnType=@"2";
    [self.navigationController pushViewController:qrCodeViewController animated:YES];
    
}
@end
