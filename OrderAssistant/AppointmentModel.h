//
//  AppointmentModel.h
//  OrderAssistant
//
//  Created by flybird on 12-12-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AppointmentModel : NSObject{
    NSString *appCode;
    NSString *appCustomerCount;
    NSString *appDate;
    int appLastTime;
    NSString *appNumber;
    NSString *appPlace;
    NSString *appStatusCode;
    NSString *appStatusName;
    NSString *appTableCount;
    NSString *appTime;
    NSString *customerCode;
    NSString *email;
    NSString *eventCode;
    NSString *eventName;
    NSString *imageUrl;
    NSString *isPark;
    NSString *isProxyDrive;
    NSString *isRoom;
    NSString *memo;
    NSString *name;
    NSString *phone;
    NSString *purpose;
    NSString *purposeName;
    NSString *sdCode;
    NSString *shopName;
    NSString *way;
    int window;
    
    NSString *sex;
    
}
@property(nonatomic,retain) NSString *appCode;
@property(nonatomic,retain) NSString *appCustomerCount;
@property(nonatomic,retain) NSString *appDate;
@property(nonatomic) int appLastTime;
@property(nonatomic) NSString *appNumber;
@property(nonatomic) NSString *appPlace;
@property(nonatomic,retain) NSString *appStatusCode;
@property(nonatomic,retain) NSString *appStatusName;
@property(nonatomic,retain) NSString *appTableCount;
@property(nonatomic,retain) NSString *appTime;
@property(nonatomic,retain) NSString *customerCode;
@property(nonatomic,retain) NSString *email;
@property(nonatomic,retain) NSString *eventCode;
@property(nonatomic,retain) NSString *eventName;
@property(nonatomic,retain) NSString *imageUrl;
@property(nonatomic,retain) NSString *isPark;
@property(nonatomic,retain) NSString *isProxyDrive;
@property(nonatomic,retain) NSString *isRoom;
@property(nonatomic,retain) NSString *memo;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *phone;
@property(nonatomic,retain) NSString *purpose;
@property(nonatomic,retain) NSString *purposeName;
@property(nonatomic,retain) NSString *sdCode;
@property(nonatomic,retain) NSString *sex;
@property(nonatomic,retain) NSString *shopName;
@property(nonatomic,retain) NSString *way;
@property(nonatomic) int window;





@end
