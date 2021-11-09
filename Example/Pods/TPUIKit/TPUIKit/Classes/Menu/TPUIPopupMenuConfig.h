//
//  TPUIPopupMenuConfig.h
//  TPUIKit
//
//  Created by Topredator on 2021/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPUIPopupMenuConfig : NSObject
/// 常规颜色，默认是黑色
@property (nonatomic, strong) UIColor *textColor;
/// 选中颜色，默认是蓝色
@property (nonatomic, strong) UIColor *selectedTextColor;
/// 背景颜色，默认为白色
@property (nonatomic, strong) UIColor *bgColor;
/// 选中背景颜色，默认为白色
@property (nonatomic, strong) UIColor *selectedBgColor;
/// 字体大小
@property (nonatomic, strong) UIFont *textFont;
/// 选中字体大小
@property (nonatomic, strong) UIFont *selectedTextFont;
/// 当前选中的下标
@property (nonatomic, assign) NSInteger selectedIndex;
/// 是否展示分割线
@property (nonatomic, assign, getter=isShowDivider) BOOL showDivider;
/// 单元格的高
@property (nonatomic, assign) CGFloat rowHeight;
/// 遮挡层 颜色
@property (nonatomic, strong) UIColor *shieldColor;
@end

NS_ASSUME_NONNULL_END
