//
//  ArrResViewController.m
//  OrderAssistant
//
//  Created by flybird on 12-10-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ArrResViewController.h"
#import "PopoverView.h"
#import "MenuView.h"
#import "WebServices.h"
#import "CommonUtil.h"
#import "UIImageView+WebCache.h"
//#import "SDWebImage/UIImageView+WebCache.h"

#import "ResDetailViewController.h"
#import "PersonalViewController.h"
#import "PersonalInformationViewController.h"
#import "RegisterViewController.h"
#import "MainViewController.h"
#import "SwitchTabBarViewController.h"
#import "SearchViewController.h"
#import "ZxingDishViewController.h"




@interface ArrResViewController()

@end

@implementation ArrResViewController{
   // UIButton *button;

    UITextField *searchText;
}


@synthesize rescell;
@synthesize resEntity;
@synthesize resentities;
@synthesize tableviewCustom;

//@synthesize myPickerData1;
//@synthesize myPickerData2;
@synthesize actionSheet;
@synthesize result;
@synthesize btnChoice;
@synthesize curLocation;
@synthesize locationManager;

@synthesize curLad;
@synthesize curLgd;
@synthesize pageNow;
@synthesize pageSize;
@synthesize currentPage;
@synthesize btnChoice_DistanceRow;
@synthesize btnChoice_CookingRow;
@synthesize btnChoice_CookingSubRow;
@synthesize btnChoice_AreaRow;
@synthesize shopKindCode;

@synthesize picker_distant;
@synthesize picker_area;
@synthesize picker_cooking;

@synthesize status;

@synthesize shopListCode;
@synthesize shopType;
@synthesize cookingStyleBtn;
@synthesize businessAreaBtn;
@synthesize distanceBtn;
@synthesize cookingStyleLable;
@synthesize businessAreaLable;
@synthesize distanceLable;
@synthesize distantText;
@synthesize areaEntity;
@synthesize cookEntity;
@synthesize areaLists;
@synthesize cookStyleLists;
@synthesize pickDateArray;
@synthesize subPickDateArray;
//@synthesize pickerType;
@synthesize dicPicker;
@synthesize pickDateCodeArray;
@synthesize subPickDateCodeArray;


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
    
        
    self.tabBarController.navigationItem.rightBarButtonItem = [self createRightItemWithImage:@"trip_bar_right" target:self Selector:@selector(searchBtn:)];

    
    self.navigationItem.title=@"餐厅";
    distantText=@"0.5";

    
    [self getCurPosition];
    [self locationManager];
    //curLad=@"119.962";
    //curLgd=@"31.783";
    currentPage=1;   
    btnChoice_DistanceRow=0;
    btnChoice_CookingRow=0;
    shopKindCode=@"c3b304a3495041d8b7b4181c49112df9";
    pageNow=[NSString stringWithFormat:@"%d",currentPage];  
    pageSize=@"10";
    
    self.tabBarController.delegate = self;
    
    picker_distant = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 206)];
    picker_distant.showsSelectionIndicator=YES;
    picker_distant.dataSource = self;
    picker_distant.delegate = self;
    picker_distant.tag=10;
    
    picker_area = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 206)];
    picker_area.showsSelectionIndicator=YES;
    picker_area.dataSource = self;
    picker_area.delegate = self;
    picker_area.tag=10;
    
    picker_cooking = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 206)];
    picker_cooking.showsSelectionIndicator=YES;
    picker_cooking.dataSource = self;
    picker_cooking.delegate = self;
    picker_cooking.tag=10;
    

    [cookingStyleBtn addTarget:self action:@selector(showAction_cooking) forControlEvents:UIControlEventTouchUpInside];
    [businessAreaBtn addTarget:self action:@selector(showAction_area) forControlEvents:UIControlEventTouchUpInside];
    [distanceBtn addTarget:self action:@selector(showAction_distance) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton *distancebutton=[UIButton buttonWithType:UIButtonTypeCustom];
//    [distancebutton setFrame:CGRectMake(255, 320, 45, 45)];
//    //cardButton.tag=tagNum;
//    [distancebutton setBackgroundImage:[UIImage imageNamed:@"label__red"] forState:UIControlStateNormal];
//    [distancebutton addTarget:self action:@selector(showAction_menu) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:distancebutton];
   
}

-(void)searchBtn:(id)sender{
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"快捷搜索" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=5;
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    searchText=[alert textFieldAtIndex:0];
    searchText.placeholder=@"请输入您需要搜索的关键字";
    //searchText.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==5) {
        if (buttonIndex==1){
            if (!(searchText.text==nil||[@"" isEqualToString:searchText.text])){
                resentities= [WebServices getShopsBySDName:searchText.text];
                [self.tableviewCustom reloadData];
            }
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload]; // Release any retained subviews of the main view.
    
}
//- (void)viewWillAppear:(BOOL)animated{
//    
//}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (self.tabBarController.selectedIndex == 0) {
        self.tabBarController.title = @"餐厅";
        //self.navigationController.navigationBar.topItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:appBtn];
        self.tabBarController.navigationItem.rightBarButtonItem = [self createRightItemWithImage:@"trip_bar_right" target:self Selector:@selector(searchBtn:)];
       
    }
    if (self.tabBarController.selectedIndex == 1) {
        self.navigationController.navigationBar.topItem.rightBarButtonItem = nil;
        self.tabBarController.title = @"个人";
        
        NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
        NSString *userName=[usernamepasswordKVPairs objectForKey:KEY_USERID];
        if (userName==nil) {
            self.tabBarController.selectedIndex=0;
            self.tabBarController.title = @"餐厅";
            
            UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            personalViewController = [storyborad instantiateViewControllerWithIdentifier:@"PersonalViewController"];
            UINavigationController *navPersonalViewController=[[UINavigationController alloc] initWithRootViewController:personalViewController];      
            
            [self presentModalViewController:navPersonalViewController animated:NO];
        }
        if (userName!=nil) {
            self.tabBarController.selectedIndex=1;
            
        }
    }
}



//获得自己的当前的位置信息
- (void) getCurPosition
{
	//开始探测自己的位置
	if (locationManager == nil)
	{
		locationManager =[[CLLocationManager alloc] init];
	}
	
	if ([CLLocationManager locationServicesEnabled])
	{
		locationManager.delegate = self;
		locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
		[locationManager startUpdatingLocation];
	}
}
//响应当前位置的更新，在这里记录最新的当前位置
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
			fromLocation:(CLLocation *)oldLocation
{
    NSTimeInterval interval = [newLocation.timestamp timeIntervalSinceDate:oldLocation.timestamp];
    NSLog(@"%lf", interval);
    //保存新位置
    curLocation = newLocation.coordinate;
    if (oldLocation == nil) {
        curLad=[NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
        curLgd=[NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
        NSLog(@"latitude === %@", curLad);
        NSLog(@"longitude === %@", curLgd);
        
        
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.dimBackground = YES;
        [HUD setDelegate:self];
        
        shopType=((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode;
        if ([shopType isEqualToString:@"1"]) {
            [HUD setLabelText:@"定位中..."];
            [HUD showWhileExecuting:@selector(getShop) onTarget:self withObject:nil animated:YES];
        }else{
            //button.hidden=YES;
            [HUD setLabelText:@"努力加载中..."];
            [HUD showWhileExecuting:@selector(getShopList) onTarget:self withObject:nil animated:YES];
            
        }
    }
}

- (void)getShopList{
    
    shopListCode=((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode;
    
    
    NSLog(@"%@",shopListCode);
//    if (shopListCode!=nil) {
//        resentities=[WebServices getShopsForIOS:pageNow :pageSize :shopListCode];
//        
//    }else{
//        resentities=[WebServices getShopDetailInfoByIsRecommedForIOS:pageNow :pageSize];
//    }
    if (shopListCode!=nil) {
        if ([shopListCode isEqualToString:@"wanda"]) {
            resentities=[WebServices getShopsByArea:@"0"];
        }else if ([shopListCode isEqualToString:@"changfa"]){
            resentities=[WebServices getShopsByArea:@"1"];
        }else if ([shopListCode isEqualToString:@"party"]){
            resentities=[WebServices getShopDetailsByEtCode:@"0"];
        }else if ([shopListCode isEqualToString:@"meeting"]){
            resentities=[WebServices getShopDetailsByEtCode:@"1"];
        }else if ([shopListCode isEqualToString:@"self"]){
            resentities=[WebServices getShopDetailsByEtCode:@"2"];
        }
    }else{
        resentities=[WebServices getShopDetailInfoByIsRecommedForIOS:pageNow :pageSize];
    }
    
    [self.tableviewCustom reloadData];
    //reloadData后UITableView回到顶部
    //tableviewCustom.contentOffset = CGPointMake(0, 0);
}

- (void)getShop {
    resentities=[WebServices getNearShopForIOS:pageNow :pageSize :curLad :curLgd :distantText];
    [self.tableviewCustom reloadData];
    //reloadData后UITableView回到顶部
    tableviewCustom.contentOffset = CGPointMake(0, 0);
}



- (void)viewDidAppear:(BOOL)animated {
	// Get all regions being monitored for this application.
    
    
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
    NSString *userName=[usernamepasswordKVPairs objectForKey:KEY_USERID];
    if (userName==nil) {
        self.tabBarController.selectedIndex=0;
        self.tabBarController.navigationItem.rightBarButtonItem = [self createRightItemWithImage:@"trip_bar_right" target:self Selector:@selector(searchBtn:)];
    }else {
        if (personalViewController.loadKey!=nil) {
            self.tabBarController.selectedIndex=1;
            self.tabBarController.navigationItem.rightBarButtonItem = nil;
            self.tabBarController.title = @"个人";
            personalViewController.loadKey=nil;
        }else {
            if (self.tabBarController.selectedIndex==0) {
                self.tabBarController.selectedIndex=0;
                self.tabBarController.navigationItem.rightBarButtonItem = [self createRightItemWithImage:@"trip_bar_right" target:self Selector:@selector(searchBtn:)];
            }
            if (self.tabBarController.selectedIndex==1) {
                self.tabBarController.selectedIndex=1;
                self.tabBarController.navigationItem.rightBarButtonItem = nil;
            }
        }
    }
    
    
}

-(UIBarButtonItem*)createRightItemWithImage:(NSString *)imageName target:(id)target Selector:(SEL)sel
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    if (imageName && imageName.length != 0) {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setTitle:@"搜索" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont fontWithName:@"Kailasa" size:13];
    } else {
        //[btn setTitle:@"分类" forState:UIControlStateNormal];
    }
    [btn sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return rightItem;
}

- (void) showAction_distance {
    btnChoice=2;
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"0.5",@"1", @"5", @"6",@"8", nil];
    pickDateArray=[[NSMutableArray alloc] initWithArray:array];
    
    CGRect toolbarTargetFrame=CGRectMake(0, self.view.bounds.size.height-260, self.view.bounds.size.width, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height - 216, self.view.bounds.size.width, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    darkView.alpha = 0;//设置透明的view
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPicker)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    //btnChoiceDistanceRow=[pickerDistant selectedRowInComponent:0];
    NSLog(@"%d",btnChoice_DistanceRow);
    
    [picker_distant selectRow:btnChoice_DistanceRow inComponent:0 animated:YES];

    
    [self.view addSubview:picker_distant];

    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissPicker)];
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonSystemItemDone target:self action:@selector(dismissPicker)];

    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2];//使PickerView控件从底部升起动画的时间为0.2秒
    //使PickerView控件从底部升起动画
    [picker_distant setFrame:CGRectMake(0.0, self.view.frame.size.height, picker_distant.frame.size.width, picker_distant.frame.size.height)];
    
    toolBar.frame = toolbarTargetFrame;
    picker_distant.frame = datePickerTargetFrame;
    darkView.alpha = 0.5;
    [UIView commitAnimations];
}
- (void) showAction_area {
    btnChoice=1;
    pickDateArray=[[NSMutableArray alloc] init];
    pickDateCodeArray=[[NSMutableArray alloc] init];
    areaLists=[WebServices getAreaInfo];
    for (int i=0; i<[areaLists count]; i++) {
        areaEntity = [self.areaLists objectAtIndex:i];
        [pickDateArray addObject:areaEntity.areaName];
        [pickDateCodeArray addObject:areaEntity.areaCode];
    }
    
    NSLog(@"%d",[pickDateArray count]);
    
    
    CGRect toolbarTargetFrame=CGRectMake(0, self.view.bounds.size.height-260, self.view.bounds.size.width, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height - 216, self.view.bounds.size.width, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    darkView.alpha = 0;//设置透明的view
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPicker)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
        
    [picker_area selectRow:btnChoice_AreaRow inComponent:0 animated:YES];
    [self.view addSubview:picker_area];
    
    
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
    [picker_area setFrame:CGRectMake(0.0, self.view.frame.size.height, picker_area.frame.size.width, picker_area.frame.size.height)];
    
    toolBar.frame = toolbarTargetFrame;
    picker_area.frame = datePickerTargetFrame;
    darkView.alpha = 0.5;
    [UIView commitAnimations];
}
- (void) showAction_cooking {
    
    btnChoice=0;
    pickDateArray=[[NSMutableArray alloc] init];
    pickDateCodeArray=[[NSMutableArray alloc] init];
    subPickDateArray=[[NSMutableArray alloc] init];
    
    cookStyleLists=[WebServices getFlavorInfo];
    for (int i=0; i<[cookStyleLists count]; i++) {
        cookEntity=[self.cookStyleLists objectAtIndex:i];
        if ([cookEntity.parent isEqualToString:@"0"]) {
            [pickDateArray addObject:cookEntity.cookName];
            [pickDateCodeArray addObject:cookEntity.cookCode];
        }
    }
    for (int i=0; i<[cookStyleLists count]; i++) {
        cookEntity=[self.cookStyleLists objectAtIndex:i];
        if ([cookEntity.parent isEqualToString:[pickDateCodeArray objectAtIndex:0]]) {
            [subPickDateArray addObject:cookEntity.cookName];
        }
    }
    

    
    CGRect toolbarTargetFrame=CGRectMake(0, self.view.bounds.size.height-260, self.view.bounds.size.width, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height - 216, self.view.bounds.size.width, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    darkView.alpha = 0;//设置透明的view
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPicker)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    [picker_cooking selectRow:btnChoice_CookingRow inComponent:0 animated:YES];
    [self.view addSubview:picker_cooking];
    
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissPicker)];
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonSystemItemDone target:self action:@selector(dismissPicker)];
    
    
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2];//使PickerView控件从底部升起动画的时间为0.2秒
    //使PickerView控件从底部升起动画
    [picker_cooking setFrame:CGRectMake(0.0, self.view.frame.size.height, picker_cooking.frame.size.width, picker_cooking.frame.size.height)];
    
    toolBar.frame = toolbarTargetFrame;
    picker_cooking.frame = datePickerTargetFrame;
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
    
    if (btnChoice==0) {
        currentPage=1;
        pageNow=[NSString stringWithFormat:@"%d",currentPage];
        NSLog(@"%@",[subPickDateCodeArray objectAtIndex:btnChoice_CookingSubRow]);
        resentities=[WebServices getShopListByPSConditionForIos :pageNow :pageSize :curLgd :curLad :@"1" :[subPickDateCodeArray objectAtIndex:btnChoice_CookingSubRow] :@""];
        [self.tableviewCustom reloadData];
        tableviewCustom.contentOffset = CGPointMake(0, 0);
    }
    if (btnChoice==1){
        currentPage=1;
        pageNow=[NSString stringWithFormat:@"%d",currentPage];
        if ([subPickDateArray count]==0) {
            resentities=[WebServices getShopListByPSConditionForIos :pageNow :pageSize :curLgd :curLad :@"" :@"" :[pickDateCodeArray objectAtIndex:btnChoice_AreaRow]];
        }else{
            resentities=[WebServices getShopListByPSConditionForIos :pageNow :pageSize :curLgd :curLad :@"" :[subPickDateCodeArray objectAtIndex:btnChoice_CookingSubRow] :[pickDateCodeArray objectAtIndex:btnChoice_AreaRow]];
        }
        
        [self.tableviewCustom reloadData];
        tableviewCustom.contentOffset = CGPointMake(0, 0);
    }
    if (btnChoice==2) {
        currentPage=1;
        pageNow=[NSString stringWithFormat:@"%d",currentPage];
        if ([subPickDateArray count]==0) {
            resentities=[WebServices getShopListByPSConditionForIos :pageNow :pageSize :curLgd :curLad :[pickDateArray objectAtIndex:btnChoice_DistanceRow] :@"" :@""];
        }else{
            resentities=[WebServices getShopListByPSConditionForIos :pageNow :pageSize :curLgd :curLad :[pickDateArray objectAtIndex:btnChoice_DistanceRow] :[subPickDateCodeArray objectAtIndex:btnChoice_CookingSubRow] :@""];
        }
        
        [self.tableviewCustom reloadData];
        tableviewCustom.contentOffset = CGPointMake(0, 0);
    }
}

- (void)removeViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.resentities count] == 0){
		return 1;
	}else {
		// Add an object to the end of the array for the \"Load more...\" table cell.
		return [self.resentities count] + 1;
	}
    
	// Return the number of rows as there are in the resentities array.
	//return [self.resentities count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int size = 93;
    if (indexPath.row < [resentities count]) {
        size = 93;
    }else {
        size = 50;
    }
    return size;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ResCell";
    ResCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //点击cell按下去的状态时背景图片变换
    UIImage *selectedCell = [[UIImage imageNamed:@"lottery_cellBg_hall_focus"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 1, 5, 1)];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:selectedCell];
   
    if (indexPath.row < [resentities count]) {
        
        resEntity = [self.resentities objectAtIndex:indexPath.row];
        cell.resPriceTitleLbl.text=@"人均：¥";
        cell.resNameLbl.text=resEntity.resNameTxt;
//        if (![((AppDelegate *)[[UIApplication sharedApplication] delegate]).shopCode isEqualToString:@"1"]) {
//            cell.resDistanceLbl.text=@"";
//            cell.miles.text=@"";
//        }else{
//            cell.resDistanceLbl.text=resEntity.resDistanceTxt;
//            cell.miles.text=@"公里";
//        }
        cell.resDistanceLbl.text=resEntity.resDistanceTxt;
        cell.miles.text=@"公里";
        cell.resPriceLbl.text=resEntity.resPriceTxt;
        cell.resPhoneLbl.text=@"电话：";
        cell.resPhoneNumber.text=resEntity.ResTelTxt;
        cell.resSdAreaLbl.text=resEntity.resSdArea;
        //cell.resImgView.image=[CommonUtil getImageFromURL:resEntity.resImg];
        [cell.resImgView setImageWithURL:[NSURL URLWithString:[WEBSITE_URL stringByAppendingString:resEntity.resImg]]
                       placeholderImage:[UIImage imageNamed:@"loading_throbber_icon"]];
        cell.loadMoreLbl.text = @"";
        //cell末尾箭头指示
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.activityView stopAnimating];
    } else {
        
        if (currentPage < [resEntity.totalPage intValue]&&[resentities count]!=0) {
            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;

            cell.resPriceTitleLbl.text = @"";
            cell.resNameLbl.text = @"";
            cell.resDistanceLbl.text = @"";
            cell.resPriceLbl.text = @"";
            cell.miles.text=@"";
            cell.resPhoneLbl.text = @"";
            cell.resPhoneNumber.text = @"";
            cell.resSdAreaLbl.text = @"";
            cell.resPhoneLbl.text = @"";
            cell.miles.text = @"";
            cell.resImgView.image = nil;
            cell.loadMoreLbl.text = @"加载更多...";
            
        }
        else if ([resentities count]==[resEntity.totalNum intValue]&&[resentities count]!=0){
            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.resPriceTitleLbl.text = @"";
            cell.resNameLbl.text = @"";
            cell.resDistanceLbl.text = @"";
            cell.resPriceLbl.text = @"";
            cell.resPhoneLbl.text = @"";
            cell.resPhoneNumber.text = @"";
            cell.resSdAreaLbl.text = @"";
            cell.resPhoneLbl.text = @"";
            cell.miles.text = @"";
            cell.resImgView.image = nil;
            cell.loadMoreLbl.text = @"";
        }
        else if ([resentities count]==0){
            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.resPriceTitleLbl.text = @"";
            cell.resNameLbl.text = @"";
            cell.resDistanceLbl.text = @"";
            cell.resPriceLbl.text = @"";
            cell.resPhoneLbl.text = @"";
            cell.resPhoneNumber.text = @"";
            cell.resSdAreaLbl.text = @"";
            cell.resPhoneLbl.text = @"";
            cell.miles.text = @"";
            cell.resImgView.image = nil;
            cell.loadMoreLbl.text = @"附近没有商家哦";
            
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.resPriceTitleLbl.text = @"";
            cell.resNameLbl.text = @"";
            cell.resDistanceLbl.text = @"";
            cell.resPriceLbl.text = @"";
            cell.resPhoneLbl.text = @"";
            cell.resPhoneNumber.text = @"";
            cell.resSdAreaLbl.text = @"";
            cell.resPhoneLbl.text = @"";
            cell.miles.text = @"";
            cell.resImgView.image = nil;
            cell.loadMoreLbl.text = @"";
        }
       
    }
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (resEntity != nil) {
        ResCell *cell = (ResCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.row == [self.resentities count]) {
            if (currentPage==[resEntity.totalPage intValue]) {
            
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
                return;
            }
        
            [cell.activityView startAnimating];
            [self performSelectorInBackground:@selector(loadMore)withObject:nil];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            //[cell.activityView stopAnimating];
            return;
        }else {
        
            resEntity=[resentities objectAtIndex:indexPath.row];
            UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            ResDetailViewController *resDetailViewController = [storyborad instantiateViewControllerWithIdentifier:@"ResDetailViewController"];  
            resDetailViewController.resEntity=resEntity;
            [self.navigationController pushViewController:resDetailViewController animated:YES];
        }
    }
    //点击cell按下去的状态时背景图片变换，控制返回时图片恢复
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)loadMore     
{
    
    //当你按下这个按钮的时候, 意味着你需要看下一页了, 因此当前页码加1
    currentPage=currentPage+1;
    pageNow=[NSString stringWithFormat:@"%d",currentPage];
    NSMutableArray *more=[[NSMutableArray alloc] init];
    if (shopType==nil) {
        if (btnChoice==0) {
            more=[WebServices getShopListByPSConditionForIos :pageNow :pageSize :curLgd :curLad :@"1" :[subPickDateCodeArray objectAtIndex:btnChoice_CookingSubRow] :@""];
        }
        if (btnChoice==1){
            if ([subPickDateArray count]==0) {
                more=[WebServices getShopListByPSConditionForIos :pageNow :pageSize :curLgd :curLad :@"" :@"" :[pickDateCodeArray objectAtIndex:btnChoice_AreaRow]];
            }else{
                more=[WebServices getShopListByPSConditionForIos :pageNow :pageSize :curLgd :curLad :@"" :[subPickDateCodeArray objectAtIndex:btnChoice_CookingSubRow] :[pickDateCodeArray objectAtIndex:btnChoice_AreaRow]];
            }
            
        }
        if (btnChoice==2) {
            if ([subPickDateArray count]==0) {
                more=[WebServices getShopListByPSConditionForIos :pageNow :pageSize :curLgd :curLad :[pickDateArray objectAtIndex:btnChoice_DistanceRow] :@"" :@""];
            }else{
                more=[WebServices getShopListByPSConditionForIos :pageNow :pageSize :curLgd :curLad :[pickDateArray objectAtIndex:btnChoice_DistanceRow] :[subPickDateCodeArray objectAtIndex:btnChoice_CookingSubRow] :@""];
            }
        }else{
            more=[WebServices getShopDetailInfoByIsRecommedForIOS:pageNow :pageSize];
        }
    }
    else if ([shopType isEqualToString:@"1"]){
            more=[WebServices getNearShopForIOS:pageNow :pageSize :curLad :curLgd :distantText];
    }
//    else{
//            if (shopListCode!=nil) {
//                more=[WebServices getShopsForIOS:pageNow :pageSize :shopListCode];
//            }
//        }
    
   [self performSelectorOnMainThread:@selector(appendTableWith:) withObject:more waitUntilDone:NO];
}   
-(void) appendTableWith:(NSMutableArray *)data   
{   //将loadMore中的NSMutableArray添加到原来的数据源listData中.
    for (int i=0;i<[data count];i++) {   
        [resentities addObject:[data objectAtIndex:i]];   
    }   
    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];   
    for (int ind = 0; ind < [data count]; ind++) {   
        NSIndexPath    *newPath =  [NSIndexPath indexPathForRow:[resentities indexOfObject:[data objectAtIndex:ind]] inSection:0];   
        [insertIndexPaths addObject:newPath];   
    }   
    //重新调用UITableView的方法, 来生成行.
    
    [self.tableviewCustom insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];   
}     


#pragma mark - 
#pragma mark Picker Data Source Methods
// 返回显示的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView { 

    //return 1;
    NSUInteger count = 1;
    switch (btnChoice) {
        case 1:
        case 2:
            count = 1;
            break;
        case 0:
            count = 2;
            break;
        default:
            break;
    }
    return count;
    
} 
// 返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (btnChoice==0) {
        if (component==0) {
            return [pickDateArray count];
        }else{
            return [subPickDateArray count];
        }
    }else{
        return [pickDateArray count];
    }
    
    
} 
// 设置当前行的内容，若果行没有显示则自动释放
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component { 
    if (btnChoice==0) {
        if (component==0) {
            return [pickDateArray objectAtIndex:row];
        }else{
            return [subPickDateArray objectAtIndex:row];
        }
    }else{
        return [pickDateArray objectAtIndex:row];
    }
 
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   // result = [pickDateArray objectAtIndex:row];
    if (pickerView==picker_distant) {
        //记住pickerView所选中的行的索引
        btnChoice_DistanceRow=[picker_distant selectedRowInComponent:0];
        
    }
    else if(pickerView==picker_area)
    {
        //记住pickerView所选中的行的索引
        btnChoice_AreaRow=[picker_area selectedRowInComponent:0];
       
    }
    else if (pickerView==picker_cooking){
        if (component==0) {
            btnChoice_CookingRow=[picker_cooking selectedRowInComponent:0];
            subPickDateCodeArray=[[NSMutableArray alloc] init];
            NSMutableArray *subArray=[[NSMutableArray alloc] init];
            for (int i=0; i<[cookStyleLists count]; i++) {
                cookEntity=[self.cookStyleLists objectAtIndex:i];
                if ([cookEntity.parent isEqualToString:[pickDateCodeArray objectAtIndex:btnChoice_CookingRow]]) {
                    [subArray addObject:cookEntity.cookName];
                    [subPickDateCodeArray addObject:cookEntity.cookCode];
                }
            }
            subPickDateArray=subArray;
            [picker_cooking selectRow:0 inComponent:1 animated:YES];
            [picker_cooking reloadComponent:1];
        }
        else{
            btnChoice_CookingSubRow=[picker_cooking selectedRowInComponent:1];
            result = [subPickDateArray objectAtIndex:row];
        }
    }
}


//
//#pragma mark -
//#pragma mark UISearchBarDelegate Methods
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
//{
//
//    [self.searchBar setShowsCancelButton:YES animated:YES];
//    
//    
//
//    return YES;
//}
//
////UiSearchBar里面text内容改变
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    
//}
//
////点击UISearchBar时
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    
//    
//    [self.searchBar setShowsCancelButton:YES animated:YES];
//    //修改取消按钮字体
//    for(id cc in [self.searchBar subviews])
//    {
//        if([cc isKindOfClass:[UIButton class]])
//        {
//            UIButton *sbtn = (UIButton *)cc;
//            [sbtn setTitle:@"取消" forState:UIControlStateNormal];
//            [sbtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
//            //[sbtn setBackgroundColor:[UIColor lightGrayColor]];
//         }
//    }
//    
//}
//
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
//    
//}
//
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
//   
//    self.searchBar.text=@"";
//    [self.searchBar setShowsCancelButton:NO animated:YES];
//    [self.searchBar resignFirstResponder];
//    
//}
//
////输入完毕  点击搜索按钮
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    
//    resentities= [WebServices getShopsBySDName:self.searchBar.text];
//    NSLog(@"%d",[resentities count]);
////	
//    [self.searchBar resignFirstResponder];
//    [self.searchBar setShowsCancelButton:NO animated:YES];
//    
////	
////    [self.tableData removeAllObjects];
////    [self.tableData addObjectsFromArray:results];
//    [self.tableviewCustom reloadData];
//}


@end
