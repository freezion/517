//
//  WDCouponViewController.m
//  OrderAssistant
//
//  Created by Li Feng on 13-5-9.
//
//

#import "WDCouponViewController.h"
#import "QRCodeViewController.h"
#import "PersonalViewController.h"
#import "UIImageView+WebCache.h"
#import "CouponEntity.h"
#import "NewCouponCell.h"

@implementation WDCouponViewController
@synthesize couponEntity;
@synthesize couponLists;
@synthesize couArrayPicker;
@synthesize pickerCouponKind;
@synthesize btnChoiceRow;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //btnChoiceRow=0;
    self.tabBarController.delegate = self;
    couponLists = [CouponEntity getAllCouponList];
    
        
    //self.tabBarController.navigationItem.rightBarButtonItem = [self createRightItemWithImage:@"trip_bar_right" target:self Selector:@selector(chooseType:)];
    
    //    couArrayPicker=[[NSArray alloc] initWithObjects:@"餐饮", @"移动", @"生活服务",nil];
    //
    //    pickerCouponKind = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 206)];
    //    pickerCouponKind.showsSelectionIndicator=YES;
    //    pickerCouponKind.dataSource = self;
    //    pickerCouponKind.delegate = self;
    //    pickerCouponKind.tag=10;
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (self.tabBarController.selectedIndex == 0){
        self.tabBarController.title = @"优惠券";
    }else if (self.tabBarController.selectedIndex==1){
        self.tabBarController.title = @"我的收藏";
        self.tabBarController.navigationItem.rightBarButtonItem=nil;
    }
}

- (void)viewDidAppear:(BOOL)animated {
	
    //    if (self.tabBarController.selectedIndex==0) {
    //        self.tabBarController.selectedIndex=0;
    //        self.tabBarController.navigationItem.rightBarButtonItem = [self createRightItemWithImage:@"trip_bar_right" target:self Selector:@selector(chooseType:)];
    //    }
    //    if (self.tabBarController.selectedIndex==1) {
    //        self.tabBarController.selectedIndex=1;
    //        self.tabBarController.navigationItem.rightBarButtonItem = nil;
    //    }
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
    //qrCodeViewController.btnType=@"1";
    //[self.navigationController pushViewController:qrCodeViewController animated:YES];
    
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


- (void) toQRCodeViewController:(PersonalViewController *) viewController{
    [viewController dismissModalViewControllerAnimated:YES];
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    EventDetailViewController *qrCodeViewController = [storyborad instantiateViewControllerWithIdentifier:@"EventDetailViewController"];
    qrCodeViewController.entity = couponEntity;
    //qrCodeViewController.btnType=@"1";
    [self.navigationController pushViewController:qrCodeViewController animated:YES];
    
}

-(UIBarButtonItem*)createRightItemWithImage:(NSString *)imageName target:(id)target Selector:(SEL)sel
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 31);
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    if (imageName && imageName.length != 0) {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setTitle:@"分类" forState:UIControlStateNormal];
        //[btn setTitle:@"收藏" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont fontWithName:@"Kailasa" size:13];
    } else {
        [btn setTitle:@"分类" forState:UIControlStateNormal];
    }
    [btn sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return rightItem;
}


-(void)chooseType:(id)sender{
    
    self.tableView.contentOffset = CGPointMake(0, 0);
    
    CGRect toolbarTargetFrame=CGRectMake(0, self.view.bounds.size.height-260, self.view.bounds.size.width, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height - 216, self.view.bounds.size.width, 216);
    //    CGRect toolbarTargetFrame=CGRectMake(0, self.view.bounds.size.height-204, self.view.bounds.size.width, 44);
    //    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height - 160, self.view.bounds.size.width, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    darkView.alpha = 0;//设置透明的view
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPicker)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    //btnChoiceDistanceRow=[pickerDistant selectedRowInComponent:0];
    NSLog(@"%d",btnChoiceRow);
    
    [pickerCouponKind selectRow:btnChoiceRow inComponent:0 animated:YES];
    
    
    [self.view addSubview:pickerCouponKind];
    
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissPicker)];
    
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2];//使PickerView控件从底部升起动画的时间为0.2秒
    //使PickerView控件从底部升起动画
    [pickerCouponKind setFrame:CGRectMake(0.0, self.view.frame.size.height, pickerCouponKind.frame.size.width, pickerCouponKind.frame.size.height)];
    
    toolBar.frame = toolbarTargetFrame;
    pickerCouponKind.frame = datePickerTargetFrame;
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
    
    couponLists=[WebServices getCouponsByType: [NSString stringWithFormat:@"%d",btnChoiceRow]];
    [self.tableView reloadData];
}

- (void)removeViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
}

#pragma mark -
#pragma mark Picker Data Source Methods
// 返回显示的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}
// 返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [couArrayPicker count];
}
// 设置当前行的内容，若果行没有显示则自动释放
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [couArrayPicker objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // result = [couArrayPicker objectAtIndex:row];
    if (pickerView==pickerCouponKind) {
        //记住pickerView所选中的行的索引
        btnChoiceRow=[pickerCouponKind selectedRowInComponent:0];
        //NSLog(@"%d",btnChoiceRow);
    }
    
    
}


@end
