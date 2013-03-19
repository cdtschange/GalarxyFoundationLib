//
//  NSData+AES128.h
//  CdtsFramework
//
//  Created by 山天 大畜 on 16/08/12.
//  Copyright (c) 2012 iSoftStone. All rights reserved.
//
#import <Foundation/Foundation.h> 
#import <CommonCrypto/CommonCryptor.h> 
@interface NSData (AES) 
- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv; 
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv; 
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv; 
@end 
