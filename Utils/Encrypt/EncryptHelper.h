//
//  EncryptHelper.h
//  CdtsFramework
//
//  Created by 山天 大畜 on 31/07/12.
//  Copyright (c) 2012 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptHelper : NSObject

+ (NSString *)md5Encrypt:(NSString *)input;
+ (NSString *)AESEncrypt:(NSString *)message password:(NSString *)password;
+ (NSString *)AESDecrypt:(NSString *)base64EncodedString password:(NSString *)password;

@end
