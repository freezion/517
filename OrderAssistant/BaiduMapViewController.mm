//
//  BaiduMapViewController.m
//  OrderAssistant
//
//  Created by Li Feng on 13-1-23.
//
//

#import "BaiduMapViewController.h"

@implementation BaiduMapViewController

@synthesize resEntity;
@synthesize mapView;
@synthesize locationManager;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];     //创建MKMapView
    [self.view addSubview:mapView];
    mapView.delegate = self;
    
   // [self getCurPosition];
    self.navigationItem.title=@"地图导航";
    mapView.zoomEnabled = YES;
    mapView.scrollEnabled = YES;
    mapView.mapType = BMKMapTypeStandard;//地图类型为标准，
    mapView.zoomLevel = 16;
    // 商家位置
	BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
	CLLocationCoordinate2D coor;
	coor.latitude = [resEntity.latitude doubleValue];
	coor.longitude = [resEntity.longitude doubleValue];
    
	annotation.coordinate = coor;
	annotation.title =resEntity.resNameTxt;
	annotation.subtitle =resEntity.ResAddressTxt;
	[mapView addAnnotation:annotation];
    //进入地图界面时，默认弹出气泡，显示该点的信息
    [mapView selectAnnotation:annotation animated:YES];
    //显示地图时，商家在中心位置
    [mapView setCenterCoordinate:annotation.coordinate animated:YES];
    
}

- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    
}

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
