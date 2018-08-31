
#当前版本 V:1.0.25
=============

## 东海游戏iOS SDK客户端说明文档

## 使用方法
==============

1. 打开DHSDKDemo.xcodeproj  将 frameworks文件 内的DHSDK.framework和DHSDK.xcassets添加(拖放)到你的工程目录中。

<div align=center><img width="300" height="200" src="https://github.com/donghaigame/iOS-DHSDKDemo/raw/master/Snapshots/FrameworkMaster.png"/></div>


2. 项目Targets下找到General。
TARGETS -> General -> Deployment Info 将  Device Orientation下勾选 （根据自需, 也可在plist种设置。勾选 Hide status bar 和requires full screen，并且在info.plist下加View controller-based status bar appearance 设置为NO

<div align=center><img width="300" height="200" src="https://github.com/donghaigame/iOS-DHSDKDemo/raw/master/Snapshots/FrameworkSeleted.png"/></div>


3.(必须添加)在TARGETS下的 Embedded Binaries 处 点击 + 号 点选链接 DHSDK frameworks: 如图


<div align=center><img width="250" height="200" src="https://github.com/donghaigame/iOS-DHSDKDemo/raw/master/Snapshots/FrameworkAddSouse.png"/></div>


4. 其中必要pilst 属性 （否则在用户注册并登陆保存信息的情况下会崩溃） 添加如下：

 ```
    NSPhotoLibraryUsageDescription -key
    需要获取您的相册权限用以保存账号密码 -string
    
    NSPhotoLibraryAddUsageDescription - key
    需要获取您的相册权限用以保存账号密码 - string
    
```



5.因为SDK支持横竖屏（根据自需），避免SDK显示异常 建议不要同时支持横竖屏 

```
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{

    //避免SDK显示异常 建议不要同时支持横竖屏 !!！
    
    //如果是横屏的游戏，请使用
    return UIInterfaceOrientationMaskLandscape ; 
  
   //如果是竖屏游戏，请使用
    return UIInterfaceOrientationMaskPortrait;

}
```

6. 导入 `<DHSDK/DHSDK.h>`</br>

```
import <SDKDemo/SDKDemo.h>
``` 
### 注：这些参数届时商务会与你们对接时提供，予以替换

```
 *  @param Id        游戏编号
 *  @param subId     游戏子包
 *  @param apiKey    游戏密钥
``` 

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

      [self.window makeKeyAndVisible];
      [SDHSDK initWithGameId:1
                 subGameId:1
                    apiKey:@"ba472a72208cb671639d94a54cbb017d"
                   success:^{
                       NSLog(@"初始化成功");
                   }
                   failure:^(int errcode, NSString *errorMessage) {
                       NSLog(@"初始化失败");
                   }];
}
```

### SDK基本使用方法示例：

#### 获取SDK版本号

```objective-c

  [[DHSDK share] v];
```


#### 登陆 

```objective-c
  //登陆
  [SDHSDK login];
  
  ```

#### 上传角色信息

```objective-c

- (void)reportRole
{
     NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:date];
    
    DHRole *role = [DHRole new];
    [role setServerId:@"serverId1"];
    [role setServerName:@"紫级墨瞳"];
    [role setRoleId:@"9527"];
    [role setRoleName:@"唐三"];
    [role setRoleLevel:1];
    [role setLoginTime:dateTime];
    [SDHSDK reportRole:role];
    
}
        
```

#### 用户注销

```objective-c

   //注销登出 -回调
   [SDHSDK logoutAccount];

```

#### 支付方法 

```objective-c
- (void)payButtonClick
{
 
    DHOrder *order    = [DHOrder new];
    order.serverId    = @"205"
    order.roleId      = @"1000001325020563";
    order.roleName    = @"费思远";
    order.productName = @"60元宝";
    order.customInfo  = @"自定义文字传输";
    order.cpOrderId   = @"order12938283492830"; (CP方订单)
    
    //totalFee && prdouctId 
    //金额与id 要一一对应，否则苹果支付会无法支付成功
    order.totalFee = 600;(分制)
    order.productId = @"com.dh.sdkdemo.6";
    order.productDescription = @"元宝可用于购买商城用品";
    [SDHSDK createOrder:order];
}
```

####  注册相关回调方法

```objective-c

- (void)registeredMethForCallBack{

 //登陆成功 -回调
    [SDHSDK setLoginCallBack:^(DHUser *user, DHLSS lSS) {
        
        NSString *userId    = user.userId;
        NSString *userName  = user.username;
        NSString *accessToken = user.accessToken;
        NSLog(@"userId      -- %@", userId);
        NSLog(@"userName    -- %@", userName);
        NSLog(@"accessToken -- %@", accessToken);
        
        if (lSS == DHLSBL) {
            NSLog(@"登陆");
        }
        
        else if (lSS == DHLSBR){
            NSLog(@"注册——》 登陆");
        }
        
        
    }];

    //注销账号 - 回调
    [SDHSDK setLogoutCallBack:^{
        //浮动按钮中有个 切换账号，
        //通过这个方法 初始化游戏,切换到登陆界面等操作
        
        
    }];
    

  [SDHSDK setDhInfoCallBack:^(DHPInfoType pType) {
        
    DHZCreateOrderFail      = 1,    //创建订单失败
    DHZDoesNotExistProduct  = 2,    //商品信息不存在
    DHZUnknowFail           = 3,    //未知错误
    DHZVerifyReceiptSucceed = 4,    //验证成功
    DHZVerifyReceiptFail    = 5,    //验证失败
    DHZURLFail              = 6     //未能连接苹果商店
    
  }];

  
  [SDHSDK setDhColseBack:^{

     //code

  }];
 

}

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
