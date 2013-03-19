//
//  AppInfoHelper.m
//  WandaKtvLib
//
//  Created by Wei Mao on 1/6/13.
//  Copyright (c) 2013 Wanda Inc. All rights reserved.
//

#import "AppInfoHelper.h"

@implementation AppInfoHelper

+(NSString *)appName{
    NSDictionary *appInfoDict = [[NSBundle mainBundle] infoDictionary];
    return appInfoDict[(NSString *)kCFBundleIdentifierKey];
}
+(NSString *)appVersion{
    NSDictionary *appInfoDict = [[NSBundle mainBundle] infoDictionary];
    CGFloat version = [[appInfoDict objectForKey:@"CFBundleShortVersionString"] floatValue];
    CGFloat build = [[appInfoDict objectForKey:@"CFBundleVersion"] floatValue];
    CGFloat appVersion = version*1000+build*10;
    return [NSString stringWithFormat:@"%.0f", appVersion];
}
@end
