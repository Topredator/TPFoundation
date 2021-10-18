//
//  NSString+TPCoding.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import "NSString+TPCoding.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "TPFoundationMacro.h"
TPSYNTH_DUMMY_CLASS(NSString_TPCoding)

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSString (TPCoding)
- (NSString *)tp_MD5 {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)tp_base64StringFromText:(NSString *)text {
    if (!text || !text.length) return @"";
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    return [self base64EncodedStringFrom:data];
}

+ (NSString *)tp_textFromBase64String:(NSString *)base64 {
    if (!base64 || !base64.length) return @"";
    NSData *data = [self dataWithBase64EncodedString:base64];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


/******************************************************************************
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
+ (NSData *)dataWithBase64EncodedString:(NSString *)string {
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0) return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL) {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES) {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++) {
            if (characters[i] == '\0') break;
            if (isspace(characters[i]) || characters[i] == '=') continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX) {      //  Illegal character!
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0) break;
        if (bufferLength == 1) {      //  At least two characters are needed to produce one byte!
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2) bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3) bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data {
    if ([data length] == 0) return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL) return nil;
    
    NSUInteger length = 0;
    NSUInteger i = 0;
    while (i < [data length]) {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

- (NSString * _Nullable)tp_encodeBase64 {
    if (!self || !self.length) return nil;
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [NSString base64EncodedStringFrom:data];
}
/// base64 解码
- (NSString * _Nullable)tp_decodeBase64 {
    if (!self || !self.length) return nil;
    NSData *data = [NSString dataWithBase64EncodedString:self];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
@end
