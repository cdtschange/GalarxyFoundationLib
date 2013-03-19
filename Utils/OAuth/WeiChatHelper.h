//
//  WeiChatManager.h
//  WandaKTV
//
//  Created by Wei Mao on 11/19/12.
//  Copyright (c) 2012 Wanda Inc.. All rights reserved.
//
#import "WXApi.h"
#import "OAuthHelper.h"
#import <Foundation/Foundation.h>

@interface WeiChatHelper : NSObject<WXApiDelegate>
@property (assign, nonatomic) enum WXScene scene;
@property (assign, nonatomic) id<OAuthHelperDelegate> delegate;
@property (copy, nonatomic) NSString *kWXAppKey;

+ (id)shareHelperWithAppKey:(NSString *)appKey;

- (void)shareWithText:(NSString *)text;
- (void)shareWithText:(NSString *)text url:(NSString *)url image:(UIImage *)image;
- (void)shareWithText:(NSString *)text title:(NSString *)title url:(NSString *)url image:(UIImage *)image;
@end
