//
//  NSObject+MD5.m
//  DHSDKDemo
//
//  Created by 徐小雷 on 2018/9/7.
//  Copyright © 2018年 GeneralProject. All rights reserved.
//

#import "NSObject+MD5.h"
#import <AdSupport/AdSupport.h>
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"


@implementation NSObject (MD5)

-(NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}



@end
