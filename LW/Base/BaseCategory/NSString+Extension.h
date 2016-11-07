//
//  NSString+Extension.h
//
//  Created by Joymake on 15/8/7.
//  Copyright (c) 2015年 Joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/*
 *  判断字符串是否为空
 *
 */
+ (BOOL)isNullString:(NSString *)string;
/**
 *  判断字符串是否为空
 */
+ (BOOL)isVaildString:(NSString *)value;
/**
 *  返回字符串的长度
 *
 */
- (NSInteger)lengthAndChinese;
/**
 *  判断字符串的首字符是不是中文
 */
- (BOOL)isChineseChar;

- (NSString *)clip_10char;

//是否是emoji表情
- (BOOL)isEmoji;

//是否是特殊字符
- (BOOL)isSpecialCharacter;

// 判断是否为空格
- (BOOL)isEmpty;

// 判断是否为数字
- (BOOL)isIntType;

//汉子转化为拼音
- (NSString *) phonetic;

//判断是否纯数字
- (BOOL)checkIsNumber;

- (NSString *)replaceCharactersAtIndexes:(NSArray *)indexes withString:(NSString *)aString;
- (NSMutableArray *)itemsForPattern:(NSString *)pattern captureGroupIndex:(NSUInteger)index;

//根据最大尺寸和字体计算文字的实际尺寸
- (CGSize)sizeWithMaxSize:(CGSize)maxSize andFont:(UIFont *)font;
// 字典转json串
+(NSString *)jsonStringWithDict:(NSDictionary *)dict;
// json串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
// 编码 url中的特殊字符
+ (NSString *)urlEncodedString:(NSString *)urlString;
// 把当前字符串转成字典
-(id)JSONValue;

@end
