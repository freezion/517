//
//  DishMenu.m
//  OrderAssistant
//
//  Created by Li Feng on 13-6-13.
//
//

#import "DishMenu.h"

@implementation DishMenu

@synthesize menuCode;
@synthesize menuName;
@synthesize sdCode;

+ (void)createMenuTable{
    NSString *databasePath = [NSUtil getDBPath];
    sqlite3 *hzoaDB;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &hzoaDB)==SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS MENU(ID VARCHAR(20) PRIMARY KEY, NAME TEXT, SDCODE TEXT);";
        if (sqlite3_exec(hzoaDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK) {
            NSLog(@"create failed!\n");
        }
    }
    else
    {
        NSLog(@"创建/打开数据库失败");
    }
}
+ (void)insertMenu:(DishMenu *) dishMenu{
    NSString *databasePath = [NSUtil getDBPath];
    sqlite3 *hzoaDB;
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &hzoaDB)==SQLITE_OK) {
        NSString *menuCode=dishMenu.menuCode;
        NSString *menuName=dishMenu.menuName;
        NSString *sdCode=dishMenu.sdCode;
                
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO MENU VALUES(\"%@\",\"%@\",\"%@\")",menuCode,menuName,sdCode];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(hzoaDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(hzoaDB);
    }
}
+ (void)deleteAllMenu{
    NSString *databasePath = [NSUtil getDBPath];
    sqlite3 *hzoaDB;
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *stmt = nil;
    if (sqlite3_open(dbpath, &hzoaDB) == SQLITE_OK)
    {
        const char *query = "DELETE FROM MENU;";
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
+ (void)dropMenuTable{
    NSString *databasePath = [NSUtil getDBPath];
    sqlite3 *hzoaDB;
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *stmt = nil;
    if (sqlite3_open(dbpath, &hzoaDB) == SQLITE_OK)
    {
        NSString *dropSql = @"DROP TABLE IF EXISTS MENU;";
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
+ (NSMutableArray *) getAllMenu{
    NSMutableArray *menuList = [[NSMutableArray alloc] initWithCapacity:500];
    NSString *databasePath = [NSUtil getDBPath];
    sqlite3 *hzoaDB;
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &hzoaDB) == SQLITE_OK)
    {
        NSString *querySQL = @"SELECT * FROM MENU;";
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(hzoaDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                DishMenu *dishMenu = [[DishMenu alloc] init];
                
                // code
                NSString *codeField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                dishMenu.menuCode=codeField;
                
                // name
                NSString *nameField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                dishMenu.menuName=nameField;
                
                // sdCode
                NSString *sdCodeField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                dishMenu.sdCode=sdCodeField;

                [menuList addObject:dishMenu];
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(hzoaDB);
    }
    
    return menuList;
}
@end
