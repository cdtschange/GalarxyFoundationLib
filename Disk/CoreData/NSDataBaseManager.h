//
//  NSDataBaseManager.h
//  InsomniaDiary
//
//  Created by ISS on 20/09/12.
//  Copyright (c) 2012 Wei Mao. All rights reserved.
//
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

#define DBName @"DB.sqlite"

@interface NSDataBaseManager : NSObject

+ (id)shareManager;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveDB;

@end
