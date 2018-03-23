//
//  LCLabel.m
//  LcTools
//
//  Created by lichao on 2017/4/13.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import "LCLabel.h"

@interface LCLabel()

/** NSMutableAttributeString 的子类 */
@property(nonatomic, strong) NSTextStorage *textStorage;

/** 布局管理者 */
@property(nonatomic, strong) NSLayoutManager *layoutManager;

/** 容器, 需要设置容器的大小 */
@property(nonatomic, strong) NSTextContainer *textContainer;

/** 点击类型 */
@property(nonatomic, assign) HandleStyle tapStyle;

/** URL链接的颜色 */
@property(nonatomic, strong) UIColor *URLTextColor;

/** 话题文字的颜色 */
@property(nonatomic, strong) UIColor *topicTextColor;

/** 协议文字的颜色 */
@property(nonatomic, strong) UIColor *protocolTextColor;

/** 用户文字的颜色 */
@property(nonatomic, strong) UIColor *userTextColor;

/** 记录用户选中的range */
@property(nonatomic, assign) NSRange selectedRange;

/** 链接范围 */
@property(nonatomic, strong) NSArray *linkRangesArr;

/** 链接文字颜色 */
@property(nonatomic, strong) UIColor *linkTextColor;

/** 用户名范围 */
@property(nonatomic, strong) NSArray *userRangesArr;

/** 话题范围 */
@property(nonatomic, strong) NSArray *topicRangesArr;

/** 协议/政策范围 */
@property(nonatomic, strong) NSArray *protocolRangesArr;

/** 自定义要查找的范围 */
@property(nonatomic, strong) NSArray *userDefineRangeArr;

/** 用户几率点击还是松开 */
@property(nonatomic, assign) BOOL isSelected;

@end

static NSString *LCRange = @"lcrange";
static NSString *LCColor = @"lccolor";

@implementation LCLabel

- (void)setHightLightTextColor:(UIColor *)hightLightColor forHandleStyle:(HandleStyle)handleStyle{
   
    switch (handleStyle) {
        case HandleStyleLink:
        {
            self.linkTextColor = hightLightColor;
            [self prepareText];
        }
            break;
        case HandleStyleTopic:
        {
            self.topicTextColor = hightLightColor;
            [self prepareText];
        }
            break;
        case HandleStyleProtocol:
        {
            self.protocolTextColor = hightLightColor;
            [self prepareText];
        }
            break;
        case HandleStyleUser:
        {
            self.userTextColor = hightLightColor;
            [self prepareText];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark -- 重新系统的属性
- (void)setText:(NSString *)text{
    [super setText:text];
    [self prepareText];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self prepareText];
}

- (void)setTextColor:(UIColor *)textColor{
    [super setTextColor:textColor];
    [self prepareText];
}

- (void)setLc_commonTextColor:(UIColor *)lc_commonTextColor{
    _lc_commonTextColor = lc_commonTextColor;
    [self prepareText];
}

- (void)setLc_matchArr:(NSArray<NSDictionary *> *)lc_matchArr{
    _lc_matchArr = lc_matchArr;
    [self prepareText];
}

// initWithFrame
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

//initWithCoder
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if ([super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}


#pragma mark -- 系统回调
//布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //设置容器的大小为label的尺寸
    self.textContainer.size = self.frame.size;
}

- (void)drawRect:(CGRect)rect{
    if (self.selectedRange.length != 0) {
        //确定颜色
        UIColor *selectedColor = self.isSelected ? self.lc_textHightLightBackgroundColor : [UIColor clearColor];
        //设置颜色
        [self.textStorage addAttribute:NSBackgroundColorAttributeName value:selectedColor range:self.selectedRange];
        //绘制背景
        [self.layoutManager drawBackgroundForGlyphRange:self.selectedRange atPoint:CGPointMake(0, 0)];
    }
    //绘制字形
    NSRange range = NSMakeRange(0, self.textStorage.length);
    [self.layoutManager drawGlyphsForGlyphRange:range atPoint:CGPointZero];
}

#pragma mark -- 初始化
- (void)setUp{
    //初始化
    _textStorage = [[NSTextStorage alloc] init];
    _layoutManager = [[NSLayoutManager alloc] init];
    _textContainer = [[NSTextContainer alloc] init];
    _lc_commonTextColor = [UIColor colorWithRed:162.0/255 green:162.0/255 blue:162.0/255 alpha:162.0/255];
    _lc_textHightLightBackgroundColor = [UIColor colorWithWhite:0.7 alpha:0.2];
    _linkTextColor = _topicTextColor = _protocolTextColor = _userTextColor = [UIColor colorWithRed:64.0/255 green:64.0/255 blue:64.0/255 alpha:1];
    
    [self prepareTextSystem];
}


#pragma mark -- private
/**
 文本系统
 */
- (void)prepareTextSystem{
    //1.准备文本
    [self prepareText];
    
    //2.将布局添加到storage
    [self.textStorage addLayoutManager:self.layoutManager];
    
    //3.将容器添加到布局中
    [self.layoutManager addTextContainer:self.textContainer];
    
    //4.让label可以和用户交互
    self.userInteractionEnabled = YES;
    
    //5.设置间距为0
    self.textContainer.lineFragmentPadding = 0;
    
}

/**
 准备文本
 */
- (void)prepareText{
    
    //1.准备字符串
    NSAttributedString *attrString = nil;
    if (self.attributedText != nil) {
        attrString = self.attributedText;
    }else if (self.text != nil){
        attrString = [[NSAttributedString alloc] initWithString:self.text];
    }else{
        attrString = [[NSAttributedString alloc] initWithString:@""];
    }
    if (attrString.length == 0) return;
    
    self.selectedRange = NSMakeRange(0, 0);
    
    //2.设置换行模型
    NSMutableAttributedString *attrStringM = [self addLineBreak:attrString];
    
    //3.给文本添加显示字号和颜色
    NSDictionary *attrDict;
    attrDict = @{
                 NSFontAttributeName : self.font,
                 NSForegroundColorAttributeName : self.lc_commonTextColor
                 };
    
    [attrStringM setAttributes:attrDict range:NSMakeRange(0, attrStringM.length)];
    
    //4.设置textStorage的内容
    [self.textStorage setAttributedString:attrStringM];
    
    //5.匹配URL
    NSArray *linkRanges = [self getLinkRanges];
    self.linkRangesArr = linkRanges;
    for (NSValue *value in linkRanges) {
        
        NSRange range;
        [value getValue:&range];
        [self.textStorage addAttribute:NSForegroundColorAttributeName value:self.linkTextColor range:range];
    }
    
    //6.匹配 @用户
    NSArray *userRanges = [self getRangesWithPattern:@"@[\\u4e00-\\u9fa5a-zA-Z0-9_-]*"];
    self.userRangesArr = userRanges;
    for (NSValue *value in userRanges) {
        
        NSRange range;
        [value getValue:&range];
        [self.textStorage addAttribute:NSForegroundColorAttributeName value:self.userTextColor range:range];
    }
    
    //7.#匹配话题#
    NSArray *topicRanges = [self getRangesWithPattern:@"#.*?#"];
    self.topicRangesArr = topicRanges;
    for (NSValue *value in topicRanges) {
        NSRange range;
        [value getValue:&range];
        [self.textStorage addAttribute:NSForegroundColorAttributeName value:self.topicTextColor range:range];
    }
    
    //8.匹配协议/政策 << >>
    NSArray *protocolRangesArr = [self getRangesWithPattern:@"《([^》]*)》"];
    self.protocolRangesArr = protocolRangesArr;
    for (NSValue *value in protocolRangesArr) {
        NSRange range;
        [value getValue:&range];
        [self.textStorage addAttribute:NSForegroundColorAttributeName value:self.protocolTextColor range:range];
    }
    
    //9.匹配用户自定义的字符串
    if (self.lc_matchArr.count > 0) {
        NSArray<NSDictionary *> *userDefineRangeDicts = [self getUserDefineStringsRange];
        if (userDefineRangeDicts.count > 0) {
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dict in userDefineRangeDicts) {
                NSValue *value = dict[LCRange];
                [arrM addObject:value];
                UIColor *color = dict[LCColor];
                NSRange range;
                [value getValue:&range];
                [self.textStorage addAttribute:NSForegroundColorAttributeName value:color range:range];
            }
            self.userDefineRangeArr = [arrM copy];
        }
    }
    
    //10. 更新显示, 重新绘制
    [self setNeedsDisplay];
}

- (NSArray <NSDictionary *> *)getUserDefineStringsRange{
    
    if (self.lc_matchArr.count == 0) {
        return nil;
    }
    
    NSMutableArray <NSDictionary *> *arrM = [NSMutableArray array];
    
    NSString *str = [self.textStorage string];
    for (NSDictionary *dict in self.lc_matchArr) {
        NSString *subStr = dict[@"string"];
        UIColor *color = dict[@"color"];
        
        //没传入字符串
        if (!subStr) {
            return nil;
        }
        
        NSRange range = [str rangeOfString:subStr];
        //没找到
        if (range.length == 0) {
            continue;
        }
        
        NSValue *value = [NSValue valueWithBytes:&range objCType:@encode(NSRange)];
        NSMutableDictionary *aDictM = [NSMutableDictionary dictionary];
        aDictM[LCRange] = value;
        aDictM[LCColor] = color;
        [arrM addObject:[aDictM copy]];
    }
    
    return [arrM copy];
}

- (NSArray *)getRangesWithPattern:(NSString *)pattern{
    
    //创建正则表达式
    NSError *error;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:&error];
    
    return [self getRangesFromResult:regex];
}

- (NSArray *)getLinkRanges{
    
    //创建正则表达式
    NSError *error;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
    
    return [self getRangesFromResult:detector];
}

- (NSArray *)getRangesFromResult:(NSRegularExpression *)regex{
    
    NSArray<NSTextCheckingResult *> *results = [regex matchesInString:[self.textStorage string] options:0 range:NSMakeRange(0, self.textStorage.length)];
    //遍历结果
    NSMutableArray *ranges = [NSMutableArray array];
    for (NSTextCheckingResult *result in results) {
        //将结构体保存到数组
        //先用一个变量接受结构体
        NSRange range = result.range;
        NSValue *value = [NSValue valueWithBytes:&range objCType:@encode(NSRange)];
        [ranges addObject:value];
    }
    
    return ranges;
}


#pragma mark -- Extension
/**
 如果用户没有设置linBreak, 则所有内容会绘制到同一行中, 因此需要主动设置
 */
- (NSMutableAttributedString *)addLineBreak:(NSAttributedString *)attrString{
    
    NSMutableAttributedString *attrStringM = [attrString mutableCopy];
    
    if (attrStringM.length == 0) {
        return attrStringM;
    }
    
    NSRange range = NSMakeRange(0, 0);
    NSMutableDictionary *attributeDict = [[attrStringM attributesAtIndex:0 effectiveRange:&range] mutableCopy];
    NSMutableParagraphStyle *paragraphStyle = [attributeDict[NSParagraphStyleAttributeName] mutableCopy];
    
    if (paragraphStyle != nil) {
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;//包裹在单词边界
    }else{
        paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        attributeDict[NSParagraphStyleAttributeName] = paragraphStyle;
        
        [attrStringM setAttributes:attributeDict range:range];
    }
    return attrStringM;
}

#pragma mark -- 点击交互
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //记录点击
    self.isSelected = YES;
    
    //获取用户点击的点
    CGPoint selectedPoint = [[touches anyObject] locationInView:self];
    
    //获取该点所在的字符串的range
    self.selectedRange = [self getSelectRange:selectedPoint];
    
    //是否处理了事件
    if (self.selectedRange.length == 0) {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.selectedRange.length == 0) {
        [super touchesEnded:touches withEvent:event];
        return;
    }
    
    //1.记录松开
    self.isSelected = NO;
    //2.重新绘制
    [self setNeedsDisplay];
    //3.取出内容
    NSString *selectedString = [[self.textStorage string] substringWithRange:self.selectedRange];
    
    
    //回调
    switch (self.tapStyle) {
        case HandleStyleProtocol:{
            __weak typeof(self) weakSelf = self;
            if (self.lc_tapOperation) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (!strongSelf) {
                    return;
                }
                if (strongSelf.lc_tapOperation) {
                    strongSelf.lc_tapOperation(strongSelf, HandleStyleProtocol, selectedString, strongSelf.selectedRange);
                }
            }
        }
            break;
            
        case HandleStyleLink:{
            __weak typeof(self) weakSelf = self;
            if (self.lc_tapOperation) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (!strongSelf) {
                    return;
                }
                if (strongSelf.lc_tapOperation) {
                    strongSelf.lc_tapOperation(strongSelf, HandleStyleLink, selectedString, strongSelf.selectedRange);
                }
            }
        }
            break;
        case HandleStyleTopic:{
            __weak typeof(self) weakSelf = self;
            if (self.lc_tapOperation) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (!strongSelf) {
                    return;
                }
                if (strongSelf.lc_tapOperation) {
                    strongSelf.lc_tapOperation(strongSelf, HandleStyleTopic, selectedString, strongSelf.selectedRange);
                }
            }
        }
            break;
        case HandleStyleUser:{
            __weak typeof(self) weakSelf = self;
            if (self.lc_tapOperation) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (!strongSelf) {
                    return;
                }
                if (strongSelf.lc_tapOperation) {
                    strongSelf.lc_tapOperation(strongSelf, HandleStyleUser, selectedString, strongSelf.selectedRange);
                }
            }
        }
            break;
        case HandleStyleUserDefine:{
            __weak typeof(self) weakSelf = self;
            if (self.lc_tapOperation) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (!strongSelf) {
                    return;
                }
                if (strongSelf.lc_tapOperation) {
                    strongSelf.lc_tapOperation(strongSelf, HandleStyleUserDefine, selectedString, strongSelf.selectedRange);
                }
            }
        }
            break;
            
        default:
            break;
    }
    
    //代理
    if ([self.delegate respondsToSelector:@selector(lc_label:didSelectedString:forStyle:inRange:)]) {
        [self.delegate lc_label:self didSelectedString:selectedString forStyle:self.tapStyle inRange:self.selectedRange];
    }
    
}

- (NSRange)getSelectRange:(CGPoint)selectPoint{
    //1.如果属性字符串为nil, 则不需要判断
    if (self.textStorage.length == 0) {
        return NSMakeRange(0, 0);
    }
    //2.获取选中点所在的下标值
    NSUInteger index = [self.layoutManager glyphIndexForPoint:selectPoint inTextContainer:self.textContainer];
    //3.判断下标在什么内
    //3.1判断是否是一个链接
    for (NSValue *value in self.linkRangesArr) {
        NSRange range;
        [value getValue:&range];
        if (index > range.location && index < range.location + range.length) {
            [self setNeedsDisplay];
            self.tapStyle = HandleStyleLink;
            return range;
        }
    }
    //3.2判断是否是 @用户
    for (NSValue *value in self.userRangesArr) {
        NSRange range;
        [value getValue:&range];
        if (index > range.location && index < range.location + range.length) {
            [self setNeedsDisplay];
            self.tapStyle = HandleStyleUser;
            return range;
        }
    }
    //3.3判断是否是 #话题#
    for (NSValue *value in self.topicRangesArr) {
        NSRange range;
        [value getValue:&range];
        if (index > range.location && index < range.location + range.length) {
            [self setNeedsDisplay];
            self.tapStyle = HandleStyleTopic;
            return range;
        }
    }
    // 3.4.判断是否是一个协议/政策 <<>>
    for (NSValue *value in self.protocolRangesArr) {
        NSRange range;
        [value getValue:&range];
        if (index > range.location && index < range.location + range.length) {
            [self setNeedsDisplay];
            self.tapStyle = HandleStyleProtocol;
            return range;
        }
    }
    
    // 3.5.判断是否是一个用户自定义要匹配的字符串
    for (NSValue *value in self.userDefineRangeArr) {
        NSRange range;
        [value getValue:&range];
        if (index > range.location && index < range.location + range.length) {
            [self setNeedsDisplay];
            self.tapStyle = HandleStyleUserDefine;
            return range;
        }
    }
   
    return NSMakeRange(0, 0);
}




@end
