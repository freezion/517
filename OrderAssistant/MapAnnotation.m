//
//  MapAnnotation.m
//  OrderAssistant
//
//  Created by flybird on 13-1-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (id) initWithCoordinate:(CLLocationCoordinate2D) temp_coordinate
{
    if ([super init])
    {
        coordinate = temp_coordinate;
    }
    return self;
}

@end
