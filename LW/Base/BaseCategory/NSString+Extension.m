//
//  NSString+Extension.m
//
//  Created by Joymake on 15/8/7.
//  Copyright (c) 2015年 Joymake. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

//如果用减方法，如果对象本身是nil 的话，就不会调用此方法。
+ (BOOL)isNullString:(NSString *)string
{
//    if (string == nil) {
//        return YES;
//    }else if (string.length == 0){
//        return YES;
//    }else if ([string isEqualToString:@"(null)"]){
//        return YES;
//    }
//    return NO;
    return ![NSString isVaildString:string];
}

+ (BOOL)isVaildString:(NSString *)value
{
    return (value && ![@"" isEqualToString:value] && ![value isKindOfClass:[NSNull class]] && ![@"(null)"  isEqualToString:value] && ![@"<null>" isEqualToString:value]);
}

- (NSInteger)lengthAndChinese {
    __block NSInteger chinese = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if( hs >= 0x4e00 && hs <= 0x9fff) {
            chinese++;
        }
    }];
    NSInteger length=self.length + chinese;
    return length;
}

- (NSString *)clip_10char
{
    NSInteger length = 0;
    for(int i=0; i< self.length;i++)
    {
        int a = [self characterAtIndex:i];
        if( a >= 0x4e00 && a <= 0x9fff)
        {
            length += 2;
        }
        else
        {
            length += 1;
        }
        if (length > 10)
        {
            return [self substringToIndex:i - 1];
        }
    }
    return self;
}

- (BOOL)isChineseChar {
    int a = [self characterAtIndex:0];
    if( a >= 0x4e00 && a <= 0x9fff) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isSensitiveWordWithSensitiveWords:(NSArray *)sensitiveWords {
    BOOL isSensitive = NO;
    for (NSString *string in sensitiveWords) {
        NSRange commaRange = [self rangeOfString:string];
        if (commaRange.location != NSNotFound) {
            NSLog(@"包含敏感词- %@",string);
            return YES;
        }
    }
    return isSensitive;
}

- (BOOL)isEmoji
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    return self.length != modifiedString.length;
}

- (BOOL)isSpecialCharacter{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@/:;¥“”、.。[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\"?？！‘，,<>－—— ／：；、［］｛｝％－＊＋＝——｜～《》……＃＊（）｀"];
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:set];
    return trimmedString.length != self.length;
}

- (BOOL)isIntType{
    NSScanner * scanner = [NSScanner scannerWithString:self];
    int val;
    return [scanner scanInt:&val] && [scanner isAtEnd];
}

- (BOOL)isEmpty{
    if (!self) {
        return YES;
    }else{
        NSCharacterSet * set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString * laseStr = [self stringByTrimmingCharactersInSet:set];
        if (laseStr.length == 0) {
            return YES;
        }else{
            return NO;
        }
    }
}

- (NSString *) phonetic{
    NSMutableString *source = [self mutableCopy];
    if(source)
    {
        CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
        return source;
    }else
    {
        return @"#";
    }
}

- (BOOL)checkIsNumber{
    NSString * regex = @"^[0-9]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (NSString *)replaceCharactersAtIndexes:(NSArray *)indexes withString:(NSString *)aString
{
    NSAssert(indexes != nil, @"%s: indexes 不可以为nil", __PRETTY_FUNCTION__);
    NSAssert(aString != nil, @"%s: aString 不可以为nil", __PRETTY_FUNCTION__);
    
    NSUInteger offset = 0;
    NSMutableString *raw = [self mutableCopy];
    
    NSInteger prevLength = 0;
    for(NSInteger i = 0; i < [indexes count]; i++)
    {
        @autoreleasepool {
            NSRange range = [[indexes objectAtIndex:i] rangeValue];
            prevLength = range.length;
            
            range.location -= offset;
            [raw replaceCharactersInRange:range withString:aString];
            offset = offset + prevLength - [aString length];
        }
    }
    
    return raw;
}

- (NSMutableArray *)itemsForPattern:(NSString *)pattern captureGroupIndex:(NSUInteger)index
{
    if ( !pattern )
        return nil;
    
    NSError *error = nil;
    NSRegularExpression *regx = [[NSRegularExpression alloc] initWithPattern:pattern
                                                                     options:NSRegularExpressionCaseInsensitive error:&error];
    if (error)
    {
        
    }else{
        NSMutableArray *results = [[NSMutableArray alloc] init];
        NSRange searchRange = NSMakeRange(0, [self length]);
        [regx enumerateMatchesInString:self options:0 range:searchRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            
            NSRange groupRange =  [result rangeAtIndex:index];
            NSString *match = [self substringWithRange:groupRange];
            [results addObject:match];
        }];
        
        return results;
    }
    
    return nil;
}
- (CGSize)sizeWithMaxSize:(CGSize)maxSize andFont:(UIFont *)font
{
    return  [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

+ (NSString *)urlEncodedString:(NSString *)urlString
{
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)urlString, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
    
    return encodedString;
    
}


+(NSString *)jsonStringWithDict:(NSDictionary *)dict
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

-(id)JSONValue
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}


@end
