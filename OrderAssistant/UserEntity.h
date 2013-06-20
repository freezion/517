//
//  UserEntity.h
//  OrderAssistant
//
//  Created by flybird on 12-11-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : NSObject{
    NSString *userDevoteName;
    NSString *userEmail;
    NSString *userFlag;
    NSString *userIsActive;
    NSString *imageUrl;
    NSString *money;
    NSString *userNickName;
    NSString *userScore;
    NSString *userSex;
    NSString *regTime;
    NSString *userCCode;
    
    NSString *userTelphone;
    NSString *password;
    NSString *checkApp;
}

@property(nonatomic,retain)  NSString *userDevoteName;
@property(nonatomic,retain)  NSString *userEmail;
@property(nonatomic,retain)  NSString *userFlag;
@property(nonatomic,retain)  NSString *userIsActive;
@property(nonatomic,retain)  NSString *imageUrl;
@property(nonatomic,retain)  NSString *money;
@property(nonatomic,retain)  NSString *userNickName;
@property(nonatomic,retain)  NSString *userScore;
@property(nonatomic,retain)  NSString *userSex;
@property(nonatomic,retain)  NSString *regTime;
@property(nonatomic,retain)  NSString *userCCode;

@property(nonatomic,retain)  NSString *userTelphone;
@property(nonatomic,retain)  NSString *password;
@property(nonatomic,retain)  NSString *checkApp;
@end
