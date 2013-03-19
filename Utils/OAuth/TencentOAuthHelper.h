//
//  TencentOAuthManager.h
//  WandaKTV
//
//  Created by Wei Mao on 11/16/12.
//  Copyright (c) 2012 Wanda Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuthHelper.h"
#import "TencentOAuth.h"

@interface TencentOAuthHelper : OAuthHelper<TencentSessionDelegate>

@property(copy,nonatomic) NSString * kOAUTHQQAppKey;

- (id)initWithAppKey:(NSString *)appKey;
- (void)resetTencentEngine;

- (void)authorizeWithPermission:(NSArray *)permission;
- (void)shareWithText:(NSString *)text url:(NSString *)url imageUrl:(NSString *)imageUrl;
- (void)shareWithText:(NSString *)text title:(NSString *)title comment:(NSString *)comment url:(NSString *)url imageUrl:(NSString *)imageUrl;
@end
