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
    NSArray *_btnTitles;
    
}


@end

@implementation ViewController

- (void)viewDidLoad {
    
    NSLog(@"SDK版本%@", [[DHSDK share] v]);
    
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor brownColor]];
    
    _btnTitles = @[@"初始化",@"登 陆",@"支 付",@"用户中心",@"注 销"];
    
    //家就是的看见爱上的
    CGFloat topMar = 40;
    CGFloat lefMar = 40;
    CGFloat itemMar = 18;
    CGFloat itemWidth = 120;
    CGFloat itemHeight = 38;
    UIImage *btbImage = [UIImage imageNamed:@"Button_Normal"];
    UIImage *btnImageHighlighted = [UIImage imageNamed:@"Button_Highlighted"];
    
    [_btnTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tempBtn setFrame:CGRectMake(lefMar, topMar + (itemHeight + itemMar) * idx , itemWidth, itemHeight)];
        [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tempBtn setTitle:obj forState:UIControlStateNormal];
        [tempBtn setTag:idx];
        [tempBtn setBackgroundImage:btbImage forState:UIControlStateNormal];
        [tempBtn setBackgroundImage:btnImageHighlighted forState:UIControlStateSelected];
        [tempBtn addTarget:self action:@selector(tempBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tempBtn];
        
    }];
    
    
    [self methForCallBack];
    

}

#pragma mark - 相关回调事件


- (void)methForCallBack{
    
    
     //IAP支付 - 回调
    [[DHSDK share] setPayInfoCallBack:^(DHPayInfoType payType) {
       
        
        //code
    }];
    
    
    //支付页面关闭 - 回调
    [[DHSDK share] setPayColseBack:^{
       
        //code
        
    }];
    
    
    //切换账号/注销/登出回到
    [[DHSDK share] setLogoutCallBack:^{
       
        //code 如:重启游戏，注销用户信息

        
    }];
    
}

#pragma mark - 按钮点击事件

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
    
        case 1:{
     
            //登陆成功 回调
            [[DHSDK share] loginSucessCallBack:^(DHUser *user, DHLSS lSS) {

                NSString *userId    = user.userId;
                NSString *userName  = user.username;
                NSString *accessToken = user.accessToken;
                NSLog(@"userId      -- %@", userId);
                NSLog(@"userName    -- %@", userName);
                NSLog(@"accessToken -- %@", accessToken);
                
                //通过accessToken -> 去访问你们自己的校验接口 -> 再服务端去请求SDK服务器校验接口 - > 拿到用户id 和用户名创建游戏账号并绑定 -> 有用户信息即可登陆游戏界面（大致流程）
                
                
                if (lSS == DHLSBL) {
                    NSLog(@"登陆");
                }
                
                else if (lSS == DHLSBR){
                    NSLog(@"注册——》 登陆");
                }
                
                
                /*
                 * 在相应的位置-自行调用上传角色信息
                 **/
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
                [[DHSDK share] reportRole:role];
                
                
            }];
            
        }
            break;
        //支付
        case 2:{
            
            
            DHOrder *order = [DHOrder new];
            order.serverId =@"205";
            order.roleId = @"1000001325020563";
            order.roleName =@"费思远";
            order.productName =@"60元宝";
            CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
            NSString *orderId = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidRef));
            order.customInfo = orderId;
            order.cpOrderId = orderId;
            order.productDescription = @"60个砖石";
            order.productId = @"com.dh.sdkdemo.6";
            order.totalFee = 600; //分制
            [[DHSDK share] createOrder:order];
            
        }
            break;
        //用户中心
        case 3:{
            [[DHSDK share] userCenter];
           
        }
            break;
       
        case 4:{
            //注销登出/切换账号
          
            [[DHSDK share] logoutAccount];
            
        }
            break;
    
      
    }
    
}





@end
