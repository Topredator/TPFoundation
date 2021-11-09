//
//  TPUI.m
//  TPUIKit
//
//  Created by Topredator on 2021/10/18.
//

#import "TPUI.h"
#import <UIKit/UIKit.h>

@interface UIApplication ()
+ (CGFloat)tp_statusBarHeight;
@end

@implementation UIApplication (TPUI)
+ (CGFloat)tp_statusBarHeight {
    CGFloat statusBarHeight = 0.0;
    if (@available(iOS 13.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.windows.firstObject;
        statusBarHeight = window.windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
        statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.width;
    }
    return statusBarHeight;
}
@end

@implementation TPUI
+ (CGFloat)tp_screenWidth { return UIScreen.mainScreen.bounds.size.width; }
/// 屏幕 高度
+ (CGFloat)tp_screenHeight { return UIScreen.mainScreen.bounds.size.height; }
/// 状态栏 高度
+ (CGFloat)tp_statusBarHeight { return UIApplication.tp_statusBarHeight; }
/// 导航栏 高度
+ (CGFloat)tp_navigationBarHeight { return 44; }
/// 状态栏 + 导航栏 高度
+ (CGFloat)tp_topBarHeight { return UIApplication.tp_statusBarHeight + self.tp_navigationBarHeight; }
/// Tabbar 高度
+ (CGFloat)tp_tabbarHeight { return 49.0; }
/// Tabbar + 底部安全区域高度
+ (CGFloat)tp_bottomBarHeight { return self.tp_statusBarHeight > 20.0 ? 83.0 : 49.0; }
/// 底部安全区域高度
+ (CGFloat)tp_bottomSafeAreaHeight { return self.tp_statusBarHeight > 20.0 ? 34.0 : 0.0; }


+ (UIColor *)tp_randomColor {
    return [self r:arc4random_uniform(255) g:arc4random_uniform(255) b:arc4random_uniform(255)];
}
/// RGB
+ (UIColor *)r:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue {
    return [self r:red g:green b:blue a:1.0];
}
/// RGBA
+ (UIColor *)r:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue a:(CGFloat)alpha {
    return [UIColor colorWithRed:(red) / 255.0 green:(green) / 255.0 blue:(blue) / 255.0 alpha:alpha];
}
+ (UIColor *)rgba:(CGFloat)t {
    return [self r:t g:t b:t];
}
+ (UIColor *)rgba:(CGFloat)t alpha:(CGFloat)alpha {
    return [self r:t g:t b:t a:alpha];
}
/// hex color
+ (UIColor *)tp_hexColor:(unsigned long)hex {
    return [self tp_hexColor:hex alpha:1.0];
}
+ (UIColor *)tp_hexColor:(unsigned long)hex alpha:(CGFloat)alpha {
    return [self r:(CGFloat)((hex & 0xFF0000) >> 16)
                 g:(CGFloat)((hex & 0xFF00) >> 8)
                 b:(CGFloat)((hex & 0xFF))
                 a:alpha];
}


+ (UIFont *)tp_font:(CGFloat)fontSize weight:(TPUIFontWeight)weight {
    if (weight < FontThin || weight > FontLight) weight = FontRegular;
        NSString *fontName = @"PingFangSC-Regular";
        switch (weight) {
            case FontThin:
                fontName = @"PingFangSC-Thin";
                break;
            case FontMedium:
                fontName = @"PingFangSC-Medium";
                break;
            case FontSemibold:
                fontName = @"PingFangSC-Semibold";
                break;
            case FontLight:
                fontName = @"PingFangSC-Light";
                break;
            case FontRegular:
                fontName = @"PingFangSC-Regular";
                break;
        }
        UIFont *font = [UIFont fontWithName:fontName size:fontSize];
        return font ?: [UIFont systemFontOfSize:fontSize];
}

+ (UIImage *)tp_imageName:(NSString *)imageName
               bundleName:(NSString *)bundleName {
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.bundle", bundleName]];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
}

+ (void)tp_adjustsInsets:(UIScrollView *)scrollView vc:(UIViewController *)vc {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {
        NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        NSInteger argumet = 2;
        invocation.target = scrollView;
        invocation.selector = @selector(setContentInsetAdjustmentBehavior:);
        [invocation setArgument:&argumet atIndex:2];
        [invocation invoke];
    } else {
        vc.automaticallyAdjustsScrollViewInsets = NO;
    }
#pragma clang diagnostic pop
}


@end
