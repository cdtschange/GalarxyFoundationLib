//
//  LoginNetwork.h
//  IFIAM
//
//  Created by Wei Mao on 12/24/12.
//  Copyright (c) 2012 cdts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SinaWeiboOAuthHelper.h"
#import "TencentOAuthHelper.h"
#import "WeiChatHelper.h"
#import "OAuthTypeEnum.h"

@class OAuthNetwork;


@protocol OAuthNetworkDelegate <NSObject>
@optional
- (void)oauthNetwork_didLoginFinished:(OAuthNetwork *)net result:(BOOL)result info:(id)info;
- (void)oauthNetwork_didLogout:(OAuthNetwork *)net;
- (void)oauthNetwork_didGetUserInfo:(OAuthNetwork *)net result:(BOOL)result info:(id)info;
- (void)oauthNetwork_didGetBilateralFriends:(OAuthNetwork *)net result:(BOOL)result info:(id)info;
- (void)oauthNetwork_didGetComments:(OAuthNetwork *)net result:(BOOL)result info:(id)info;
- (void)oauthNetwork_didReplyComment:(OAuthNetwork *)net result:(BOOL)result info:(id)info;
- (void)oauthNetwork_didDeleteComment:(OAuthNetwork *)net result:(BOOL)result info:(id)info;
- (void)oauthNetwork_didDeleteStatus:(OAuthNetwork *)net result:(BOOL)result info:(id)info;
- (void)oauthNetwork_didShareText:(OAuthNetwork *)net result:(BOOL)result info:(id)info;
@end

@interface OAuthNetwork : NSObject<OAuthHelperDelegate>

+ (OAuthNetwork *)sharedNetwork;

@property (copy, nonatomic) NSString *kOAUTHSINAWEIBOAppKey;
@property (copy, nonatomic) NSString *kOAUTHSINAWEIBOAppSecret;
@property (copy, nonatomic) NSString *kOAUTHSINAWEIBOAppRedirectUrl;
@property (copy, nonatomic) NSString *kOAUTHSINAWEIBOAppSSOCallbackScheme;
@property (copy, nonatomic) NSString *kOAUTHQQAppKey;
@property (copy, nonatomic) NSString *kOAUTHWECHATAppKey;

@property (strong, nonatomic, readonly) SinaWeiboOAuthHelper *sinaWeiboOAuthHelper;
@property (strong, nonatomic, readonly) TencentOAuthHelper *tencentOAuthHelper;
@property (strong, nonatomic, readonly) WeiChatHelper *weichatHelper;
@property (assign, nonatomic) id<OAuthNetworkDelegate> delegate;
@property (assign, nonatomic) OAuthType oauthType;

- (BOOL)isLoggedIn;
// 登录
- (void)login;
// 登出
- (void)logout;
// 获取用户信息
- (void)getUserInfo;
// 获取用户信息
- (void)getUserInfoById:(NSString *)uid;
// 获取用户信息
- (void)getUserInfoByNick:(NSString *)nick;
// 获取新浪微博用户双向关注列表
- (void)getBilateralFriendsWithCount:(int)count page:(int)page;
// 获取微博用户评论列表
- (void)getCommentsByWid:(NSString *)wid;
//回复评论
- (void)replyComment:(NSString *)wid cid:(NSString *)cid reply:(NSString *)reply;
//删除评论
- (void)deleteComment:(NSString *)cid;
//删除微博
- (void)deleteStatus:(NSString *)wid;
// 分享到微博
- (void)shareWithText:(NSString *)text;
// 分享到微博
- (void)shareWithText:(NSString *)text url:(NSString *)url image:(UIImage *)image;
// 分享到微博
- (void)shareWithText:(NSString *)text url:(NSString *)url imageUrl:(NSString *)imageUrl;
//分享到微信朋友
- (void)shareToFriendWithText:(NSString *)text url:(NSString *)url image:(UIImage *)image;

@end


