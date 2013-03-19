//
//  OAuthManager.m
//  WandaKTV
//
//  Created by Wei Mao on 11/16/12.
//  Copyright (c) 2012 Wanda Inc.. All rights reserved.
//
// CLASS INCLUDES
#import "OAuthHelper.h"
#import "SFHFKeychainUtils.h"
// CONST DEFINE
NSString *const kOpenidKey         = @"openid";
NSString *const kUseridKey         = @"userid";
NSString *const kAccessTokenKey    = @"accessToken";
NSString *const kExpirationDateKey = @"expirationDate";

@implementation OAuthHelper
@synthesize serviceName = serviceName_;
@synthesize openId = openId_;
@synthesize userId = userId_;
@synthesize accessToken = accessToken_;
@synthesize expirationDate = expirationDate_;
@synthesize delegate = delegate_;

-(void)dealloc{
    self.serviceName = nil;
    self.openId = nil;
    self.userId = nil;
    self.accessToken = nil;
    self.expirationDate = nil;
    self.delegate = nil;
}

#pragma mark- public methods
-(void)initEngine{
}

-(void)authorize{
}

- (void)getUserInfo{

}

-(void)shareWithText:(NSString *)text{
}
- (void)shareWithText:(NSString *)text url:(NSString *)url image:(UIImage *)image{
}

- (BOOL)isAuthorizeValid{
    if (!self.accessToken || !self.expirationDate) {
        return NO;
    }
    
    NSDate *nowDate = [NSDate date];
    NSDate *expirDate = [NSDate dateWithTimeIntervalSince1970:[self.expirationDate doubleValue]];
    if ([expirDate compare:nowDate] == NSOrderedDescending) {
        return YES;
    }
    
    return NO;
}
- (void)unauthorized{
    [SFHFKeychainUtils deleteItemForUsername:kOpenidKey andServiceName:serviceName_ error:nil];
    [SFHFKeychainUtils deleteItemForUsername:kUseridKey andServiceName:serviceName_ error:nil];
    [SFHFKeychainUtils deleteItemForUsername:kAccessTokenKey andServiceName:serviceName_ error:nil];
    [SFHFKeychainUtils deleteItemForUsername:kExpirationDateKey andServiceName:serviceName_ error:nil];
}

#pragma mark- class property
-(NSString *)openId{
    return [SFHFKeychainUtils getPasswordForUsername:kOpenidKey andServiceName:serviceName_ error:nil];
}

-(void)setOpenId:(NSString *)_openId{
    [SFHFKeychainUtils storeUsername:kOpenidKey andPassword:_openId forServiceName:serviceName_ updateExisting:YES error:nil];
}

-(NSString *)userId{
    return [SFHFKeychainUtils getPasswordForUsername:kUseridKey andServiceName:serviceName_ error:nil];
}

-(void)setUserId:(NSString *)_userId{
    [SFHFKeychainUtils storeUsername:kUseridKey andPassword:_userId forServiceName:serviceName_ updateExisting:YES error:nil];
}

-(NSString *)accessToken{
    return [SFHFKeychainUtils getPasswordForUsername:kAccessTokenKey andServiceName:serviceName_ error:nil];
}

-(void)setAccessToken:(NSString *)_accessToken{
    [SFHFKeychainUtils storeUsername:kAccessTokenKey andPassword:_accessToken forServiceName:serviceName_ updateExisting:YES error:nil];
}

-(NSString *)expirationDate{
    return [SFHFKeychainUtils getPasswordForUsername:kExpirationDateKey andServiceName:serviceName_ error:nil];
}

-(void)setExpirationDate:(NSString *)_expirationDate{
    [SFHFKeychainUtils storeUsername:kExpirationDateKey andPassword:_expirationDate forServiceName:serviceName_ updateExisting:YES error:nil];
}

@end
