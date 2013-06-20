//
//  DishDetailViewController.m
//  OrderAssistant
//
//  Created by Li Feng on 13-4-19.
//
//

#import "DishDetailViewController.h"
#import "UIImageView+WebCache.h"


@implementation DishDetailViewController
@synthesize resEntity;
@synthesize dishes;
@synthesize dishEntity;
@synthesize currentPage;
@synthesize pageSize;
@synthesize pageNow;
@synthesize tableviewCustom;
@synthesize orderDishes;
@synthesize status;


- (void)viewDidLoad{
    [super viewDidLoad];
    
    orderDishes=[[NSMutableArray alloc] init];
    
    UIButton *appBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [[UIImage imageNamed:@"trip_bar_right"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    [appBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [appBtn setTitle:@"预定" forState:UIControlStateNormal];
    appBtn.titleLabel.font=[UIFont fontWithName:@"Kailasa" size:13];
    CGRect appBtnFrame = [appBtn frame];
    appBtnFrame.size.width = buttonImage.size.width;
    appBtnFrame.size.height = buttonImage.size.height;
    [appBtn setFrame:appBtnFrame];
    [appBtn addTarget:self action:@selector(toSubmitAppointment) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonBar = [[UIBarButtonItem alloc] initWithCustomView:appBtn];
    self.navigationItem.rightBarButtonItem = buttonBar;
    
    self.navigationItem.title=@"商家菜品";
    currentPage=1;
    pageSize=@"10";
    pageNow=[NSString stringWithFormat:@"%d",currentPage];
    
    
    dishes=[WebServices getDishInfoBySDCodeForIOS:pageNow :pageSize :resEntity.resCode];
}

- (void)toSubmitAppointment{
    [self.tableView reloadData];
//    for (int i=0; i<[dishes count]; i++) {
//        //dishEntity=[self.dishes objectAtIndex:i];
//        if ([dishEntity.num intValue]>0) {
//            NSLog(@"%@",dishEntity.dishName);
//        }
//    }
   // NSLog(@"%@",orderDishes);
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"确认预定？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=9;
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==9) {
        if (buttonIndex==1) {
            NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
            NSString *userName=[usernamepasswordKVPairs objectForKey:KEY_USERID];
            
            if (userName==nil) {
                
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录后再操作！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
                alert.tag=10;
                [alert show];
                
            }else {
                //点击预定后进入预定信息的填写页面
                UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                AddAppointmentViewController *addAppointmentViewController = [storyborad instantiateViewControllerWithIdentifier:@"AddAppointmentViewController"];
                UINavigationController *navController=[[UINavigationController alloc] initWithRootViewController:addAppointmentViewController];
                addAppointmentViewController.resEntity=resEntity;
                addAppointmentViewController.orderDishList=self.orderDishes;
                addAppointmentViewController.appType=@"1";
                [self presentModalViewController:navController animated:YES];
            }
        }

    }
    
    
    if (alertView.tag==10) {
        
        if (buttonIndex==1) {
            //在未登录的状态下点击预定，需要先登录
            UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            PersonalViewController *personalViewController = [storyborad instantiateViewControllerWithIdentifier:@"PersonalViewController"];
            personalViewController.delegate = self;
            UINavigationController *navPersonalViewController=[[UINavigationController alloc] initWithRootViewController:personalViewController];
            [self presentModalViewController:navPersonalViewController animated:NO];
        }
    }
}

- (void) dismissViewController:(PersonalViewController *) viewController {
    [viewController dismissModalViewControllerAnimated:YES];
    status = 1;
}
- (void) dismissAddappointmentViewController:(AddAppointmentViewController *) viewController {
    [viewController dismissModalViewControllerAnimated:YES];
    status = 0;
}

- (void) viewDidAppear:(BOOL)animated {
    if (status == 1) {
        UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        AddAppointmentViewController *addAppointmentViewController = [storyborad instantiateViewControllerWithIdentifier:@"AddAppointmentViewController"];
        UINavigationController *navController=[[UINavigationController alloc] initWithRootViewController:addAppointmentViewController];
        addAppointmentViewController.resEntity=resEntity;
        addAppointmentViewController.orderDishList=self.orderDishes;
        addAppointmentViewController.appType=@"1";
        addAppointmentViewController.addAppoint_delegate = self;
        [self presentModalViewController:navController animated:YES];
    }else{
        
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.dishes count] == 0){
		return 1;
	}else {
		// Add an object to the end of the array for the \"Load more...\" table cell.
		return [self.dishes count] + 1;
	}
    
	// Return the number of rows as there are in the resentities array.
	//return [self.resentities count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int size = 93;
    if (indexPath.row < [dishes count]) {
        size = 93;
    }else {
        size = 50;
    }
    return size;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DishCell";
    DishCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    //点击cell按下去的状态时背景图片变换
//    UIImage *selectedCell = [[UIImage imageNamed:@"lottery_cellBg_hall_focus"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 1, 5, 1)];
//    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:selectedCell];
    
    if (indexPath.row < [dishes count]) {
       // NSLog(@"%d",[dishes count]);
        dishEntity=[self.dishes objectAtIndex:indexPath.row];
       
        cell.dishName.text=dishEntity.dishName;
        cell.dishPriceLbl.text=@"原价:";
        cell.dishPriceSLbl.text=@"优惠价:";
        cell.moneyUnit.text=@"元/";
        cell.moneyUnitS.text=@"元/";
        cell.dishPrice.text=dishEntity.dishPrice;
        cell.dishPriceS.text=dishEntity.dishPriceS;
        cell.dishUnit.text=dishEntity.dishUnit;
        cell.dishUnitS.text=dishEntity.dishUnit;
        //cell.num.text=dishEntity.num;
        dishEntity.num=cell.num.text;
        //cell.num.text=dishEntity.num;
       // NSLog(@"%@",dishEntity.num);
        if ([cell.num.text intValue]>0) {
            [orderDishes addObject:dishEntity];
        }
        
        cell.plusButton.hidden=NO;
        cell.minusButton.hidden=NO;
        //cell.resImgView.image=[CommonUtil getImageFromURL:resEntity.resImg];
        [cell.image setImageWithURL:[NSURL URLWithString:[WEBSITE_URL stringByAppendingString:dishEntity.imageUrl]]
                        placeholderImage:[UIImage imageNamed:@"picture_load"]];
        cell.loadMoreLbl.text = @"";
        if ([dishEntity.isFeatureDish isEqualToString:@"1"]) {
            cell.isFeatureDish.image=[UIImage imageNamed:@"label__red"];
        }else{
            cell.isFeatureDish.image=nil;
        }
        //cell末尾箭头指示
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.activityView stopAnimating];
        
        
    } else {
        
        if (currentPage < [dishEntity.totalPage intValue]&&[dishes count]!=0) {
            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
           // cell.accessoryType = UITableViewCellAccessoryNone;
            
            cell.dishName.text=@"";
            cell.dishPriceLbl.text=@"";
            cell.dishPriceSLbl.text=@"";
            cell.moneyUnit.text=@"";
            cell.moneyUnitS.text=@"";
            cell.dishPrice.text=@"";
            cell.dishPriceS.text=@"";
            cell.dishUnit.text=@"";
            cell.dishUnitS.text=@"";
            cell.num.text=@"";
            cell.image.image = nil;
            cell.isFeatureDish.image=nil;
            cell.plusButton.hidden=YES;
            cell.minusButton.hidden=YES;
            cell.loadMoreLbl.text = @"加载更多...";
            
        }
        else if ([dishes count]==[dishEntity.totalNum intValue]&&[dishes count]!=0){
            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //cell.accessoryType = UITableViewCellAccessoryNone;
            cell.dishName.text=@"";
            cell.dishPriceLbl.text=@"";
            cell.dishPriceSLbl.text=@"";
            cell.moneyUnit.text=@"";
            cell.moneyUnitS.text=@"";
            cell.dishPrice.text=@"";
            cell.dishPriceS.text=@"";
            cell.dishUnit.text=@"";
            cell.dishUnitS.text=@"";
            cell.num.text=@"";
            cell.image.image = nil;
            cell.isFeatureDish.image=nil;
            cell.plusButton.hidden=YES;
            cell.minusButton.hidden=YES;
            cell.loadMoreLbl.text = @"";
        }
        else {
            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //cell.accessoryType = UITableViewCellAccessoryNone;
            cell.dishName.text=@"";
            cell.dishPriceLbl.text=@"";
            cell.dishPriceSLbl.text=@"";
            cell.moneyUnit.text=@"";
            cell.moneyUnitS.text=@"";
            cell.dishPrice.text=@"";
            cell.dishPriceS.text=@"";
            cell.dishUnit.text=@"";
            cell.dishUnitS.text=@"";
            cell.num.text=@"";
            cell.image.image = nil;
            cell.plusButton.hidden=YES;
            cell.minusButton.hidden=YES;
            cell.isFeatureDish.image=nil;
            cell.loadMoreLbl.text = @"该商家暂时未提供菜品预定哦";
            //cell.loadMoreLbl.text = @"附近没有商家哦";
            
        }
        
    }
    
   // NSLog(@"%d",[orderDishes count]);
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (dishEntity != nil) {
        DishCell *cell = (DishCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.row == [self.dishes count]) {
            if (currentPage==[dishEntity.totalPage intValue]) {
                
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
                return;
            }
            
            [cell.activityView startAnimating];
            [self performSelectorInBackground:@selector(loadMore)withObject:nil];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            //[cell.activityView stopAnimating];
            return;
        }else {
            

        }
    }
    //点击cell按下去的状态时背景图片变换，控制返回时图片恢复
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)loadMore
{   //当你按下这个按钮的时候, 意味着你需要看下一页了, 因此当前页码加1
    currentPage=currentPage+1;
    pageNow=[NSString stringWithFormat:@"%d",currentPage];
    
    NSMutableArray *more=[WebServices getDishInfoBySDCodeForIOS:pageNow :pageSize :resEntity.resCode];
    [self performSelectorOnMainThread:@selector(appendTableWith:) withObject:more waitUntilDone:NO];
    
    
}
-(void) appendTableWith:(NSMutableArray *)data
{   //将loadMore中的NSMutableArray添加到原来的数据源listData中.
    for (int i=0;i<[data count];i++) {
        [dishes addObject:[data objectAtIndex:i]];
    }
    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];
    for (int ind = 0; ind < [data count]; ind++) {
        NSIndexPath    *newPath =  [NSIndexPath indexPathForRow:[dishes indexOfObject:[data objectAtIndex:ind]] inSection:0];
        [insertIndexPaths addObject:newPath];
    }
    //重新调用UITableView的方法, 来生成行.
    
    [self.tableviewCustom insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
}



@end
