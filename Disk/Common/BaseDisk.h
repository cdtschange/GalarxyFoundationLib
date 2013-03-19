//
//  BaseDisk.h
//  GalarxyFoundationLib
//
//  Created by Wei Mao on 12/25/12.
//  Copyright (c) 2012 cdts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDisk : NSObject

- (NSString *)getLocalFilePath;
- (NSMutableArray *)loadLocalEntities;
- (void)saveEntityToLocal:(id)entity;
- (void)saveEntitiesToLocal:(NSArray *)entities;
- (void)saveEntitiesOverwriteToLocal:(NSArray *)entities;


- (id)convertDictionaryToEntity:(NSDictionary *)dict;
- (NSDictionary *)convertEntityToDictionary:(id)entity;

@end
