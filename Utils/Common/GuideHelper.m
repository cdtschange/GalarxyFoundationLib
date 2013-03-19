//
//  GuideHelper.m
//  WandaKtvLib
//
//  Created by Wei Mao on 1/6/13.
//  Copyright (c) 2013 Wanda Inc. All rights reserved.
//

#import "GuideHelper.h"
#import "AppInfoHelper.h"

@implementation GuideHelper

+(void)setGuideView:(UIWindow *)window withGuideViewController:(id)guideViewController{
    // 进入引导页面
    NSString *str = [NSString stringWithFormat:@"%@-%@-AppNotFirstLaunch",[AppInfoHelper appName],[AppInfoHelper appVersion]];
    BOOL firstLaunch = [[NSUserDefaults standardUserDefaults] boolForKey:str];
    if (!firstLaunch) {
        window.rootViewController = guideViewController;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:str];
    }
}

@end
