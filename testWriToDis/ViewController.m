//
//  ViewController.m
//  testWriToDis
//
//  Created by Sun on 16/4/19.
//  Copyright © 2016年 huawo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //json数据封包
    //NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"value1",@"key1",@"value2",@"key2",@"value3",@"key3", nil];
    // isValidJSONObject判断对象是否可以构建成json对象
    NSDictionary * JSON_INFO_STRING =
    @{
      @"video_url": @"http://xxxx.com/xxx.mp4",
      @"image_url": @"http://xxxx.com/xxx.jpg",
      @"nickname":  @"nickname"
      };

    
    NSDictionary *dic =@{
                         @"alarm_type" : @"04",
                         @"alarm_info":JSON_INFO_STRING,
                         @"location":@"南京",
                         @"title":@"美丽雪景1",
                         @"cid":@"456",
                         @"uid":@"123456"
                         };
    
    if ([NSJSONSerialization isValidJSONObject:dic]){
        NSError *error;
        // 创造一个json从Data, NSJSONWritingPrettyPrinted指定的JSON数据产的空白，使输出更具可读性。
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"json data:%@",json);
    }else {
        NSLog(@"JSON数据生成失败，请检查数据格式");
    }
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.创建请求
    NSURL *url = [NSURL URLWithString:@"http://112.124.22.129/alarm/restapi/postAlarmInfo"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 2.设置请求头
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 3.设置请求体
    
    NSDictionary *json =
    
    @{
        @"alarm_type" : @"04",
        @"alarm_info":@{@"video_url": @"",
                        @"image_url": @"",
                        @"nickname":  @"nickname"
                        },
        @"location":@"南京",
        @"title":@"美丽风景",
        @"cid":@"70002612",
        @"uid":@"test@test.com"
    };
    
    
    
   
    // json数据封包
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = data;
    
    // 4.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (!connectionError) {
            NSLog(@"datalength:%lu",(unsigned long)data.length);
            NSLog(@"data:%@",data);
            NSLog(@"error:%@",connectionError);
            
            //json数据解析
            NSDictionary *  response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"response[%@]",response);
            
            NSLog(@"code[%@]",[response objectForKey:@"code"]);
        }
       
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
