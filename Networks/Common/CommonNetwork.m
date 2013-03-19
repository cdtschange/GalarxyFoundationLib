//
//  CommonNetwork.m
//  GalarxyFoundationLib
//
//  Created by Wei Mao on 12/24/12.
//  Copyright (c) 2012 cdts. All rights reserved.
//

#import "CommonNetwork.h"
#import "Reachability.h"

@implementation CommonNetwork

+ (BOOL)isNetworkReachable
{
	return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}
@end
