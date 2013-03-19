//
//  UIView+GetScreenShot.h
//  GalarxyFoundationLib
//
//  Created by Wei Mao on 12/26/12.
//  Copyright (c) 2012 cdts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (UIImage_ScreenShot)

- (UIImage *)getScreenShot;
- (BOOL)screenShotInFile:(NSString *)filePath;

@end
