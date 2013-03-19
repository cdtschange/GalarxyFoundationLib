//
//  SQLiteHelper.h
//  CdtsFramework
//
//  Created by Change Cdts on 12-3-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define SQLiteHelper_VERSION @"1.0.0"

@interface SQLiteHelper : NSObject{
    sqlite3 *database;
    sqlite3_stmt *statement;
    NSFileManager *filemanager;
}

@property (strong,nonatomic) NSString *dbName;
@property (nonatomic, retain) NSString *tableName;

// object management
- (SQLiteHelper *) initWithDBFilename: (NSString *) fn;
- (SQLiteHelper *) initWithDBFilename: (NSString *) fn andTableName: (NSString *) tn;
- (void) openDB;
- (void) closeDB;
- (NSString *) getVersion;
- (NSString *) getDBPath;
- (void) createTable:(NSString *)fields;
- (void) dropTable;

// SQL queries
- (NSNumber *) doQuery:(NSString *) query, ...;
- (SQLiteHelper *) getQuery:(NSString *) query, ...;
- (void) prepareQuery:(NSString *) query, ...;
- (id) valueFromQuery:(NSString *) query, ...;


// CRUD methods
- (NSNumber *) insertRow:(NSDictionary *) record;
- (void) updateRow:(NSDictionary *) record: (NSNumber *) rowID;
- (void) deleteRow:(NSNumber *) rowID;
- (NSDictionary *) getRow: (NSNumber *) rowID;
- (NSArray *) getRows: (NSString *) where;
- (NSNumber *) countRows;

// Raw results
- (void) bindSQL:(const char *) cQuery arguments:(va_list)args;
- (NSDictionary *) getPreparedRow;
- (id) getPreparedValue;

// Utilities
- (id) columnValue:(int) columnIndex;
- (NSNumber *) lastInsertId;

@end
