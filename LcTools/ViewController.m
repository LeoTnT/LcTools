//
//  ViewController.m
//  LcTools
//
//  Created by lichao on 2017/3/29.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import "ViewController.h"
#import "LCLabel.h"
#import "LCAlertTool.h"
#import "LCUUIDTool.h"
#import "NSString+LCExtension.h"
#import "HYZLocationManager.h"

@interface ViewController ()<LCLabelDelegate>
//@interface ViewController ()<LCLabelDelegate, HYZLocationDelegate>

@property (weak, nonatomic) IBOutlet LCLabel *textLabel;

//@property(nonatomic, strong) HYZLocationManager *hyzLocationManager;

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
}


#pragma mark -- HYZLocationManager使用示例
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    [self.hyzLocationManager beginUpdatingLocation];
//}
//
//- (void)locationDidEndUpdatingLocation:(CLLocation *)location placemark:(CLPlacemark *)placemark {
//
//    NSLog(@"%f---%f", location.coordinate.longitude, location.coordinate.latitude);
//
//    if (placemark != nil) {
//        if (placemark.administrativeArea) {
//            NSLog(@"定位地址:%@%@%@", placemark.administrativeArea, placemark.locality, placemark.subLocality);
//        }else {
//            NSLog(@"定位地址:%@%@", placemark.locality, placemark.subLocality);
//        }
//    }
//}
//
//- (HYZLocationManager *)hyzLocationManager {
//    if (!_hyzLocationManager) {
//        _hyzLocationManager = [[HYZLocationManager alloc] init];
//        _hyzLocationManager.delegate = self;
//    }
//    return _hyzLocationManager;
//}

#pragma mark -- LCLabel使用示例
/*===============================*/
//- (void)viewDidLoad {
//
//    [super viewDidLoad];
//
//    self.textLabel.text = @"#话题内容# 用于匹配字符串的内容显示, 用户:@盼盼, 话题:#怎么追漂亮女孩?#, 链接:https://github.com 协议:《退款政策》, 还有自定义要 高亮显示 的字符串.";
//
//    // 非匹配内容文字颜色
//    self.textLabel.lc_commonTextColor = [UIColor colorWithRed:112.0/255 green:93.0/255 blue:77.0/255 alpha:1];
//
//    // 点选高亮文字颜色
//    self.textLabel.lc_textHightLightBackgroundColor = [UIColor colorWithRed:237.0/255 green:213.0/255 blue:177.0/255 alpha:1];
//
//    //@用户
//    [self.textLabel setHightLightTextColor:[UIColor colorWithRed:132.0/255 green:77.0/255 blue:255.0/255 alpha:1] forHandleStyle:HandleStyleUser];
//    //URL
//    [self.textLabel setHightLightTextColor:[UIColor colorWithRed:9.0/255 green:163.0/255 blue:213.0/255 alpha:1] forHandleStyle:HandleStyleLink];
//    //话题
//    [self.textLabel setHightLightTextColor:[UIColor colorWithRed:254.0/255 green:156.0/255 blue:59.0/255 alpha:1] forHandleStyle:HandleStyleTopic];
//    //协议
//    [self.textLabel setHightLightTextColor:[UIColor blackColor] forHandleStyle:HandleStyleProtocol];
//
//    // 自定义匹配的文字和颜色#8FDF5C
//    self.textLabel.lc_matchArr = @[
//                                   @{
//                                       @"string" : @"高亮显示",
//                                       @"color" : [UIColor colorWithRed:0.55 green:0.86 blue:0.34 alpha:1]
//                                       }
//                                   ];
//
//    // 匹配到合适内容的回调
//    self.textLabel.lc_tapOperation = ^(UILabel *label, HandleStyle style, NSString *selectedString, NSRange range){
//
//        // 你想要做的事
//        NSLog(@"block打印 %@", selectedString);
//
//    };
//
//    self.textLabel.delegate = self;
//
//}
//
//#pragma mark --------------------------------------------------
//#pragma mark LabelDelegate
//
//-(void)lc_label:(LCLabel *)label didSelectedString:(NSString *)selectedStr forStyle:(HandleStyle)style inRange:(NSRange)range{
//
//    // 你想要做的事
//    NSLog(@"代理打印 %@", selectedStr);
//    
//}

#pragma mark ======其他的使用示例
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{

//    [LCUUIDTool getUUID1];
//    [LCUUIDTool getUUID2];
//    [LCUUIDTool getIDFA];
//    [LCUUIDTool getIDFV];


//    [LCAlertTool alertViewShowWithController:self message:@"666"];
//    [LCAlertTool alertViewShowWithController:self title:@"提示框框" message:@"666" confirmTitle:@" 123" confirmHandle:^{
//        NSLog(@"111111111");
//    }];
//    [LCAlertTool alertViewShowWithController:self title:@"提示框" message:@"alertView提示你" confirmTitle:@"确定" confirmHandle:^{
//        NSLog(@"-------");
//    } cancleTitle:@"取消" cancleHandle:^{
//        NSLog(@"=======");
//    }];

//    [LCAlertTool actionSheetShowWithController:self confirmHandle:^{
//        NSLog(@"123123");
//    }];

//    [LCAlertTool actionsheetShowWithController:self title:@"提示框" confirmTitle:@"确定" confirmHandle:^{
//        NSLog(@"确定");
//    } cancleTitle:@"取消" cancleHandle:^{
//        NSLog(@"取消");
//    }];

//    [LCAlertTool actionsheetShowWithController:self title:@"提示框" confirmTitle:@"确定" confirmHandle:^{
//        NSLog(@"确定");
//    } otherTitle:@"其他" otherHandle:^{
//        NSLog(@"其他");
//    } cancleTitle:@"取消" cancleHandle:^{
//        NSLog(@"取消");
//    }];

//}

/*===============================*/


//字典转为Json字符串
- (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



@end
