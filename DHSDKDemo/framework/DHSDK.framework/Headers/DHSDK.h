//

//
//  Created by 张熙文 on 2017/5/16.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHOrder.h"
#import "DHUser.h"
#import "DHRole.h"

//! Project version number for SDK.
FOUNDATION_EXPORT double MKSDKVersionNumber;

//! Project version string for SDK.
FOUNDATION_EXPORT const unsigned char MKSDKVersionString[];
            
// In this header, you should import all the public headers of your framework using statements like #import <MKSDK/PublicHeader.h>

typedef NS_ENUM(NSInteger, DHZC) {
    DHZCreateOrderFail      = 1,    //创建订单失败
    DHZDoesNotExistProduct  = 2,    //商品信息不存在
    DHZUnknowFail           = 3,    //未知错误
    DHZVerifyReceiptSucceed = 4,    //支付验证成功
    DHZVerifyReceiptFail    = 5,    //支付验证失败
    DHZURLFail              = 6     //未能连接苹果商店
};

typedef NS_ENUM(NSInteger, DHLSS) {
    DHLSBL      = 1,    //登陆成功来源
    DHLSBR   = 2,       //注册成功来源
};




typedef void (^lSB)(DHUser *user, DHLSS lSS);
typedef void (^lB)(void);
typedef void (^fuckVCB)(void);
typedef void (^cOB)(DHZC zc);


@interface DHSDK : NSObject

/**
 *  游戏编号
 */
@property (nonatomic, readonly, assign) int gameId;

/**
 *  游戏渠道
 */
@property (nonatomic, readonly, assign) int subId;

/**
 *  游戏密钥
 */
@property (nonatomic, readonly, strong) NSString *apiKey;


@property (nonatomic, strong) NSString *serverURL;

/**
 *  登陆成功后当前用户信息
 */
@property (nonatomic, strong, readonly) DHUser *currUser;
@property (nonatomic, copy) lSB lSB;
@property (nonatomic, copy) lB lB;
@property (nonatomic, copy) fuckVCB fuckVCB;
@property (nonatomic, copy) cOB cOB;

/**
 *  获取DHSDK单例
 *
 *  @return DHSDK单例对象
 */
+ (DHSDK *)share;

/**
 *  获取SDK版本号 eg:1.0.0 三段
 */
- (NSString *)v;


/**
 *  初始化SDK
 *
 *  @param Id    游戏编号
 *  @param subId     游戏子包
 *  @param apiKey    游戏密钥
 */
- (void)it:(int)Id
     subId:(int)subId
    apiKey:(NSString *)apiKey
   success:(void (^)(void))successBlock
   failure:(void (^)(int errcode, NSString *errorMessage))errorBlock;

/**
 *   用户登陆
 *
 */
- (void)l;


/**
 *
 *
 *  @param order    订单信息
 */
- (void)z:(DHOrder *)order;


/**
 *  注销用户登陆接口
 */
- (void)lo;

/**
 *  用户中心
 */
- (void)C;

/**
 *  上报角色
 *
 *  @param role    游戏角色
 */
- (void)rl:(DHRole *)role;


/**
 *  注销事件回调
 */
- (void)setLB:(lB)lB;


/**
 *  登陆成功回调
 */
- (void)setLSB:(lSB)lSB;

/**
 *  支付页面关闭回调
 */
- (void)setFuckVCB:(fuckVCB)fuckVCB;


/**
 *  IAP支付回调
 */
- (void)setCOB:(cOB)cOB;


/**
 *  展示浮动按钮
 */
- (void)SF;

/**
 *  隐藏浮动按钮
 */
- (void)DF;
@end
