//
//  DishMenu.h
//  OrderAssistant
//
//  Created by Li Feng on 13-6-13.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "NSUtil.h"

@interface DishMenu : NSObject{
    NSString *menuCode;
    NSString *menuName;
    NSString *sdCode;
}

@property (nonatomic, retain) NSString *menuCode;
@property (nonatomic, retain) NSString *menuName;
@property (nonatomic, retain) NSString *sdCode;

+ (void)createMenuTable;
+ (void)insertMenu:(DishMenu *) dishMenu;
+ (void)deleteAllMenu;
+ (void)dropMenuTable;
+ (NSMutableArray *) getAllMenu;

@end
