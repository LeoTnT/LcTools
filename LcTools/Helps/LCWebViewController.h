//
//  LCWebViewController.h
//  LcTools
//
//  Created by lichao on 2017/6/5.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCWebViewController : UIViewController<UIWebViewDelegate, NSURLConnectionDelegate>

//定义一个属性，方便外接调用
@property (nonatomic, strong) UIWebView *webView;

//声明一个方法，外接调用时，只需要传递一个URL即可
- (void)loadWebControllerWithURL:(NSString *)urlStr;

@end
