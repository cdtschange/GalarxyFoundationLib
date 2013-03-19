//
//  CommonHelper.m
//  CdtsFramework
//
//  Created by Wei Mao on 9/18/12.
//
//

#import "GUIDHelper.h"

@implementation GUIDHelper

+(NSString *) gen_uuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    return uuid;
}
@end
