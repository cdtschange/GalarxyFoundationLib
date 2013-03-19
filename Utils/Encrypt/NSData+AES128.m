//
//  NSData+AES128.m
//  CdtsFramework
//
//  Created by 山天 大畜 on 16/08/12.
//  Copyright (c) 2012 iSoftStone. All rights reserved.
//

#import "NSData+AES128.h"

@implementation NSData (AES) 
- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv
{ 
    char keyPtr[kCCKeySizeAES128 + 1];  
    memset(keyPtr, 0, sizeof(keyPtr)); 
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding]; 
    
    char ivPtr[kCCBlockSizeAES128 + 1];  
    memset(ivPtr, 0, sizeof(ivPtr)); 
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding]; 
    
    NSUInteger dataLength = [self length]; 
    size_t bufferSize = dataLength + kCCBlockSizeAES128; 
    void *buffer = malloc(bufferSize); 
    
    size_t numBytesCrypted = 0; 
    CCCryptorStatus cryptStatus = CCCrypt(operation, 
                                          kCCAlgorithmAES128, 
                                          kCCOptionPKCS7Padding, 
                                          keyPtr, 
                                          kCCBlockSizeAES128, 
                                          ivPtr, 
                                          [self bytes], 
                                          dataLength, 
                                          buffer, 
                                          bufferSize, 
                                          &numBytesCrypted); 
    if (cryptStatus == kCCSuccess) { 
        return [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted]; 
    } 
    free(buffer); 
    return nil; 
} 

- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv 
{ 
    return [self AES128Operation:kCCEncrypt key:key iv:iv]; 
} 

- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv 
{ 
    return [self AES128Operation:kCCDecrypt key:key iv:iv]; 
} 
@end 

//int main(int argc, char const* argv[]) 
//{ 
//    
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; 
//    
//    NSString *key = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding]; 
//    NSString *iv = [NSString stringWithCString:argv[2] encoding:NSUTF8StringEncoding]; 
//    NSString *data_str = [NSString stringWithCString:argv[3] encoding:NSUTF8StringEncoding]; 
//    NSData *data = [data_str dataUsingEncoding:NSUTF8StringEncoding]; 
//    
//    NSData *en_data = [data AES128EncryptWithKey:key iv:iv]; 
//    NSData *de_data = [en_data AES128DecryptWithKey:key iv:iv]; 
//    
//    NSString *de_str = [[[NSString alloc] initWithData:de_data 
//                                              encoding:NSUTF8StringEncoding] autorelease]; 
//    
//    NSLog(@"%@", en_data); 
//    NSLog(@"%@", de_str); 
//    
//    [pool drain]; 
//    return 0; 
//} 