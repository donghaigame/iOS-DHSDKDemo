//

//  Created by 熙文 张 on 17/6/16.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHRole : NSObject


/**
 *  服务器Id
 */
@property (nonatomic, strong) NSString *serverId;

/**
 *  服务器名称
 */
@property (nonatomic, strong) NSString *serverName;

/**
 *  角色Id
 */
@property (nonatomic, strong) NSString *roleId;

/**
 *  角色名称
 */
@property (nonatomic, strong) NSString *roleName;

/**
 *  角色等级
 */
@property (nonatomic, assign) NSUInteger roleLevel;

/**
 *  登陆时间
 */
@property (nonatomic, strong) NSString *loginTime;


#pragma mark - 增加
/**
 *  当前角色身上拥有的游戏币数量
 */
@property (nonatomic, strong) NSString *strMoneyNum;

/**
 *  用户id
 */
@property (nonatomic, strong) NSString *userId;

/**
 *  统计类型
 */
@property (nonatomic, strong) NSString *type;


@end
