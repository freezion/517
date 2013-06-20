//
//  BaiduMapViewController.h
//  OrderAssistant
//
//  Created by Li Feng on 13-1-23.
//
//

#import <UIKit/UIKit.h>
#import "ResEntity.h"
#import "BMapKit.h"

@interface BaiduMapViewController : UIViewController<BMKMapViewDelegate,CLLocationManagerDelegate>{
    ResEntity *resEntity;
    BMKMapView *mapView;
    CLLocationManager *locationManager;
    
    
}

@property (nonatomic, retain) ResEntity *resEntity;
@property (nonatomic, retain) BMKMapView *mapView;
@property (nonatomic, retain) CLLocationManager *locationManager;



@end
