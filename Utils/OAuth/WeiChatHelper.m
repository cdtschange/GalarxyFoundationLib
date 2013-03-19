//
//  WeiChatManager.m
//  WandaKTV
//
//  Created by Wei Mao on 11/19/12.
//  Copyright (c) 2012 Wanda Inc.. All rights reserved.
//
// CLASS INCLUDES
#import "WXApi.h"
#import "WeiChatHelper.h"
// CONST DEFINE
static WeiChatHelper *wxChatHelper = nil;

@implementation WeiChatHelper
@synthesize scene = scene_;
@synthesize delegate = delegate_;
@synthesize kWXAppKey = kWXAppKey_;

+ (id)shareHelperWithAppKey:(NSString *)appKey{
    if (!wxChatHelper) {
        wxChatHelper = [[WeiChatHelper alloc] init];
        wxChatHelper.kWXAppKey = appKey;
        [WXApi registerApp:appKey];
    }
    return wxChatHelper;
}

- (id)init{
    self = [super init];
    if (self) {
        scene_ = WXSceneSession;
    }
    return self;
}

- (void)shareWithText:(NSString *)text{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    req.text  = text;
    req.scene = scene_;
    [WXApi sendReq:req];
}
-(void)shareWithText:(NSString *)text url:(NSString *)url image:(UIImage *)image{
    [self shareWithText:text title:nil url:url image:image];
}

-(void)shareWithText:(NSString *)text title:(NSString *)title url:(NSString *)url image:(UIImage *)image{
    // 多媒体消息
    WXMediaMessage *message = [WXMediaMessage message];
    message.title       = title;
    message.description = text;
    [message setThumbImage:image];

    // 关联网页链接地址
    WXWebpageObject *ext = [WXWebpageObject object];
    message.mediaObject = ext;
    ext.webpageUrl      = url;
    
    // 发送消息
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText   = NO;
    req.message = message;
    req.scene   = scene_;
    [WXApi sendReq:req];
}


#pragma mark- WXApiDelegate
-(void) onReq:(BaseReq*)req{
    
}

-(void) onResp:(BaseResp*)resp{
    if (delegate_) {
        if (resp.errCode == 0 && [delegate_ respondsToSelector:@selector(message_didShare:)]) {
            [delegate_ message_didShare:resp];
        }
        
        if (resp.errCode != 0 && [delegate_ respondsToSelector:@selector(message_didShareFailed:)]) {
            NSError *error = [NSError errorWithDomain:@"WeiChatSDKErrorDomain" code:resp.errCode userInfo:@{@"error":resp.errStr}];
            [delegate_ message_didShareFailed:error];
        }
    }
}

@end
