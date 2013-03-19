//
//  BaseDisk.m
//  GalarxyFoundationLib
//
//  Created by Wei Mao on 12/25/12.
//  Copyright (c) 2012 cdts. All rights reserved.
//

#import "BaseDisk.h"

@implementation BaseDisk

- (NSString *)getLocalFilePath{
    return nil;
}

- (id)convertDictionaryToEntity:(NSDictionary *)dict{return nil;};
- (NSDictionary *)convertEntityToDictionary:(id)entity{return nil;};

- (NSMutableArray *)loadLocalEntities{
    NSString *path = [self getLocalFilePath];
    NSLog(@"write in:%@",path);
    NSMutableArray *array=[[NSMutableArray alloc]initWithContentsOfFile:path];
    if (!array) {
        array = [[NSMutableArray alloc] init];
    }
    NSMutableArray *entities = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        [entities addObject:[self convertDictionaryToEntity:dict]];
    }
    return entities;
}


- (void)saveEntitiesToLocal:(NSArray *)entities{
    if (!entities||entities.count==0) {
        return;
    }
    NSString *path = [self getLocalFilePath];
    NSLog(@"write in:%@",path);
    NSMutableArray *localEntities=[self loadLocalEntities];
    NSMutableArray *newEntities=[NSMutableArray new];
    if (!localEntities) {
        localEntities = [[NSMutableArray alloc] initWithCapacity:1];
    }
    for (id entity in entities) {
        if ([localEntities containsObject:entity]) {
            [localEntities removeObject:entity];
        }
        NSDictionary *dict = [self convertEntityToDictionary:entity];
        [newEntities addObject:dict];
    }
    for (id entity in localEntities) {
        NSDictionary *dict = [self convertEntityToDictionary:entity];
        [newEntities addObject:dict];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [self addSkipBackupAttributeToItemAtURL_iOS5_1:[NSURL fileURLWithPath:path]];
    }
    BOOL result = [newEntities writeToFile:path atomically:YES];
    NSLog(@"write :%@",result?@"Success":@"Failed");
    
}

- (void)saveEntitiesOverwriteToLocal:(NSArray *)entities{
    NSString *path = [self getLocalFilePath];
    NSLog(@"write in:%@",path);
    NSMutableArray *newEntities=[NSMutableArray new];
    for (id entity in entities) {
        NSDictionary *dict = [self convertEntityToDictionary:entity];
        [newEntities addObject:dict];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [self addSkipBackupAttributeToItemAtURL_iOS5_1:[NSURL fileURLWithPath:path]];
    }
    BOOL result = [newEntities writeToFile:path atomically:YES];
    NSLog(@"write :%@",result?@"Success":@"Failed");
}

- (void)saveEntityToLocal:(id)entity{
    [self saveEntitiesToLocal:@[entity]];
}


#pragma mark -  Excluding a File from Backups on iOS 5.1
- (BOOL)addSkipBackupAttributeToItemAtURL_iOS5_1:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

@end
