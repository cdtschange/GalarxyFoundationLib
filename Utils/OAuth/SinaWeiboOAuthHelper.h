//
//  SinaOAuthManager.h
//  WandaKTV
//
//  Created by Wei Mao on 11/16/12.
//  Copyright (c) 2012 Wanda Inc.. All rights reserved.
//
// CLASS INCLUDES
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "OAuthHelper.h"
// SYSTEN INCLUDES
#import <Foundation/Foundation.h>

typedef enum {
    APIUserShow = 0,
    APITextShare = 1,
    APIGetBilateralFriends = 2,
    APIGetComments = 3,
    APIReplyComment = 4,
    APIDeleteComment = 5,
    APIDeleteStatus = 6
}APIUri;

@interface SinaWeiboOAuthHelper : OAuthHelper<SinaWeiboDelegate, SinaWeiboRequestDelegate>

@property (assign, nonatomic) APIUri apiUri;
@property (copy, nonatomic) NSString *kOAUTHSINAWEIBOAppKey;
@property (copy, nonatomic) NSString *kOAUTHSINAWEIBOAppSecret;
@property (copy, nonatomic) NSString *kOAUTHSINAWEIBOAppRedirectUrl;
@property (copy, nonatomic) NSString *kOAUTHSINAWEIBOAppSSOCallbackScheme;
@property (strong, nonatomic) SinaWeibo *sinaWeiboEngine;

- (id)initWithAppKey:(NSString *)appKey withAppSecret:(NSString *)appSecret withRedirectUrl:(NSString *)appRedirectUrl;
- (id)initWithAppKey:(NSString *)appKey withAppSecret:(NSString *)appSecret withRedirectUrl:(NSString *)appRedirectUrl withssoCallbackScheme:(NSString *)ssoCallbackScheme;
- (void)resetSinaWeiboEngine;
- (void)getOtherUserInfo:(NSString *)uid;
- (void)getOtherUserInfoByNick:(NSString *)nick;
- (void)getBilateralFriendsWithCount:(int)count page:(int)page;
- (void)getBilateralFriends:(NSString *)uid count:(int)count page:(int)page;
- (void)getComments:(NSString *)wid;
//回复评论
- (void)replyComment:(NSString *)wid cid:(NSString *)cid reply:(NSString *)reply;
//删除评论
- (void)deleteComment:(NSString *)cid;
//删除微博
- (void)deleteStatus:(NSString *)wid;
@end
