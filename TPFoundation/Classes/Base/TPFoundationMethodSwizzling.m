//
//  TPFoundationMethodSwizzling.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import "TPFoundationMethodSwizzling.h"
#import <objc/runtime.h>

void TPFoundationSwizzling(Class originClass, SEL originSelector, SEL swizzledSelector) {
    Method originMethod = class_getInstanceMethod(originClass, originSelector);
    Method swizzledMethod = class_getInstanceMethod(originClass, swizzledSelector);
    if (class_addMethod(originClass, originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(originClass, swizzledSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}
