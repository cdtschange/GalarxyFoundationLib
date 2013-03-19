//
//  LocalUser.m
//  GalarxyFoundationLib
//
//  Created by Wei Mao on 12/24/12.
//  Copyright (c) 2012 cdts. All rights reserved.
//

#import "LocalUser.h"

static LocalUser *user = nil;

@interface LocalUser()
{
    
}

@end

@implementation LocalUser
@synthesize info = info_;
@synthesize fileName = fileName_;

+ (id)sharedUser
{
    if (!user) {
        user = [[LocalUser alloc] init];
        [user loadInfoFromDisk];
    }
    
    return user;
}
+ (id)sharedUserWithFileName:(NSString *)fileName
{
    if (!user) {
        user = [[LocalUser alloc] initWithFileName:fileName];
        [user loadInfoFromDisk];
    }
    
    return user;
}

-(id)init{
    return [self initWithFileName:@"userdata.plist"];
}

-(id)initWithFileName:(NSString *)fileName{
    if (self = [super init]) {
        fileName_ = fileName;
    }
    return self;
}

-(void)dealloc{
    self.info= nil;
}

-(void)infoStoreToDisk{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir=[paths objectAtIndex:0];
    NSString *filePath=[docDir stringByAppendingPathComponent:fileName_];
    NSLog(@"write in:%@",filePath);
    [info_ writeToFile:filePath atomically:YES];
}
-(void)loadInfoFromDisk{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir=[paths objectAtIndex:0];
    NSString *filePath=[docDir stringByAppendingPathComponent:fileName_];
    NSLog(@"load from:%@",filePath);
    info_=[[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    if (!info_) {
        info_ = [NSMutableDictionary new];
    }
}

@end
