//
//  MapViewController.h
//  OrderAssistant
//
//  Created by flybird on 13-1-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ResEntity.h"

@interface MapViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    CLLocationCoordinate2D curLocation;
    ResEntity *resEntity;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D curLocation;
@property (nonatomic, retain) IBOutlet MKMapView *regionsMapView;
@property (nonatomic, retain) ResEntity *resEntity;

@end
