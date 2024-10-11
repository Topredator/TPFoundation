//
//  TPAttributedStringConfig.h
//  TPFoundation
//
//  Created by Topredator on 2024/10/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 属性字符串配置基类
@interface TPAttributedStringConfig : NSObject
/// 属性名称
@property (nonatomic, strong, readonly) NSString *attributeName;
/// 属性值
@property (nonatomic, strong, readonly) id attributeValue;
/// 范围
@property (nonatomic) NSRange range;
@end

NS_ASSUME_NONNULL_END
