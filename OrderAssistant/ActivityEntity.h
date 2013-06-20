//
//  ActivityEntity.h
//  OrderAssistant
//
//  Created by Li Feng on 13-4-22.
//
//

#import <Foundation/Foundation.h>

@interface ActivityEntity : NSObject{
//    NSString *addTime;
//    NSString *appEvenNum;
//    NSString *code;
//    NSString *contrastPrice;
//    NSString *disCount;
//    NSString *etCode;
//    NSString *etType;
    NSString *eventCode;  //活动编号
//    NSString *eventImage;
    NSString *eventIntro;  //活动介绍
    NSString *eventName;  //活动名称
//    NSString *eventNum;
    NSString *eventPrice; //活动价格
//    NSString *eventPurchaseNum;
//    NSString *eventTarget;
//    NSString *eventType;
    NSString *flage;
//    NSString *imageFrontUrl;
    NSString *imageUrl;   //图片
//    NSString *isRecommend;
//    NSString *leastBuyNum;
//    NSString *name;
//    NSString *price;
}

@property (nonatomic, retain) NSString *eventCode;
@property (nonatomic, retain) NSString *eventIntro;
@property (nonatomic, retain) NSString *eventName;
@property (nonatomic, retain) NSString *eventPrice;
@property (nonatomic, retain) NSString *flage;
@property (nonatomic, retain) NSString *imageUrl;

@end
