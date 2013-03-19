//
//  TencentOAuthManager.m
//  WandaKTV
//
//  Created by Wei Mao on 11/16/12.
//  Copyright (c) 2012 Wanda Inc.. All rights reserved.
//
// CLASS INCLUDES
#import "TencentOAuthHelper.h"

@interface TencentOAuthHelper (){
    TencentOAuth *tencentEngine; // 腾讯
}

- (void)resetTencentEngine;

@end

@implementation TencentOAuthHelper
@synthesize kOAUTHQQAppKey = kOAUTHQQAppKey_;

- (void)dealloc{
    tencentEngine = nil;
}

- (id)initWithAppKey:(NSString *)appKey{
    if (self = [super init]) {
        self.serviceName = @"Tencent";
        kOAUTHQQAppKey_ = appKey;
        [self initEngine];
    }
    return self;
}

- (void)initEngine{
    tencentEngine = [[TencentOAuth alloc] initWithAppId:kOAUTHQQAppKey_
                                            andDelegate:self];
	tencentEngine.redirectURI = @"www.qq.com";
    [self resetTencentEngine];
}

- (void)resetTencentEngine
{
    tencentEngine.openId        = self.openId;
    tencentEngine.accessToken   = self.accessToken;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.expirationDate doubleValue]];
    tencentEngine.expirationDate = date;
}

-(void)authorizeWithPermission:(NSArray *)permission{
    [self resetTencentEngine];
    
    // 账号已经登录
    if ([self isAuthorizeValid]) {
        [self.delegate oauth_didAlreadyLogin];
        return;
    }
    
    // APPKEY权限
   
    [tencentEngine authorize:permission inSafari:NO];
}
- (void)authorize{
    NSArray *permissions =  [NSArray arrayWithObjects:
                             @"get_user_info",@"add_share", @"add_topic",@"add_one_blog", @"list_album",
                             @"upload_pic",@"list_photo", @"add_album", @"check_page_fans",nil];
    [self authorizeWithPermission:permissions];
}

-(void)shareWithText:(NSString *)text title:(NSString *)title comment:(NSString *)comment url:(NSString *)url imageUrl:(NSString *)imageUrl{
    [self resetTencentEngine];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   title, @"title",
								   url, @"url",
                                   comment, @"comment",
                                   imageUrl, @"images",
                                   text,@"summary",
								   nil];
	[tencentEngine addShareWithParams:params];
}
- (void)shareWithText:(NSString *)text url:(NSString *)url imageUrl:(NSString *)imageUrl{
    [self shareWithText:text title:@"分享" comment:@"" url:url imageUrl:imageUrl];
}

- (void)getUserInfo{
    [self resetTencentEngine];
    [tencentEngine getUserInfo];
}

#pragma mark- TencentSessionDelegate
- (void)tencentDidLogin{
    self.openId = tencentEngine.openId;
    self.accessToken = tencentEngine.accessToken;
    NSTimeInterval time =  [tencentEngine.expirationDate timeIntervalSince1970];
    self.expirationDate = [NSString stringWithFormat:@"%lf", time];
    [self.delegate oauth_didLogin];
}

- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled) {
        return;
    }
    NSError *error = [NSError errorWithDomain:@"TencentSDKErrorDomain" code:100 userInfo:@{@"error":[NSString stringWithFormat:@"tencentDidNotLogin:cancelled?%d",cancelled]}];
    [self.delegate oauth_didLoginFailed:error];
}

- (void)tencentDidNotNetWork{
    NSError *error = [NSError errorWithDomain:@"TencentSDKErrorDomain" code:101 userInfo:@{@"error":@"tencentDidNotNetWork"}];
    [self.delegate oauth_didLoginFailed:error];
}

- (void)tencentDidLogout{
    [self.delegate oauth_didLogout];
}

- (void)getUserInfoResponse:(APIResponse*) response{
    if (response.retCode == 0) {
        [self.delegate user_didGetInfo:response.jsonResponse];
    }else{
        NSError *error = [NSError errorWithDomain:response.errorMsg code:response.retCode userInfo:nil];
        
        [self.delegate user_didGetInfoFailed:error];
    }
}

- (void)addShareResponse:(APIResponse *)response{
    if (response.retCode == 0) {
        [self.delegate message_didShare:response.jsonResponse];
    }else{
        NSError *error = [NSError errorWithDomain:response.errorMsg code:response.retCode userInfo:nil];
        [self.delegate message_didShareFailed:error];
    }
}

@end
