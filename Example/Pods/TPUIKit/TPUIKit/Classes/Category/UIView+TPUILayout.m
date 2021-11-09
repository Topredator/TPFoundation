//
//  UIView+TPUILayout.m
//  TPUIKit
//
//  Created by Topredator on 2021/10/18.
//

#import "UIView+TPUILayout.h"

@implementation UIView (TPUILayout)
- (CGFloat)tp_x {
    return self.frame.origin.x;
}

- (void)setTp_x:(CGFloat)tp_x {
    CGRect frame = self.frame;
    frame.origin.x = tp_x;
    self.frame = frame;
}

- (CGFloat)tp_y {
     return self.frame.origin.y;
}

- (void)setTp_y:(CGFloat)tp_y {
    CGRect frame = self.frame;
    frame.origin.y = tp_y;
    self.frame = frame;
}

- (CGFloat)tp_left {
    return self.tp_x;
}

- (void)setTp_left:(CGFloat)tp_left {
    self.tp_x = tp_left;
}

- (CGFloat)tp_top {
    return self.tp_y;
}

- (void)setTp_top:(CGFloat)tp_top {
    self.tp_y = tp_top;
}

- (CGFloat)tp_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setTp_right:(CGFloat)tp_right {
    CGRect frame = self.frame;
    frame.origin.x = tp_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)tp_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setTp_bottom:(CGFloat)tp_bottom {
    CGRect frame = self.frame;
    frame.origin.y = tp_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)tp_width {
    return self.frame.size.width;
}

- (void)setTp_width:(CGFloat)tp_width {
    CGRect frame = self.frame;
    frame.size.width = tp_width;
    self.frame = frame;
}

- (CGFloat)tp_height {
    return self.frame.size.height;
}

- (void)setTp_height:(CGFloat)tp_height {
    CGRect frame = self.frame;
    frame.size.height = tp_height;
    self.frame = frame;
}

- (CGFloat)tp_centerX {
    return self.center.x;
}

- (void)setTp_centerX:(CGFloat)tp_centerX {
    self.center = CGPointMake(tp_centerX, self.center.y);
}

- (CGFloat)tp_centerY {
    return self.center.y;
}

- (void)setTp_centerY:(CGFloat)tp_centerY {
    self.center = CGPointMake(self.center.x, tp_centerY);
}

- (CGPoint)tp_origin {
    return self.frame.origin;
}

- (void)setTp_origin:(CGPoint)tp_origin {
    CGRect frame = self.frame;
    frame.origin = tp_origin;
    self.frame = frame;
}

- (CGSize)tp_size {
    return self.frame.size;
}

- (void)setTp_size:(CGSize)tp_size {
    CGRect frame = self.frame;
    frame.size = tp_size;
    self.frame = frame;
}
@end
