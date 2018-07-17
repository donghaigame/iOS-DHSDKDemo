# 东海游戏iOS SDK客户端说明文档
东海游戏iOS SDKDemo  https://github.com/donghaigame/iOS-DHSDKDemo.git



使用方法
==============

1. 打开DHSDKDemo.xcodeproj  将 frameworks文件 内的DHSDK.framework和DHSDK.xcassets添加(拖放)到你的工程目录中。

![image](https://github.com/donghaigame/iOS-DHSDKDemo/raw/master/Snapshots/FrameworkMaster.png)

2. 项目Targets下找到General。
TARGETS -> General -> Deployment Info 将  Device Orientation下勾选 （根据自需，是否横竖屏切换 ）例如在AppDelegate.m, 也可在plist种设置。
```
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
   return UIInterfaceOrientationMaskPortrait;
}
```
![image](https://github.com/donghaigame/iOS-DHSDKDemo/raw/master/Snapshots/FrameworkSeleted.png)

3. 勾选 Hide status bar 和requires full screen，并且在info.plist下加View controller-based status bar appearance 设置为NO
并且在Embedded Binaries和Linked Frameworks and Libraries链接 frameworks:

![image](https://github.com/donghaigame/iOS-DHSDKDemo/raw/master/Snapshots/FrameworkAddSouse.png)

4. 其中必要pilst 属性 如下：

    NSPhotoLibraryUsageDescription -key
    需要获取您的相册权限用以保存账号密码 -string
    NSPhotoLibraryAddUsageDescription - key
    需要获取您的相册权限用以保存账号密码 - string
    NSAppTransportSecurity
        NSAllowsArbitraryLoads - YES

4. 导入 `<DHSDK/DHSDK.h>`。
```
#import <SDKDemo/SDKDemo.h>

 *  @param Id        游戏编号
 *  @param subId     游戏子包
 *  @param apiKey    游戏密钥
 
注：这些参数届时商务会与你们对接提供，予以替换
```

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self.window makeKeyAndVisible];
    [[DHSDK share] it:1
    subId:1
    apiKey:@"ddba75a7871543628652fb20996be609"
    success:^{

    } failure:^(int errcode, NSString *errorMessage) {

    }];
}
```

5. SDK基本使用方法示例：

#### 获取SDK版本号

```objective-c
  [[DHSDK share] v];
```

#### 登陆方法

```objective-c
- (void)loginButtonClick
{
   [[DHSDK share] l];
}
```

#### 登陆成功 - 回调方法

```objective-c

[[DHSDK share] setLSB:^(DHUser *user, DHLSS lss) {
    NSString *userId    = user.userId;
    NSString *userName  = user.username;
    NSString *accessToken = user.accessToken;
    if (lss == DHLSBL) {
    NSLog(@"从哪登录来的");
    }
    else if (lss == DHLSBR){
    NSLog(@"从哪注册来的");
    }

    //获取当前登录时间。
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:date];


    //上报角色
    DHRole *role = [DHRole new];
    [role setServerId:@"serverId1"];
    [role setServerName:@"东海国际"];
    [role setRoleId:@"89757"];
    [role setRoleName:@"东海龙王"];
    [role setRoleLevel:1];
    [role setLoginTime:dateTime];
    [[DHSDK share] rl:role];

}];

```

#### 用户注销 - 回调方法

```objective-c
[[DHSDK share] setLB:^{

  //code
}];
```

#### 支付方法 

```objective-c
- (void)payButtonClick
{
    DHOrder *order = [DHOrder new];
    order.serverId =@"app_101";
    order.totalFee = 1;
    order.roleId = @"500000";
    order.roleName =@"luzj";
    order.productName =@"60钻石";
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *orderId = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidRef));
    order.customInfo = orderId;
    order.cpOrderId = orderId;
    order.productDescription = @"60个钻石";
    order.productId = @"com.dhajdh.qjfs18010321";
    [[DHSDK share] z:order];
}
```

####  关闭支付页面 - 回调方法

```objective-c
[[DHSDK share] setFuckVCB:^{

  //code
}];
```

#### IAP支付 - 回调方法
```objective-c
[[DHSDK share] setCOB:^(DHZC zc) {


    //code

    /*

    zc 枚举 对应回调相应事件
    DHZCreateOrderFail      = 1,    //创建订单失败
    DHZDoesNotExistProduct  = 2,    //商品信息不存在
    DHZUnknowFail           = 3,    //未知错误
    DHZVerifyReceiptSucceed = 4,    //支付验证成功
    DHZVerifyReceiptFail    = 5,    //支付验证失败
    DHZURLFail              = 6     //未能连接苹果商店 

    */


}];
```

注意
==============
1、项目编译build Settings 的Base SDK选当前最新的版本。至少iOS11以上。不然会出现一些比较奇怪的问题。
2、该项目最低支持 `iOS 8.0` 和 `Xcode 7.0`。


许可证
==============
DHSDK 使用 MIT 许可证，详情见 LICENSE 文件。


期待
==============
<ol>
<li>如果在使用过程中遇到BUG，希望你能Issues我，谢谢（或者尝试下载最新的框架代码看看BUG修复没有）
</li>
<li>如果在使用过程中发现功能不够用或者有改善的地方，希望你能Issues我，我们会尽力做得更好。谢谢
</li>
</ol>





