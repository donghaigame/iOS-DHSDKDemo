//
//  ViewController.m
//  DHSDKDemo
//
//  Created by xuxiaolei on 2018/7/9.
//  Copyright © 2018年 GeneralProject. All rights reserved.
//

#import "ViewController.h"
#import <DHSDK/DHSDK.h>

@interface ViewController ()
{
    UIImageView *_bgImageView;
    NSArray *_btnTitles;
    
}


@end

@implementation ViewController

- (void)viewDidLoad {
    NSLog(@"SDK版本%@", [[DHSDK share] v]);
    
    [super viewDidLoad];
 
    UIImageView *bgImageView = [UIImageView new];
    [bgImageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:bgImageView];
    _bgImageView = bgImageView;
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    _btnTitles = @[@"初始化",@"登 陆",@"买个表",@"注 销",@"用户中心",@"修改地址"];
    
    [_btnTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tempBtn setFrame:CGRectMake(140, 60 + (36 + 20) * idx , 100, 36)];
        [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tempBtn setBackgroundColor:[UIColor brownColor]];
        [tempBtn setTitle:obj forState:UIControlStateNormal];
        [tempBtn setTag:idx];
        [tempBtn addTarget:self action:@selector(tempBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tempBtn];
        
    }];
    
    
    UILabel *serverLabel = [UILabel new];
    [serverLabel setTag:11];
    [serverLabel setTextColor:[UIColor redColor]];
    [serverLabel setFrame:CGRectMake(140, 60 + (36 + 20) * 7, 300, 36)];
    [serverLabel setText:[DHSDK share].serverURL];
    [self.view addSubview:serverLabel];
    
    [[DHSDK share] setLB:^{
        NSLog(@"注销事件的回调");
    }];
    
    [[DHSDK share] setCOB:^(DHZC zc) {
        NSLog(@"IAP支付回调 - %ld", (long)zc);
    }];
    
    [[DHSDK share] setFuckVCB:^{
        NSLog(@"支付页面关闭的回调");
    }];
    
    
    //登陆成功回调 ，获取个人信息进行相应处理
    [[DHSDK share] setLSB:^(DHUser *user, DHLSS lss) {
        NSString *userId    = user.userId;
        NSString *userName  = user.username;
        NSString *accessToken = user.accessToken;
        NSLog(@"userId      -- %@", userId);
        NSLog(@"userName    -- %@", userName);
        NSLog(@"accessToken -- %@", accessToken);
        
        if (lss == DHLSBL) {
            NSLog(@"登陆来源");
        }
        else if (lss == DHLSBR)
        {
            NSLog(@"注册来源");
        }

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
        [[DHSDK share] rl:role];
        
    }];
}


#pragma mark 按钮点击事件

- (void)tempBtnClick:(UIButton *)sender{
    
    
    switch (sender.tag) {
        
        //初始化
        case 0:{
            
            [[DHSDK share] it:1
                        subId:1
                       apiKey:@"ba472a72208cb671639d94a54cbb017d"
                      success:^{
                          NSLog(@"初始化成功");
                      } failure:^(int errcode, NSString *errorMessage) {
                          NSLog(@"初始化失败");
                      }];
            
            
        }
            break;
        //登陆
        case 1:{
            [[DHSDK share] l];
            
        }
            break;
        //买个表
        case 2:{
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
            break;
        //注销
        case 3:{
            [[DHSDK share] lo];
           
        }
            break;
        //用户中心
        case 4:{
            [[DHSDK share] C];
            
        }
            break;
        //改变地址
        case 5:{
            
            if ([@"https://api.mikegame.cn" isEqualToString:[[DHSDK share] serverURL]]) {
                [[DHSDK share] setServerURL:@"http://192.168.25.151:8083"];
            }else if ([@"http://192.168.25.151:8083" isEqualToString:[[DHSDK share] serverURL]]) {
                [[DHSDK share] setServerURL:@"https://api.mikegame.cn"];
            }
            [[self.view viewWithTag:11] setText:[DHSDK share].serverURL];
            
        }
            break;
      
    }
    
}




@end
