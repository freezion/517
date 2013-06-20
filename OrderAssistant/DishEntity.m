//
//  DishEntity.m
//  OrderAssistant
//
//  Created by Li Feng on 13-4-18.
//
//

#import "DishEntity.h"

@implementation DishEntity
@synthesize discount;
@synthesize dishCode;
@synthesize dishName;
@synthesize dishNum;
@synthesize dishPoint;
@synthesize dishPrice;
@synthesize dishPriceS;
@synthesize dishScore;
@synthesize dishUnit;
@synthesize imageCode;
@synthesize imageUrl;
@synthesize isDelete;
@synthesize isDiscount;
@synthesize isDishPoint;
@synthesize isFeatureDish;
@synthesize menuCode;
@synthesize menuName;
@synthesize num;
@synthesize pyDishName;
@synthesize shopCode;
@synthesize shopName;
@synthesize totalNum;
@synthesize totalPage;

+ (void)createDishTable{
    NSString *databasePath = [NSUtil getDBPath];
    sqlite3 *hzoaDB;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &hzoaDB)==SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS DISH(ID VARCHAR(20) PRIMARY KEY, NAME TEXT, PRICE TEXT, NUM TEXT, IMAGE TEXT, UNIT TEXT, ISFEATURE TEXT, MENUCODE TEXT, MENUNAME TEXT);";
        if (sqlite3_exec(hzoaDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK) {
            NSLog(@"create failed!\n");
        }
    }
    else
    {
        NSLog(@"创建/打开数据库失败");
    }
}

+ (void)insertDish:(DishEntity *) dishEntity{
    NSString *databasePath = [NSUtil getDBPath];
    sqlite3 *hzoaDB;
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &hzoaDB)==SQLITE_OK) {
        
        NSString *name=dishEntity.dishName;
        NSString *code=dishEntity.dishCode;
        NSString *price=dishEntity.dishPrice;
        NSString *num=dishEntity.num;
        NSString *image=dishEntity.imageUrl;
        NSString *dishUnit=dishEntity.dishUnit;
        NSString *isFeature=dishEntity.isFeatureDish;
        NSString *menuCode=dishEntity.menuCode;
        NSString *menuName=dishEntity.menuName;
    
        
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO DISH VALUES(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",code,name,price,num,image,dishUnit,isFeature,menuCode,menuName];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(hzoaDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(hzoaDB);
    }
}

+ (void)deleteAllDish{
    NSString *databasePath = [NSUtil getDBPath];
    sqlite3 *hzoaDB;
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *stmt = nil;
    if (sqlite3_open(dbpath, &hzoaDB) == SQLITE_OK)
    {
        const char *query = "DELETE FROM DISH;";
        if (sqlite3_prepare_v2(hzoaDB, query, -1, &stmt, NULL) != SQLITE_OK) {
            NSLog(@"delete data failed!");
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
            NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(hzoaDB));
        }
    } else {
        NSLog(@"创建/打开数据库失败");
    }
}
+ (void)dropDishTable{
    NSString *databasePath = [NSUtil getDBPath];
    sqlite3 *hzoaDB;
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *stmt = nil;
    if (sqlite3_open(dbpath, &hzoaDB) == SQLITE_OK)
    {
        NSString *dropSql = @"DROP TABLE IF EXISTS DISH;";
        const char *query = [dropSql UTF8String];
        if (sqlite3_prepare_v2(hzoaDB, query, -1, &stmt, NULL) != SQLITE_OK) {
            NSLog(@"drop table failed!");
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
            NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(hzoaDB));
        }
    }
    else
    {
        NSLog(@"创建/打开数据库失败");
    }
}
+ (NSMutableArray *) getAllDish{
    NSMutableArray *dishList = [[NSMutableArray alloc] initWithCapacity:500];
    NSString *databasePath = [NSUtil getDBPath];
    sqlite3 *hzoaDB;
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &hzoaDB) == SQLITE_OK)
    {
        NSString *querySQL = @"SELECT * FROM DISH;";
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(hzoaDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                DishEntity *dishEntity = [[DishEntity alloc] init];
                
                // code
                NSString *codeField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                dishEntity.dishCode=codeField;
                
                // name
                NSString *nameField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                dishEntity.dishName=nameField;
                
                // price
                NSString *priceField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                dishEntity.dishPrice=priceField;
                
                // num
                NSString *numField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                dishEntity.num=numField;
                
                // image
                NSString *imageField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                dishEntity.imageUrl=imageField;
                
                // dishUnit
                NSString *dishUnitField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                dishEntity.dishUnit=dishUnitField;
                
                // isFeatureDish
                NSString *isFeatureDishField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                dishEntity.isFeatureDish=isFeatureDishField;
                
                // menuCode
                NSString *menuCodeField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                dishEntity.menuCode=menuCodeField;
                
                // menuName
                NSString *menuNameCodeField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
                dishEntity.menuName=menuNameCodeField;
                
                
                [dishList addObject:dishEntity];
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(hzoaDB);
    }
    
    return dishList;
}

+ (NSMutableArray *) selectMenuDish:(NSString *) menuCode{
    NSMutableArray *dishList = [[NSMutableArray alloc] initWithCapacity:500];
    NSString *databasePath = [NSUtil getDBPath];
    sqlite3 *hzoaDB;
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &hzoaDB)==SQLITE_OK) {
                
        //@"UPDATE DISH SET NUM = \"%@\" WHERE ID = \"%@\";"
        NSString *selectSQL = [NSString stringWithFormat:@"SELECT D.* FROM DISH AS D LEFT OUTER JOIN MENU AS M ON M.ID = D.MENUCODE WHERE M.ID = \"%@\";",menuCode];
        
        const char *query_stmt = [selectSQL UTF8String];
        if (sqlite3_prepare_v2(hzoaDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                DishEntity *dishEntity = [[DishEntity alloc] init];
                
                // code
                NSString *codeField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                dishEntity.dishCode=codeField;
                
                // name
                NSString *nameField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                dishEntity.dishName=nameField;
                
                // price
                NSString *priceField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                dishEntity.dishPrice=priceField;
                
                // num
                NSString *numField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                dishEntity.num=numField;
                
                // image
                NSString *imageField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                dishEntity.imageUrl=imageField;
                
                // dishUnit
                NSString *dishUnitField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                dishEntity.dishUnit=dishUnitField;
                
                // isFeatureDish
                NSString *isFeatureDishField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                dishEntity.isFeatureDish=isFeatureDishField;
                
                // menuCode
                NSString *menuCodeField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                dishEntity.menuCode=menuCodeField;
                
                // menuName
                NSString *menuNameCodeField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
                dishEntity.menuName=menuNameCodeField;
                
                
                [dishList addObject:dishEntity];
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(hzoaDB);
    }
    return dishList;
}

+ (void)updateDish:(NSString *)dishNum :(NSString *)dishCode{
    NSString *databasePath = [NSUtil getDBPath];
    sqlite3 *hzoaDB;
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &hzoaDB)==SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE DISH SET NUM = \"%@\" WHERE ID = \"%@\";", dishNum, dishCode];
        const char *insert_stmt = [querySQL UTF8String];
        sqlite3_prepare_v2(hzoaDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            
        } else {
            NSLog(@"更新失败");
        }
        sqlite3_finalize(statement);
        sqlite3_close(hzoaDB);
    }
}

+ (NSMutableArray *) selectOrderDish{
    NSMutableArray *dishList = [[NSMutableArray alloc] initWithCapacity:500];
    NSString *databasePath = [NSUtil getDBPath];
    sqlite3 *hzoaDB;
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &hzoaDB)==SQLITE_OK) {
        
        //@"UPDATE DISH SET NUM = \"%@\" WHERE ID = \"%@\";"
        NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM DISH WHERE NUM > 0;"];
        
        const char *query_stmt = [selectSQL UTF8String];
        if (sqlite3_prepare_v2(hzoaDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                DishEntity *dishEntity = [[DishEntity alloc] init];
                
                // code
                NSString *codeField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                dishEntity.dishCode=codeField;
                
                // name
                NSString *nameField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                dishEntity.dishName=nameField;
                
                // price
                NSString *priceField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                dishEntity.dishPrice=priceField;
                
                // num
                NSString *numField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                dishEntity.num=numField;
                
                // image
                NSString *imageField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                dishEntity.imageUrl=imageField;
                
                // dishUnit
                NSString *dishUnitField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                dishEntity.dishUnit=dishUnitField;
                
                // isFeatureDish
                NSString *isFeatureDishField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                dishEntity.isFeatureDish=isFeatureDishField;
                
                // menuCode
                NSString *menuCodeField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                dishEntity.menuCode=menuCodeField;
                
                // menuName
                NSString *menuNameCodeField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
                dishEntity.menuName=menuNameCodeField;
                
                
                [dishList addObject:dishEntity];
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(hzoaDB);
    }
    return dishList;
}


@end
