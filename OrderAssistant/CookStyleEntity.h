//
//  CookStyleEntity.h
//  OrderAssistant
//
//  Created by Li Feng on 13-6-6.
//
//

#import <Foundation/Foundation.h>

@interface CookStyleEntity : NSObject{
    NSString *cookCode;
    NSString *cookName;
    NSString *parent;
}

@property (nonatomic, retain) NSString *cookCode;
@property (nonatomic, retain) NSString *cookName;
@property (nonatomic, retain) NSString *parent;

@end
