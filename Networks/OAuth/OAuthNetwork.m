//
//  LoginNetwork.m
//  IFIAM
//
//  Created by Wei Mao on 12/24/12.
//  Copyright (c) 2012 cdts. All rights reserved.
//

#import "OAuthNetwork.h"

static OAuthNetwork *network = nil;

@implementation OAuthNetwork

@synthesize sinaWeiboOAuthHelper = _sinaWeiboOAuthHelper;
@synthesize tencentOAuthHelper = _tencentOAuthHelper;
@synthesize weichatHelper = _weichatHelper;
@synthesize kOAUTHSINAWEIBOAppKey = kOAUTHSINAWEIBOAppKey_;
@synthesize kOAUTHSINAWEIBOAppSecret = kOAUTHSINAWEIBOAppSecret_;
@synthesize kOAUTHSINAWEIBOAppRedirectUrl = kOAUTHSINAWEIBOAppRedirectUrl_;
@synthesize kOAUTHSINAWEIBOAppSSOCallbackScheme = kOAUTHSINAWEIBOAppSSOCallbackScheme_;
@synthesize kOAUTHQQAppKey = kOAUTHQQAppKey_;
@synthesize kOAUTHWECHATAppKey = kOAUTHWECHATAppKey_;

@synthesize oauthType = oauthType_;

+ (OAuthNetwork *)sharedNetwork
{
    if (!network) {
        network = [[OAuthNetwork alloc] init];
    }
    
    return network;
}
- (void)dealloc{
    _sinaWeiboOAuthHelper = nil;
    _tencentOAuthHelper = nil;
    _weichatHelper = nil;
    self.delegate = nil;
    self.kOAUTHSINAWEIBOAppKey=nil;
    self.kOAUTHSINAWEIBOAppSecret=nil;
    self.kOAUTHQQAppKey=nil;
    self.kOAUTHWECHATAppKey=nil;
}

- (SinaWeiboOAuthHelper *)sinaWeiboOAuthHelper{
    if (!_sinaWeiboOAuthHelper) {
        if (kOAUTHSINAWEIBOAppSSOCallbackScheme_) {
            _sinaWeiboOAuthHelper = [[SinaWeiboOAuthHelper alloc] initWithAppKey:kOAUTHSINAWEIBOAppKey_ withAppSecret:kOAUTHSINAWEIBOAppSecret_ withRedirectUrl:kOAUTHSINAWEIBOAppRedirectUrl_ withssoCallbackScheme:kOAUTHSINAWEIBOAppSSOCallbackScheme_];
        }else{
            _sinaWeiboOAuthHelper = [[SinaWeiboOAuthHelper alloc] initWithAppKey:kOAUTHSINAWEIBOAppKey_ withAppSecret:kOAUTHSINAWEIBOAppSecret_ withRedirectUrl:kOAUTHSINAWEIBOAppRedirectUrl_];
        }
        
        _sinaWeiboOAuthHelper.delegate = self;
    }
    return _sinaWeiboOAuthHelper;
}
-(TencentOAuthHelper *)tencentOAuthHelper{
    if (!_tencentOAuthHelper) {
        _tencentOAuthHelper = [[TencentOAuthHelper alloc] initWithAppKey:kOAUTHQQAppKey_];
        _tencentOAuthHelper.delegate = self;
    }
    return _tencentOAuthHelper;
}
-(WeiChatHelper *)weichatHelper{
    if (!_weichatHelper) {
        _weichatHelper = [WeiChatHelper shareHelperWithAppKey:kOAUTHWECHATAppKey_];
        _weichatHelper.delegate = self;
    }
    return _weichatHelper;
}

#pragma mark- public methods
- (BOOL)isLoggedIn{
    BOOL result;
    switch (oauthType_) {
        case OAuthTypeSinaWeibo:
            result = [self.sinaWeiboOAuthHelper isAuthorizeValid];
            break;
        case OAuthTypeQQ:
            result = [self.tencentOAuthHelper isAuthorizeValid];
            break;
        default:
            break;
    }
    return result;
}


- (void)login{
    if ([self isLoggedIn]) {
        [self oauth_didAlreadyLogin];
    }
    switch (oauthType_) {
        case OAuthTypeSinaWeibo:
            [self.sinaWeiboOAuthHelper authorize];
            break;
        case OAuthTypeQQ:
            [self.tencentOAuthHelper authorize];
            break;
        default:
            break;
    }
}

- (void)logout{
    switch (oauthType_) {
        case OAuthTypeSinaWeibo:
            [self.sinaWeiboOAuthHelper unauthorized];
            break;
        case OAuthTypeQQ:
            [self.tencentOAuthHelper unauthorized];
            break;
        default:
            break;
    }
}

-(void)getUserInfo{
    switch (oauthType_) {
        case OAuthTypeSinaWeibo:
            [self.sinaWeiboOAuthHelper getUserInfo];
            break;
        case OAuthTypeQQ:
            [self.tencentOAuthHelper getUserInfo];
            break;
        default:
            break;
    }
}
-(void)getUserInfoById:(NSString *)uid{
    switch (oauthType_) {
        case OAuthTypeSinaWeibo:
            [self.sinaWeiboOAuthHelper getOtherUserInfo:uid];
            break;
        default:
            break;
    }
}
-(void)getUserInfoByNick:(NSString *)nick{
    switch (oauthType_) {
        case OAuthTypeSinaWeibo:
            [self.sinaWeiboOAuthHelper getOtherUserInfoByNick:nick];
            break;
        default:
            break;
    }
}

-(void)getBilateralFriendsWithCount:(int)count page:(int)page{
    switch (oauthType_) {
        case OAuthTypeSinaWeibo:
            [self.sinaWeiboOAuthHelper getBilateralFriendsWithCount:count page:page];
            break;
            
        default:
            break;
    }
}
-(void)getCommentsByWid:(NSString *)wid{
    switch (oauthType_) {
        case OAuthTypeSinaWeibo:
            [self.sinaWeiboOAuthHelper getComments:wid];
            break;
            
        default:
            break;
    }
}
-(void)replyComment:(NSString *)wid cid:(NSString *)cid reply:(NSString *)reply{
    switch (oauthType_) {
        case OAuthTypeSinaWeibo:
            [self.sinaWeiboOAuthHelper replyComment:wid cid:cid reply:reply];
            break;
            
        default:
            break;
    }
}
-(void)deleteComment:(NSString *)cid{
    switch (oauthType_) {
        case OAuthTypeSinaWeibo:
            [self.sinaWeiboOAuthHelper deleteComment:cid];
            break;
            
        default:
            break;
    }
}
-(void)deleteStatus:(NSString *)wid{
    switch (oauthType_) {
        case OAuthTypeSinaWeibo:
            [self.sinaWeiboOAuthHelper deleteStatus:wid];
            break;
            
        default:
            break;
    }
}
-(void)shareWithText:(NSString *)text{
    switch (oauthType_) {
        case OAuthTypeSinaWeibo:
            [self.sinaWeiboOAuthHelper shareWithText:text];
            break;
        default:
            break;
    }
}
-(void)shareWithText:(NSString *)text url:(NSString *)url image:(UIImage *)image{
    switch (oauthType_) {
        case OAuthTypeSinaWeibo:
            [self.sinaWeiboOAuthHelper shareWithText:text url:url image:image];
            break;
        case OAuthTypeQQ:
            [self.tencentOAuthHelper shareWithText:text url:url image:image];
            break;
        case OAuthTypeWeChat:
            [self.weichatHelper setScene:WXSceneTimeline];
            [self.weichatHelper shareWithText:text url:url image:image];
            break;
        default:
            break;
    }
}
-(void)shareWithText:(NSString *)text url:(NSString *)url imageUrl:(NSString *)imageUrl{
    switch (oauthType_) {
        case OAuthTypeQQ:
            [self.tencentOAuthHelper shareWithText:text url:url imageUrl:imageUrl];
            break;
            
        default:
            break;
    }
}
-(void)shareToFriendWithText:(NSString *)text url:(NSString *)url image:(UIImage *)image{
    switch (oauthType_) {
        case OAuthTypeWeChat:
            [self.weichatHelper setScene:WXSceneSession];
            [self.weichatHelper shareWithText:text url:url image:image];
            break;
        default:
            break;
    }
}

-(void)oauth_didLogin{
    [self.delegate oauthNetwork_didLoginFinished:self result:YES info:nil];
}
-(void)oauth_didAlreadyLogin{
    [self.delegate oauthNetwork_didLoginFinished:self result:YES info:nil];
}
-(void)oauth_didLoginFailed:(NSError *)error{
    [self.delegate oauthNetwork_didLoginFinished:self result:NO info:error];
}
-(void)oauth_didLogout{
    [self.delegate oauthNetwork_didLogout:self];
}
-(void)user_didGetInfo:(id)result{
    [self.delegate oauthNetwork_didGetUserInfo:self result:YES info:result];
}
-(void)user_didGetInfoFailed:(NSError *)error{
    [self.delegate oauthNetwork_didGetUserInfo:self result:NO info:error];
}
-(void)user_didGetBilateralFriends:(id)result{
    [self.delegate oauthNetwork_didGetBilateralFriends:self result:YES info:result];
}
-(void)user_didGetBilateralFriendsFailed:(NSError *)error{
    [self.delegate oauthNetwork_didGetBilateralFriends:self result:NO info:error];
}
-(void)user_didGetCommentsByWid:(id)result{
    [self.delegate oauthNetwork_didGetComments:self result:YES info:result];
}
-(void)user_didGetCommentsFailed:(NSError *)error{
    [self.delegate oauthNetwork_didGetComments:self result:NO info:error];
}
-(void)user_didReplyComment:(id)result{
    [self.delegate oauthNetwork_didReplyComment:self result:YES info:result];
}
-(void)user_didReplyCommentFailed:(NSError *)error{
    [self.delegate oauthNetwork_didReplyComment:self result:NO info:error];
}
-(void)user_didDeleteComment:(id)result{
    [self.delegate oauthNetwork_didDeleteComment:self result:YES info:result];
}
-(void)user_didDeleteCommentFailed:(NSError *)error{
    [self.delegate oauthNetwork_didDeleteComment:self result:NO info:error];
}
-(void)user_didDeleteStatus:(id)result{
    [self.delegate oauthNetwork_didDeleteStatus:self result:YES info:result];
}
-(void)user_didDeleteStatusFailed:(NSError *)error{
    [self.delegate oauthNetwork_didDeleteStatus:self result:NO info:error];
}
-(void)message_didShare:(id)result{
    [self.delegate oauthNetwork_didShareText:self result:YES info:result];
}
-(void)message_didShareFailed:(NSError *)error{
    [self.delegate oauthNetwork_didShareText:self result:NO info:error];
}

@end

