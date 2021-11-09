//
//  UIViewController+TPUIPresentStyle.h
//  TPUIKit
//
//  Created by Topredator on 2021/10/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 模态视图 风格扩展
@interface UIViewController (TPUIPresentStyle)
/// 是否自动设置模态风格
@property (nonatomic, assign) BOOL tp_automaticallySetModalPresentationStyle;

/// 类是否自动设置 模态风格 默认:YES (UIImagePickerController/UIAlertController 为NO)
+ (BOOL)tp_automaticallySetModalPresentationStyle;
@end

NS_ASSUME_NONNULL_END
