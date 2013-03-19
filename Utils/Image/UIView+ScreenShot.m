//
//  UIView+GetScreenShot.m
//  GalarxyFoundationLib
//
//  Created by Wei Mao on 12/26/12.
//  Copyright (c) 2012 cdts. All rights reserved.
//

#import "UIView+ScreenShot.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (UIImage_ScreenShot)

-(UIImage *)getScreenShot{
    //************** 得到图片 *******************
    CGRect rect = self.frame;  //截取图片大小
    //开始取图，参数：截图图片大小
    UIGraphicsBeginImageContext(rect.size);
    //截图层放入上下文中
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    //从上下文中获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束截图
    UIGraphicsEndImageContext();
    return image;
}

- (BOOL)screenShotInFile:(NSString *)filePath{
    UIImage *image = [self getScreenShot];
    return [UIImagePNGRepresentation(image)writeToFile: filePath atomically:YES];
}
@end
