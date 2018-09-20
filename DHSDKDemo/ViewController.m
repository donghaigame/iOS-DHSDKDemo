//
//  ViewController.m
//  DHSDKDemo
//
//  Created by xuxiaolei on 2018/7/9.
//  Copyright © 2018年 GeneralProject. All rights reserved.
//

#import "ViewController.h"
#import <DHSDK/DHSDK.h>
#import "NSObject+MD5.h"



#define DHID      @"1"
#define DHSubID   @"1"
#define DHAPI_key @"ba472a72208cb671639d94a54cbb017d"


@interface ViewController ()
{
    NSArray *_btnTitles;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    
    NSLog(@"SDK版本%@", [SDHSDK v]);
    
    
    /**
     *  说明文档
     *  https://github.com/donghaigame/iOS-DHSDKDemo   客户端
     *  https://github.com/donghaigame/DHSDKServerDemo 服务端
     */
    
    //初始化SDK - 东海测试

    [SDHSDK initWithDhId:[DHID intValue]
                   subId:[DHSubID intValue]
                  apiKey:DHAPI_key
                 success:^{
                     
                     NSLog(@"初始化成功");
                     
                 } failure:^(int errcode, NSString *errorMessage) {
                     
                     
                     
                 }];
    
    
    
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor brownColor]];
    
    _btnTitles = @[@"登 陆",@"支 付",@"用户中心",@"注 销"];
    
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
    
  
    //注册回调方法
    [self registeredMethForCallBack];
    
}

#pragma mark - 相关回调事件


- (void)registeredMethForCallBack{
    
    //登陆成功 -回调
    [SDHSDK setLoginCallBack:^(DHUser *user, DHLSS lSS) {
        
        NSString *userId    = user.userId;
        NSString *userName  = user.username;
        NSString *accessToken = user.accessToken;
        NSLog(@"userId      -- %@", userId);
        NSLog(@"userName    -- %@", userName);
        NSLog(@"accessToken -- %@", accessToken);
  
        //登陆验证
        [self testMeth:accessToken];
        
    }];
    
    //注销账号 - 回调
    [SDHSDK setLogoutCallBack:^{
        //浮动按钮中有个 切换账号，
        //通过这个方法 初始化游戏,切换到登陆界面等操作

    }];
    
    //IAP支付  - 回调
    [SDHSDK setDhInfoCallBack:^(DHPInfoType pType) {
        
        
    }];
    
    //API支付页面关闭 - 回调
    [SDHSDK setDhColseBack:^{
        
        
        
    }];
 
}


#pragma mark - 按钮点击事件

- (void)tempBtnClick:(UIButton *)sender{
    
    
    switch (sender.tag) {
    
        case 0:{
            //登陆
            [SDHSDK login];

            
        }
            break;
            
            //支付
        case 1:{
            
            DHOrder *order = [DHOrder new];
            order.serverId =@"10086";
            order.roleId = @"10086";
            order.roleName =@"东海支付测试";
            order.productName =@"60元宝";
            order.customInfo = @"自定义内容";
            //cp创建订单号
            order.cpOrderId = @"123456abcdefg";
            order.productDescription = @"60个砖石";
            order.productId = @"com.dhsdk.demo.6";
            order.totalFee = 600; //分制
            [SDHSDK createOrder:order];
            
        }
            break;
            
            //用户中心
        case 2:{
           [SDHSDK userCenter];
           
        }
            break;
            
            //注销登出
        case 3:{
            [SDHSDK logoutAccount];
            
        }
            break;
    
      
    }
    
}

//验证登陆
- (void)testMeth:(NSString *)accessToken{
    
    NSString *gameId = DHID;
    NSString *subGameId = DHSubID;
    NSString *apiKey = DHAPI_key;
    
    NSString *url = [NSString stringWithFormat:@"https://api.sdk.dhios.cn/open/verifyAccessToken"];
    NSString *sign = [NSString stringWithFormat:@"%@=%@%@=%@%@=%@%@",@"accessToken",accessToken,@"gameId",gameId,@"subGameId",subGameId,apiKey];
    
    NSLog(@"sign前：：%@",sign);
    
    NSString *md5Sign = [NSString md5:sign];
    
    NSLog(@"sign后：：%@",md5Sign);
    
    NSDictionary *dic = @{@"accessToken":accessToken,
                          @"gameId":gameId,
                          @"subGameId":subGameId,
                          @"sign": md5Sign
                          };
    NSString *parametersString =  [ViewController dictionaryToString:dic];
    NSLog(@"parametersString     %@ ",parametersString);
    
    NSURL *requestUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    
    [request setHTTPMethod:@"POST"];
    if (parametersString) {
        [request setHTTPBody:[parametersString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data,NSError * _Nullable connectionError) {
        if (connectionError == nil) {
            
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"请求结果%@,",responseObject);
            NSString *code = responseObject[@"code"];
            NSLog(@"code: %@",code);
            NSString *userName = responseObject[@"data"][@"userName"];
            NSLog(@"name：%@",userName);
        }
        else
        {
            
        }
    }];
}





+ (NSString *)dictionaryToString:(NSDictionary *)parameters
{
    NSString *postString = [NSString new];
    
    NSString *strCom = [NSString new];
    
    NSArray *keyArray = [parameters allKeys];
    NSString *strName = nil;
    NSString *strValue = nil;
    for (int i = 0; i < keyArray.count; i ++) {
        
        strName = keyArray[i];
        strValue = parameters[keyArray[i]];
        strValue = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                         (CFStringRef)strValue,
                                                                                         NULL,
                                                                                         (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                         kCFStringEncodingUTF8));
        if (i == keyArray.count - 1) {
            strCom = [NSString stringWithFormat:@"%@=%@",strName,strValue];
        } else {
            strCom = [NSString stringWithFormat:@"%@=%@&",strName,strValue];
        }
        
        postString = [postString stringByAppendingString:strCom];
    }
    
    return postString;
}




@end
