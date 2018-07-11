//
//  XSUser.h
//  XSSDK
//
//  Created by 熙文 张 on 17/4/17.
//  Copyright © 2017年 熙文 张. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHUser : NSObject


/**
 *  用户ID
 */
@property (nonatomic, strong) NSString *userId;

/**
 *  用户名
 */
@property (nonatomic, strong) NSString *username;

/**
 *  会话ID
 */
@property (nonatomic, strong) NSString *accessToken;




@end
