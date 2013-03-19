//
//  LocalUser.h
//  GalarxyFoundationLib
//
//  Created by Wei Mao on 12/24/12.
//  Copyright (c) 2012 cdts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalUser : NSObject

+ (id)sharedUser;
+ (id)sharedUserWithFileName:(NSString *)fileName;

@property(strong, nonatomic) NSMutableDictionary *info;
@property(copy, nonatomic) NSString *fileName;

- (void)infoStoreToDisk;
-(void)loadInfoFromDisk;

@end
