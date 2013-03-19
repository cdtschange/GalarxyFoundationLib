//
//  OAuthManager.h
//  WandaKTV
//
//  Created by Wei Mao on 11/16/12.
//  Copyright (c) 2012 Wanda Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol OAuthHelperDelegate <NSObject>

@optional
-(void)oauth_didLogin;
-(void)oauth_didAlreadyLogin;
-(void)oauth_didLoginFailed:(NSError *)error;
-(void)oauth_didLogout;
-(void)user_didGetInfo:(id)result;
-(void)user_didGetInfoFailed:(NSError *)error;
-(void)user_didGetBilateralFriends:(id)result;
-(void)user_didGetBilateralFriendsFailed:(NSError *)error;
-(void)user_didGetCommentsByWid:(id)result;
-(void)user_didGetCommentsFailed:(NSError *)error;
-(void)user_didReplyComment:(id)result;
-(void)user_didReplyCommentFailed:(NSError *)error;
-(void)user_didDeleteComment:(id)result;
-(void)user_didDeleteCommentFailed:(NSError *)error;
-(void)user_didDeleteStatus:(id)result;
-(void)user_didDeleteStatusFailed:(NSError *)error;
-(void)message_didShare:(id)result;
-(void)message_didShareFailed:(NSError *)error;
@end

//Abstract Manager
@interface OAuthHelper : NSObject

@property (copy,   nonatomic) NSString *serviceName;
@property (copy,   nonatomic) NSString *openId;
@property (copy,   nonatomic) NSString *userId;
@property (copy,   nonatomic) NSString *accessToken;
@property (copy,   nonatomic) NSString *expirationDate;
@property (assign, nonatomic) id<OAuthHelperDelegate> delegate;


//初始化引擎
- (void)initEngine;

//是否登录或者登录是否有效
- (BOOL)isAuthorizeValid;

//获取授权
- (void)authorize;

//取消授权
- (void)unauthorized;

//获取该账号下个人信息
- (void)getUserInfo;

//发送文本
- (void)shareWithText:(NSString *)text;
- (void)shareWithText:(NSString *)text url:(NSString *)url image:(UIImage *)image;

@end
