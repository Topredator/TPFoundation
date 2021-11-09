//
//  UIViewController+TPUIPresentStyle.m
//  TPUIKit
//
//  Created by Topredator on 2021/10/18.
//

#import "UIViewController+TPUIPresentStyle.h"
#import <objc/runtime.h>
#import "TPUIMethodSwizzling.h"

static const char *kTPAutomaticallySetModalPresentationStyleKey;

@implementation UIViewController (TPUIPresentStyle)
+ (void)load {
    TPUIKitSwizzling(self, @selector(presentViewController:animated:completion:), @selector(tp_presentViewController:animated:completion:));
}

- (void)setTp_automaticallySetModalPresentationStyle:(BOOL)tp_automaticallySetModalPresentationStyle {
    objc_setAssociatedObject(self, kTPAutomaticallySetModalPresentationStyleKey, @(tp_automaticallySetModalPresentationStyle), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)tp_automaticallySetModalPresentationStyle {
    id obj = objc_getAssociatedObject(self, kTPAutomaticallySetModalPresentationStyleKey);
    if (obj) {
        return [obj boolValue];
    }
    return [self.class tp_automaticallySetModalPresentationStyle];
}
+ (BOOL)tp_automaticallySetModalPresentationStyle {
    if ([self isKindOfClass:[UIImagePickerController class]] || [self isKindOfClass:[UIAlertController class]]) return NO;
    return YES;
}
- (void)tp_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (@available(iOS 13.0, *)) {
        if (viewControllerToPresent.tp_automaticallySetModalPresentationStyle) {
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self tp_presentViewController:viewControllerToPresent animated:flag completion:completion];
    } else {
        // Fallback on earlier versions
        [self tp_presentViewController:viewControllerToPresent animated:flag completion:completion];
    }
}
@end
