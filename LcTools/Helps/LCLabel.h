//
//  LCLabel.h
//  LcTools
//
//  Created by lichao on 2017/4/13.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HandleStyle){
    HandleStyleNone = 0,
    HandleStyleUser = 1,
    HandleStyleTopic = 2,
    HandleStyleLink = 3,
    HandleStyleProtocol = 4,
    HandleStyleUserDefine = 5
};

@class LCLabel;

@protocol LCLabelDelegate <NSObject>

@optional

- (void)lc_label:(LCLabel *)label didSelectedString:(NSString *)selectedString forStyle:(HandleStyle)style inRange:(NSRange)range;

@end


typedef void (^tapHandle)(UILabel *, HandleStyle, NSString *, NSRange);

@interface LCLabel : UILabel

/**
 普通文字的颜色
 */
@property(nonatomic, strong) UIColor *lc_commonTextColor;


/**
 选中时高亮的背景色
 */
@property(nonatomic, strong) UIColor *lc_textHightLightBackgroundColor;

/**
 自定义要高亮匹配的
 请把要匹配的文字用string这个key存入字典, 把要高亮的颜色用color这个key存入字典,
 */
@property(nonatomic, strong) NSArray<NSDictionary *> *lc_matchArr;

/**
 给不同种类的高亮文字设置颜色
 */
- (void)setHightLightTextColor:(UIColor *)hightLightColor forHandleStyle:(HandleStyle)handleStyle;

/**
 点击事件block
 */
@property(nonatomic, strong) tapHandle lc_tapOperation;

/**
 delegate
 */
@property(nonatomic, weak) id<LCLabelDelegate> delegate;

@end


//#pragma mark -- LCLabel使用示例
///*===============================*/
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
//#pragma mark JPLabelDelegate
//
//-(void)lc_label:(LCLabel *)label didSelectedString:(NSString *)selectedStr forStyle:(HandleStyle)style inRange:(NSRange)range{
//    
//    // 你想要做的事
//    NSLog(@"代理打印 %@", selectedStr);
//}
//
///*===============================*/



