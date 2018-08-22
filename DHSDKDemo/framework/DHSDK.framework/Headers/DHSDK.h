//

//
//  Created by 张熙文 on 2017/5/16.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHOrder.h"
#import "DHUser.h"
#import "DHRole.h"


#define SDHSDK  [DHSDK share]

//! Project version number for SDK.
FOUNDATION_EXPORT double MKSDKVersionNumber;

//! Project version string for SDK.
FOUNDATION_EXPORT const unsigned char MKSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <MKSDK/PublicHeader.h>

typedef NS_ENUM(NSInteger, DHPInfoType) {
    DHZCreateOrderFail      = 1,    //创建订单失败
    DHZDoesNotExistProduct  = 2,    //商品信息不存在
    DHZUnknowFail           = 3,    //未知错误
    DHZVerifyReceiptSucceed = 4,    //验证成功
    DHZVerifyReceiptFail    = 5,    //验证失败
    DHZURLFail              = 6     //未能连接苹果商店
};

typedef NS_ENUM(NSInteger, DHLSS) {
    DHLSBL      = 1,    //登陆成功来源
    DHLSBR   = 2,       //注册成功来源
};


typedef void (^LoginSuccessBack)(DHUser *user, DHLSS lSS);
typedef void (^LogoutCallBack)(void);
typedef void (^DHColseBack)(void);
typedef void (^DHInfoCallBack)(DHPInfoType pType);


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
@property (nonatomic, copy) LoginSuccessBack loginCallBack;
@property (nonatomic, copy) LogoutCallBack logoutCallBack;
@property (nonatomic, copy) DHColseBack colseBack;
@property (nonatomic, copy) DHInfoCallBack infoCallBack;

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
 *  @param gameId        游戏编号
 *  @param subGameId     游戏子包
 *  @param apiKey        游戏密钥
 */
- (void)initWithGameId:(int)gameId
             subGameId:(int)subGameId
                apiKey:(NSString *)apiKey
               success:(void (^)(void))successBlock
               failure:(void (^)(int errcode, NSString *errorMessage))errorBlock;



#pragma mark - 创建订单

/**
 *  创建订单
 *  @param order    订单信息
 */
- (void)createOrder:(DHOrder *)order;


#pragma mark - 用户中心

/**
 *  用户中心
 */
- (void)userCenter;


#pragma mark - 上报角色

/**
 *  上报角色
 *
 *  @param role    游戏角色
 */
- (void)reportRole:(DHRole *)role;


#pragma mark - 显示/隐藏 浮动按钮

/**
 *  展示浮动按钮
 */
- (void)showFloatBtn;

/**
 *  隐藏浮动按钮
 */
- (void)disFloatBtn;


#pragma mark - 登录 回调

/**
 *  用户登录
 */

- (void)login;

/**
 *  登陆成功回调
 *  @param loginCallBack loginCallBack description
 */
- (void)setLoginCallBack:(LoginSuccessBack)loginCallBack;


//#pragma mark - 登录带回调的，考虑到 用户第一次 注册账号并登陆操作，
//               还是需要手动注册一次登陆成功回调，所以此处注释掉。
//               如果想用可以自行打开。自选/预留
//- (void)loginSucessCallBack:(LoginSuccessBack )callBack;


#pragma mark - 登出/切换账号 回调

/**
 *  注销/登出/切换账号
 */
- (void)logoutAccount;


/**
 * 登出/注销账号回调
 * @param logoutCallBack logoutCallBack description
 */
- (void)setLogoutCallBack:(LogoutCallBack)logoutCallBack;


//#pragma mark - 登出切换账号，考虑到触发方法都在SDK
//               所以带回调方法不适用。预留/备用
//- (void)logoutAccountCallBack:(LogoutCallBack )callBack;




@end
