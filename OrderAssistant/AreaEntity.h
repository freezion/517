//
//  AreaEntity.h
//  OrderAssistant
//
//  Created by Li Feng on 13-6-6.
//
//

#import <Foundation/Foundation.h>

@interface AreaEntity : NSObject{
    NSString *areaCode;
    NSString *areaName;
}

@property (nonatomic, retain) NSString *areaCode;
@property (nonatomic, retain) NSString *areaName;

@end
