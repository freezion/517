//
//  MapViewController.m
//  OrderAssistant
//
//  Created by flybird on 13-1-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "MapAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize locationManager;
@synthesize curLocation;
@synthesize regionsMapView;
@synthesize resEntity;

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
	// Do any additional setup after loading the view.
    [self getCurPosition];
    
    self.navigationItem.title=@"地图导航";
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
    //NSTimeInterval interval = [newLocation.timestamp timeIntervalSinceDate:oldLocation.timestamp];
    //保存新位置
    curLocation = newLocation.coordinate;
    if (oldLocation == nil) {
        regionsMapView.mapType = MKMapTypeStandard;
        regionsMapView.zoomEnabled = YES;
        //regionsMapView.showsUserLocation = YES;
        regionsMapView.scrollEnabled=YES;
        
//        MKCoordinateRegion theRegion = { {0.0, 0.0 }, { 0.0, 0.0 } };
//        theRegion.center = newLocation.coordinate;
//        [regionsMapView setZoomEnabled:YES];
//        [regionsMapView setScrollEnabled:YES];
//        theRegion.span.longitudeDelta = 0.01f;
//        theRegion.span.latitudeDelta = 0.01f;
//        [regionsMapView setRegion:theRegion animated:YES];
        
        MKCoordinateRegion region4 = { {0.0, 0.0 }, { 0.0, 0.0 } };
        region4.center.latitude = [resEntity.latitude doubleValue] ;
        region4.center.longitude = [resEntity.longitude doubleValue];
        region4.span.longitudeDelta = 0.01f;
        region4.span.latitudeDelta = 0.01f;
        [regionsMapView setRegion:region4 animated:YES];
        
        MapAnnotation *ann = [[MapAnnotation alloc] init];
        ann.title = resEntity.resNameTxt;
        ann.subtitle = resEntity.ResAddressTxt;
        //地点名字
        ann.coordinate = region4.center;
        [regionsMapView addAnnotation:ann];
        //[regionsMapView setCenterCoordinate:ann zoomLevel:13 animated:YES];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//delegate   MKMapViewDelegate
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = nil; 
    //判断是否是自己
    if(annotation != mapView.userLocation)
    {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil ) pinView = [[MKPinAnnotationView alloc]
                                         initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        pinView.pinColor = MKPinAnnotationColorRed;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
        return pinView;
    }
    else
    {
        MapAnnotation *mapannotation = annotation;
        mapannotation.title = @"当前位置";
        return nil;
    }
    
}

//当用户点击小人图标的时候，就进入这里，即将显示 AnnotationView
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
    if ([view.annotation isKindOfClass:[MapAnnotation class]] == NO)
    {
        return;
    }
    
    //设置显示的视图的内容
    //MapAnnotation *annotation = (MapAnnotation *) view.annotation;
    //通过MapAnnotation就可以获得自己设置的一些个性化信息。
    //然后，根据这些信息来设置，这里是获得头像的文件路径，然后
    //设置到 VIEW
    //UIImageView *headImageView = (UIImageView *) view.leftCalloutAccessoryView ;
    //[headImageView setImage:[UIImage imageWithContentsOfFile:nsFilePath] ];
}

- (void) mapView:(MKMapView *)mapView   didAddAnnotationViews:(NSArray*) views
{
    int   i=0;
    for (MKPinAnnotationView     *mkview   in   views     )
    {
        //判断是否是自己
        if ([mkview.annotation isKindOfClass:[MapAnnotation class]]==NO)
        {
            continue;
        }
        else
        {
            UIImageView   *headImageView=[[UIImageView  alloc] initWithImage:[UIImage   imageNamed:@"online.png"] ];
            [headImageView  setFrame:CGRectMake(1, 1, 30, 32)];
            mkview.leftCalloutAccessoryView=headImageView;
            
            UIButton  *rightbutton=[UIButton  buttonWithType:UIButtonTypeDetailDisclosure];
            mkview.rightCalloutAccessoryView=rightbutton;
        }
        i++;
    }
}

//-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view  calloutAccessoryControlTapped:(UIControl *) control
//{
//    //MapAnnotation *annotation = view.annotation;
//    
//    // 根据 MapAnnotation,取出个性化的个人信息，然后创建自己
//    // 的新的VIEW,并且显示。
//}
//
////当地图显示范围发生变化的时候
//- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
//{
//    //MKCoordinateRegion curRegin = regionsMapView.region;
//}



@end
