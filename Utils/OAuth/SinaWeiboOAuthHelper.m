//
//  SinaOAuthManager.m
//  WandaKTV
//
//  Created by Wei Mao on 11/16/12.
//  Copyright (c) 2012 Wanda Inc.. All rights reserved.
//
// CLASS INCLUDES
#import "SinaWeiboOAuthHelper.h"

@interface SinaWeiboOAuthHelper ()
@end

@implementation SinaWeiboOAuthHelper
@synthesize apiUri = apiUri_;
@synthesize kOAUTHSINAWEIBOAppKey = kOAUTHSINAWEIBOAppKey_;
@synthesize kOAUTHSINAWEIBOAppSecret = kOAUTHSINAWEIBOAppSecret_;
@synthesize kOAUTHSINAWEIBOAppRedirectUrl = kOAUTHSINAWEIBOAppRedirectUrl_;
@synthesize kOAUTHSINAWEIBOAppSSOCallbackScheme = kOAUTHSINAWEIBOAppSSOCallbackScheme_;
@synthesize sinaWeiboEngine = sinaWeiboEngine_;

- (void)dealloc{
    self.sinaWeiboEngine = nil;
}

-(id)initWithAppKey:(NSString *)appKey withAppSecret:(NSString *)appSecret withRedirectUrl:(NSString *)appRedirectUrl{
    return [self initWithAppKey:appKey withAppSecret:appSecret withRedirectUrl:appRedirectUrl withssoCallbackScheme:nil];
}
-(id)initWithAppKey:(NSString *)appKey withAppSecret:(NSString *)appSecret withRedirectUrl:(NSString *)appRedirectUrl withssoCallbackScheme:(NSString *)ssoCallbackScheme{
    if (self = [super init]) {
        self.serviceName = @"SinaWeibo";
        kOAUTHSINAWEIBOAppKey_ = appKey;
        kOAUTHSINAWEIBOAppSecret_ = appSecret;
        kOAUTHSINAWEIBOAppRedirectUrl_ = appRedirectUrl;
        if (ssoCallbackScheme) {
            kOAUTHSINAWEIBOAppSSOCallbackScheme_ = ssoCallbackScheme;
        }
        [self initEngine];
    }
    return self;
}

#pragma mark- public methods
- (void)initEngine{
    if (kOAUTHSINAWEIBOAppSSOCallbackScheme_) {
         sinaWeiboEngine_ = [[SinaWeibo alloc] initWithAppKey:kOAUTHSINAWEIBOAppKey_ appSecret:kOAUTHSINAWEIBOAppSecret_ appRedirectURI:kOAUTHSINAWEIBOAppRedirectUrl_ ssoCallbackScheme:kOAUTHSINAWEIBOAppSSOCallbackScheme_ andDelegate:self];
    }else{
         sinaWeiboEngine_ = [[SinaWeibo alloc] initWithAppKey:kOAUTHSINAWEIBOAppKey_ appSecret:kOAUTHSINAWEIBOAppSecret_ appRedirectURI:kOAUTHSINAWEIBOAppRedirectUrl_ andDelegate:self];
    }
   
    sinaWeiboEngine_.delegate = self;
    [self resetSinaWeiboEngine];
}

- (void)resetSinaWeiboEngine
{
    sinaWeiboEngine_.userID = self.userId;
    sinaWeiboEngine_.accessToken = self.accessToken;
    sinaWeiboEngine_.expirationDate = [NSDate dateWithTimeIntervalSince1970:[self.expirationDate doubleValue]];
}

- (void)authorize{
    if ([self isAuthorizeValid]) {
        [self.delegate oauth_didAlreadyLogin];
    }else{
        [sinaWeiboEngine_ logIn];
    }
}

- (void)unauthorized{
    [super unauthorized];
    [sinaWeiboEngine_ logOut];
}

- (void)getUserInfo{
    [self getOtherUserInfo:sinaWeiboEngine_.userID];
}

- (void)getOtherUserInfo:(NSString *)uid{
    self.apiUri = APIUserShow;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:uid, @"uid", nil];
    [sinaWeiboEngine_ requestWithURL:@"users/show.json"
                                    params:params
                                    httpMethod:@"GET"
                                    delegate:self];
}
- (void)getOtherUserInfoByNick:(NSString *)nick{
    self.apiUri = APIUserShow;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:nick, @"screen_name", nil];
    [sinaWeiboEngine_ requestWithURL:@"users/show.json"
                                    params:params
                                    httpMethod:@"GET"
                                    delegate:self];
}
-(void)getBilateralFriendsWithCount:(int)count page:(int)page{
    [self getBilateralFriends:sinaWeiboEngine_.userID count:count page:page];
}
-(void)getBilateralFriends:(NSString *)uid count:(int)count page:(int)page{
    self.apiUri = APIGetBilateralFriends;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            uid, @"uid",
                            [NSString stringWithFormat:@"%d",count], @"count",
                            [NSString stringWithFormat:@"%d",page], @"page", nil];
    [sinaWeiboEngine_ requestWithURL:@"friendships/friends/bilateral.json"
                                    params:params
                                    httpMethod:@"GET"
                                    delegate:self];
}
-(void)getComments:(NSString *)wid{
    self.apiUri = APIGetComments;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            wid, @"id", nil];
    [sinaWeiboEngine_ requestWithURL:@"comments/show.json"
                                    params:params
                                    httpMethod:@"GET"
                                    delegate:self];
}
-(void)replyComment:(NSString *)wid cid:(NSString *)cid reply:(NSString *)reply{
    self.apiUri = APIReplyComment;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            wid, @"id",
                            cid, @"cid",
                            reply, @"comment",nil];
    [sinaWeiboEngine_ requestWithURL:@"comments/reply.json"
                                    params:params
                                    httpMethod:@"POST"
                                    delegate:self];
}
-(void)deleteComment:(NSString *)cid{
    self.apiUri = APIDeleteComment;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            cid, @"cid",nil];
    [sinaWeiboEngine_ requestWithURL:@"comments/destroy.json"
                                    params:params
                                    httpMethod:@"POST"
                                    delegate:self];
}
-(void)deleteStatus:(NSString *)wid{
    self.apiUri = APIDeleteStatus;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            wid, @"id",nil];
    [sinaWeiboEngine_ requestWithURL:@"statuses/destroy.json"
                                    params:params
                                    httpMethod:@"POST"
                                    delegate:self];
}
-(void)shareWithText:(NSString *)text{
    self.apiUri = APITextShare;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   text, @"status",nil];
    [sinaWeiboEngine_ requestWithURL:@"statuses/update.json"
                             params:params
                         httpMethod:@"POST"
                           delegate:self];
}
- (void)shareWithText:(NSString *)text url:(NSString *)url image:(UIImage *)image{
    self.apiUri = APITextShare;
    NSString *status = text;
    if (url) {
        status = [status stringByAppendingString:url];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   status, @"status",
                                   image, @"pic",nil];
    [sinaWeiboEngine_ requestWithURL:@"statuses/upload.json"
                             params:params
                         httpMethod:@"POST"
                           delegate:self];
}

#pragma mark - SinaWeibo Delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    self.userId      = sinaWeiboEngine_.userID;
    self.accessToken = sinaWeiboEngine_.accessToken;
    NSTimeInterval time =  [sinaWeiboEngine_.expirationDate timeIntervalSince1970];
    self.expirationDate = [NSString stringWithFormat:@"%lf", time];
    [self.delegate oauth_didLogin];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
    [self.delegate oauth_didLoginFailed:error];
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self.delegate oauth_didLoginFailed:error];
}

#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    switch (self.apiUri) {
        case APIUserShow:
            [self.delegate user_didGetInfoFailed:error];
            break;
        case APITextShare:
            [self.delegate message_didShareFailed:error];
            break;
        case APIGetBilateralFriends:
            [self.delegate user_didGetBilateralFriendsFailed:error];
            break;
        case APIGetComments:
            [self.delegate user_didGetCommentsFailed:error];
            break;
        case APIReplyComment:
            [self.delegate user_didReplyCommentFailed:error];
            break;
        case APIDeleteComment:
            [self.delegate user_didDeleteCommentFailed:error];
            break;
        case APIDeleteStatus:
            [self.delegate user_didDeleteStatusFailed:error];
            break;
        default:
            break;
    }
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    switch (self.apiUri) {
        case APIUserShow:
            [self.delegate user_didGetInfo:result];
            break;
        case APITextShare:
            [self.delegate message_didShare:result];
            break;
        case APIGetBilateralFriends:
            [self.delegate user_didGetBilateralFriends:result];
            break;
        case APIGetComments:
            [self.delegate user_didGetCommentsByWid:result];
            break;
        case APIReplyComment:
            [self.delegate user_didReplyComment:result];
            break;
        case APIDeleteComment:
            [self.delegate user_didDeleteComment:result];
            break;
        case APIDeleteStatus:
            [self.delegate user_didDeleteStatus:result];
            break;
        default:
            break;
    }
}

#pragma mark- abstract methods
- (BOOL)isAuthorizeValid{
    return [sinaWeiboEngine_ isLoggedIn] && ![sinaWeiboEngine_ isAuthorizeExpired];
}

@end
