//
//  AppDelegate.m
//  DHSDKDemo
//
//  Created by xuxiaolei on 2018/7/9.
//  Copyright © 2018年 GeneralProject. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <DHSDK/DHSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *viewController = [ViewController new];
    [self.window setRootViewController:viewController];
    [self.window makeKeyAndVisible];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    
    /**
     *  说明文档
     *  https://github.com/donghaigame/iOS-DHSDKDemo   客户端
     *  https://github.com/donghaigame/DHSDKServerDemo 服务端
     */
    
    //初始化SDK - 东海测试
    [SDHSDK initWithGameId:1
                 subGameId:1
                    apiKey:@"ba472a72208cb671639d94a54cbb017d"
                   success:^{
                       NSLog(@"初始化成功");
                   }
                   failure:^(int errcode, NSString *errorMessage) {
                       NSLog(@"初始化失败");
                   }];
    
    
    return YES;
}


- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{

    
    return UIInterfaceOrientationMaskLandscape;
    
}

   
@end
