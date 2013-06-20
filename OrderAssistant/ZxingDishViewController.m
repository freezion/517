//
//  ZxingDishViewController.m
//  OrderAssistant
//
//  Created by Li Feng on 13-6-8.
//
//

#import "ZxingDishViewController.h"
#import "UIImageView+WebCache.h"

@implementation ZxingDishViewController

@synthesize dishEntity;
@synthesize dishes;
@synthesize pageNow;
@synthesize pageSize;
@synthesize currentPage;
@synthesize SDCode;
@synthesize tableviewCustom;
//@synthesize codeType;
@synthesize menuList;
@synthesize pickDateArray;
@synthesize pickDateCodeArray;
@synthesize dishMenu;
@synthesize menuPicker;
@synthesize btnChoice_menuRow;
@synthesize btnChoose;
@synthesize distanceBtn;
@synthesize dishJSonArray;
@synthesize roomJSonStr;
@synthesize dishJSonStr;
@synthesize codeArray;
@synthesize addAppointmentResult;
@synthesize submitType;
@synthesize resEntity;
@synthesize status;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"菜单";
    
    btnChoose=10;
    currentPage=1;
    pageSize=@"10";
    pageNow=[NSString stringWithFormat:@"%d",currentPage];
    
    menuPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 206)];
    menuPicker.showsSelectionIndicator=YES;
    menuPicker.dataSource = self;
    menuPicker.delegate = self;
    menuPicker.tag=10;
    
    UIButton *appBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [[UIImage imageNamed:@"trip_bar_right"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    [appBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [appBtn setTitle:@"查看" forState:UIControlStateNormal];
    appBtn.titleLabel.font=[UIFont fontWithName:@"Kailasa" size:13];
    CGRect appBtnFrame = [appBtn frame];
    appBtnFrame.size.width = buttonImage.size.width;
    appBtnFrame.size.height = buttonImage.size.height;
    [appBtn setFrame:appBtnFrame];
    [appBtn addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithCustomView:appBtn];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *submitBtnImage = [[UIImage imageNamed:@"trip_bar_right"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    [submitButton setBackgroundImage:submitBtnImage forState:UIControlStateNormal];
    [submitButton setTitle:@"预定" forState:UIControlStateNormal];
    submitButton.titleLabel.font=[UIFont fontWithName:@"Kailasa" size:13];
    CGRect submitBtnFrame = [submitButton frame];
    submitBtnFrame.size.width = submitBtnImage.size.width;
    submitBtnFrame.size.height = submitBtnImage.size.height;
    [submitButton setFrame:submitBtnFrame];
    [submitButton addTarget:self action:@selector(submitAppointment) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton2 = [[UIBarButtonItem alloc] initWithCustomView:submitButton];
    
    NSArray *buttonArray = [[NSArray alloc] initWithObjects:rightButton2,rightButton1 ,nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
    
    distanceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [distanceBtn setFrame:CGRectMake(255, 360, 45, 45)];
    [distanceBtn setBackgroundImage:[UIImage imageNamed:@"distanceChoose"] forState:UIControlStateNormal];
    [distanceBtn addTarget:self action:@selector(showAction_menu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:distanceBtn];
 
    [DishEntity deleteAllDish];
    [DishMenu deleteAllMenu];
    if ([submitType isEqualToString:@"0"]) {
        [self getmenuPickerDate];
    }else{
        [self getShopDish];
    }
    for (int i=0; i<[pickDateCodeArray count]; i++) {
        NSString *menuCode=[pickDateCodeArray objectAtIndex:i];
        [WebServices getDishInfoByMenuCode:menuCode];
    }
    dishes=[DishEntity getAllDish];
    
}

-(void) getShopDish{
    pickDateArray=[[NSMutableArray alloc] init];
    pickDateCodeArray=[[NSMutableArray alloc] init];
    [WebServices getMenuInfoBySDCode:resEntity.resCode];
    
    menuList=[DishMenu getAllMenu];
    for (int i=0; i<[menuList count]; i++) {
        dishMenu = [self.menuList objectAtIndex:i];
        [pickDateArray addObject:dishMenu.menuName];
        [pickDateCodeArray addObject:dishMenu.menuCode];
    }
}
-(void) getmenuPickerDate{
    pickDateArray=[[NSMutableArray alloc] init];
    pickDateCodeArray=[[NSMutableArray alloc] init];
    [WebServices getMenuInfoBySDCode:[codeArray objectAtIndex:1]];
    
    menuList=[DishMenu getAllMenu];
    for (int i=0; i<[menuList count]; i++) {
        dishMenu = [self.menuList objectAtIndex:i];
        [pickDateArray addObject:dishMenu.menuName];
        [pickDateCodeArray addObject:dishMenu.menuCode];
    }
}
- (void) check{
    
    dishes=[DishEntity selectOrderDish];
    self.btnChoose=5;
    [self.tableviewCustom reloadData];
    self.navigationItem.title=@"已选菜单";

}
- (void)submitAppointment{
    dishes=[DishEntity selectOrderDish];
    if ([dishes count]==0) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"您还未选择菜品" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alert show];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"确认提交菜单？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag=9;
        [alert show];
    }

}
- (void) addAppointment{
    
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM"];
    NSString* sysDate = [formatter stringFromDate:date];
    [formatter setDateFormat:@"HH:MM"];
    NSString *sysTime=[formatter stringFromDate:date];
    
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
        
    dishJSonArray=[[NSMutableArray alloc] init];
    for (int i=0; i<[dishes count]; i++) {
        dishEntity=[self.dishes objectAtIndex:i];
        NSDictionary *jsonDic=[NSDictionary dictionaryWithObjectsAndKeys:
                               dishEntity.dishCode,@"dishCode",
                               dishEntity.dishName,@"dishName",
                               dishEntity.dishPrice,@"dishPrice",
                               dishEntity.num,@"dishNum",
                               nil];
        [dishJSonArray addObject:jsonDic];
    }
    
    NSError *error;
//    NSData *dishJsonData = [NSJSONSerialization dataWithJSONObject:dishJSonArray
//                                                           options:NSJSONWritingPrettyPrinted error:&error];
//    dishJSonStr= [[NSString alloc] initWithData:dishJsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *roomJsonDic=[NSDictionary dictionaryWithObjectsAndKeys:
                                [codeArray objectAtIndex:2],@"roomCode",
                                [codeArray objectAtIndex:3],@"tableNum",
                                nil];
    NSLog(@"%@",roomJsonDic);
    
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [usernamepasswordKVPairs objectForKey:KEY_CCODE], @"CCode",
                                    [codeArray objectAtIndex:1], @"sdCode",
                                    sysDate, @"appDate",
                                    sysTime, @"arriveTime",
                                    @"", @"appCustomerCount",
                                    @"", @"name",
                                    [usernamepasswordKVPairs objectForKey:KEY_USERID], @"phone",
                                    @"", @"isProxyDrive",
                                    @"", @"isPark",
                                    @"", @"sex",
                                    @"", @"appTableCount",
                                    dishJSonArray,@"dishList",
                                    roomJsonDic,@"room",
                                    nil,@"eventCode",
                                    nil, @"way",
                                    nil];
    //NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //NSLog(@"%@",jsonString);
    addAppointmentResult=[WebServices addAppointmentForPhone:jsonString];
    
    if ([addAppointmentResult isEqualToString:@"false"]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"预约失败，请重新操作" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if ([addAppointmentResult isEqualToString:@"true"]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"预约成功" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        alert.tag=11;
        [alert show];
    }
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
                if ([submitType isEqualToString:@"0"]) {
                    [self addAppointment];
                }else{
                    //点击预定后进入预定信息的填写页面
                    [self gotoAddAppointment];
                }
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
    if (alertView.tag==11) {
        
        if (buttonIndex==alertView.cancelButtonIndex) {
            [self dismissModalViewControllerAnimated:YES];
        }
    }
}
- (void) dismissViewController:(PersonalViewController *) viewController {
    [viewController dismissModalViewControllerAnimated:YES];
    if ([submitType isEqualToString:@"0"]) {
        status=2;
    }else{
        status=1;
    }
}
- (void) dismissAddappointmentViewController:(AddAppointmentViewController *) viewController {
    [viewController dismissModalViewControllerAnimated:YES];    
    status = 0;
}

- (void) viewDidAppear:(BOOL)animated {
    if (status == 1) {
        [self gotoAddAppointment];
    }else{
        
    }
}

- (void) gotoAddAppointment{
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    AddAppointmentViewController *addAppointmentViewController = [storyborad instantiateViewControllerWithIdentifier:@"AddAppointmentViewController"];
    UINavigationController *navController=[[UINavigationController alloc] initWithRootViewController:addAppointmentViewController];
    addAppointmentViewController.resEntity=resEntity;
    addAppointmentViewController.orderDishList=self.dishes;
    addAppointmentViewController.appType=@"1";
    addAppointmentViewController.addAppoint_delegate = self;
    [self presentModalViewController:navController animated:YES];
}

- (void) showAction_menu {

    self.btnChoose=0;
    self.navigationItem.title=@"菜单";
    
    CGRect toolbarTargetFrame=CGRectMake(0, self.view.bounds.size.height-260, self.view.bounds.size.width, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height - 216, self.view.bounds.size.width, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    darkView.alpha = 0;//设置透明的view
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPicker)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    [menuPicker selectRow:btnChoice_menuRow inComponent:0 animated:YES];
    [self.view addSubview:menuPicker];
    
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    // UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissPicker)];
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonSystemItemDone target:self action:@selector(dismissPicker)];
    
    
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2];//使PickerView控件从底部升起动画的时间为0.2秒
    //使PickerView控件从底部升起动画
    [menuPicker setFrame:CGRectMake(0.0, self.view.frame.size.height, menuPicker.frame.size.width, menuPicker.frame.size.height)];
    
    toolBar.frame = toolbarTargetFrame;
    menuPicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.5;
    [UIView commitAnimations];
}

- (void)dismissPicker {
    //控制pickerview下降
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.2];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
    
    NSString *menuCode=[pickDateCodeArray objectAtIndex:btnChoice_menuRow];
    //NSLog(@"%@",menuCode);
    dishes=[DishEntity selectMenuDish:menuCode];
    [self.tableviewCustom reloadData];
    tableviewCustom.contentOffset = CGPointMake(0, 0);
    
}


- (void)removeViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
}

//- (void) dismissViewController:(PersonalViewController *) viewController{
//    
//}
- (IBAction)plusDish:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableviewCustom];
    NSIndexPath *indexPath = [self.tableviewCustom indexPathForRowAtPoint:buttonPosition];
    if (indexPath != nil)
    {
        DishEntity *dishEntityChoose = [self.dishes objectAtIndex:indexPath.row];
        CodeDishCell *cell = (CodeDishCell *) [self.tableviewCustom cellForRowAtIndexPath:indexPath];
        cell.num.text = [NSString stringWithFormat:@"%d", [cell.num.text intValue] + 1];
        
        [DishEntity updateDish:cell.num.text :dishEntityChoose.dishCode];
        //NSLog(@"%d",self.benChoose);
        if (btnChoose==10) {
            dishes=[DishEntity getAllDish];
        }else if (btnChoose==0){
            NSString *menuCode=[pickDateCodeArray objectAtIndex:btnChoice_menuRow];
            //NSLog(@"%@",menuCode);
            dishes=[DishEntity selectMenuDish:menuCode];
        }else{
            dishes=[DishEntity selectOrderDish];
        }
        
        [self.tableviewCustom reloadData];
        
    }
}
- (IBAction)minusDish:(id)sender{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableviewCustom];
    NSIndexPath *indexPath = [self.tableviewCustom indexPathForRowAtPoint:buttonPosition];
    if (indexPath != nil)
    {
        DishEntity *dishEntityChoose = [self.dishes objectAtIndex:indexPath.row];
        CodeDishCell *cell = (CodeDishCell *) [self.tableviewCustom cellForRowAtIndexPath:indexPath];
        
        if ([cell.num.text intValue]>0) {
            cell.num.text = [NSString stringWithFormat:@"%d", [cell.num.text intValue] - 1];
            
            [DishEntity updateDish:cell.num.text :dishEntityChoose.dishCode];
            
            if (btnChoose==10) {
                dishes=[DishEntity getAllDish];
            }else if (btnChoose==0){
                NSString *menuCode=[pickDateCodeArray objectAtIndex:btnChoice_menuRow];
                //NSLog(@"%@",menuCode);
                dishes=[DishEntity selectMenuDish:menuCode];
            }else{
                dishes=[DishEntity selectOrderDish];
            }
            
            [self.tableviewCustom reloadData];
        }
    
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
//    if ([self.dishes count] == 0){
//		return 1;
//	}else {
//		// Add an object to the end of the array for the \"Load more...\" table cell.
//		return [self.dishes count] + 1;
//	}
    return [dishes count];
	// Return the number of rows as there are in the resentities array.
	//return [self.resentities count];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    int size = 67;
//    if (indexPath.row < [dishes count]) {
//        size = 67;
//    }else {
//        size = 50;
//    }
//    return size;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CodeDishCell";
    CodeDishCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    dishEntity = [self.dishes objectAtIndex:indexPath.row];
    cell.dishName.text=dishEntity.dishName;
    cell.dishPriceLbl.text=@"价格:";
    cell.moneyUnit.text=@"元/";
    cell.dishPrice.text=dishEntity.dishPrice;
    cell.dishUnit.text=dishEntity.dishUnit;
    cell.num.text=dishEntity.num;
    
    cell.plusButton.hidden=NO;
    cell.minusButton.hidden=NO;
    [cell.image setImageWithURL:[NSURL URLWithString:[WEBSITE_URL stringByAppendingString:dishEntity.imageUrl]]
               placeholderImage:[UIImage imageNamed:@"picture_load"]];
    
    cell.loadMoreLbl.text = @"";
    if ([dishEntity.isFeatureDish isEqualToString:@"1"]) {

        cell.isFeatureDish.image=[UIImage imageNamed:@"label__red"];
        
    }else{
        cell.isFeatureDish.image=nil;
    }
    //[cell.activityView stopAnimating];
    
    
//    if (indexPath.row < [dishes count]) {
//        
//        dishEntity = [self.dishes objectAtIndex:indexPath.row];
//        cell.dishName.text=dishEntity.dishName;
//        cell.dishPriceLbl.text=@"价格:";
//        cell.moneyUnit.text=@"元/";
//        cell.dishPrice.text=dishEntity.dishPrice;
//        cell.dishUnit.text=dishEntity.dishUnit;
//        cell.num.text=dishEntity.num;
//        // NSLog(@"%@",dishEntity.num);
////        if ([cell.num.text intValue]>0) {
////            [orderDishes addObject:dishEntity];
////        }
//        
//        cell.plusButton.hidden=NO;
//        cell.minusButton.hidden=NO;
//        [cell.image setImageWithURL:[NSURL URLWithString:[WEBSITE_URL stringByAppendingString:dishEntity.imageUrl]]
//                   placeholderImage:[UIImage imageNamed:@"picture_load"]];
//        
//        cell.loadMoreLbl.text = @"";
//        if ([dishEntity.isFeatureDish isEqualToString:@"1"]) {
//            //cell.isFeatureDish.hidden=NO;
//            cell.isFeatureDish.image=[UIImage imageNamed:@"label__red"];
//            
//        }else{
//            cell.isFeatureDish.image=nil;
//        }
//        //cell末尾箭头指示
//        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        [cell.activityView stopAnimating];
//    } else {
//        
//        if (currentPage < [dishEntity.totalPage intValue]&&[dishes count]!=0) {
//            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            
//            cell.dishName.text=@"";
//            cell.dishPriceLbl.text=@"";
//            cell.moneyUnit.text=@"";
//            cell.dishPrice.text=@"";
//            cell.dishUnit.text=@"";
//            cell.num.text=@"";
//            cell.plusButton.hidden=YES;
//            cell.minusButton.hidden=YES;
//            cell.image.image=nil;
//            cell.isFeatureDish.image=nil;
//            cell.loadMoreLbl.text = @"加载更多...";
//            
//        }
//        else if ([dishes count]==[dishEntity.totalNum intValue]&&[dishes count]!=0){
//            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            cell.dishName.text=@"";
//            cell.dishPriceLbl.text=@"";
//            cell.moneyUnit.text=@"";
//            cell.dishPrice.text=@"";
//            cell.dishUnit.text=@"";
//            cell.num.text=@"";
//            cell.plusButton.hidden=YES;
//            cell.minusButton.hidden=YES;
//            cell.image.image=nil;
//            cell.isFeatureDish.image=nil;
//            cell.loadMoreLbl.text = @"";
//        }
//        else if ([dishes count]==0){
//            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            cell.dishName.text=@"";
//            cell.dishPriceLbl.text=@"";
//            cell.moneyUnit.text=@"";
//            cell.dishPrice.text=@"";
//            cell.dishUnit.text=@"";
//            cell.num.text=@"";
//            cell.plusButton.hidden=YES;
//            cell.minusButton.hidden=YES;
//            cell.image.image=nil;
//            cell.isFeatureDish.image=nil;
//            cell.loadMoreLbl.text = @"抱歉，该商家未提供菜品";
//            
//        }else{
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            cell.dishName.text=@"";
//            cell.dishPriceLbl.text=@"";
//            cell.moneyUnit.text=@"";
//            cell.dishPrice.text=@"";
//            cell.dishUnit.text=@"";
//            cell.num.text=@"";
//            cell.plusButton.hidden=YES;
//            cell.minusButton.hidden=YES;
//            cell.image.image=nil;
//            cell.isFeatureDish.image=nil;
//            cell.loadMoreLbl.text = @"";
//        }
        
//    }
    return cell;
    
}

#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    if (dishEntity != nil) {
//        CodeDishCell *cell = (CodeDishCell *)[tableView cellForRowAtIndexPath:indexPath];
//        if (indexPath.row == [self.dishes count]) {
//            if (currentPage==[dishEntity.totalPage intValue]) {
//                
//                cell.selectionStyle=UITableViewCellSelectionStyleNone;
//                
//                return;
//            }
//            
//            [cell.activityView startAnimating];
//            [self performSelectorInBackground:@selector(loadMore)withObject:nil];
//            [tableView deselectRowAtIndexPath:indexPath animated:YES];
//            //[cell.activityView stopAnimating];
//            return;
//        }
//    }
//    //点击cell按下去的状态时背景图片变换，控制返回时图片恢复
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

-(void)loadMore
{
    
    //当你按下这个按钮的时候, 意味着你需要看下一页了, 因此当前页码加1
    currentPage=currentPage+1;
    pageNow=[NSString stringWithFormat:@"%d",currentPage];
    NSMutableArray *more=[[NSMutableArray alloc] init];
    more=[WebServices getDishInfoBySDCodeForIOS:pageNow :pageSize :SDCode];
    
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

#pragma mark -
#pragma mark Picker Data Source Methods
// 返回显示的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
// 返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [pickDateArray count];
    
}
// 设置当前行的内容，若果行没有显示则自动释放
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [pickDateArray objectAtIndex:row];
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // result = [pickDateArray objectAtIndex:row];
    if (pickerView==menuPicker) {
        //记住pickerView所选中的行的索引
        btnChoice_menuRow=[menuPicker selectedRowInComponent:0];
        
        
    }
    
}

@end
