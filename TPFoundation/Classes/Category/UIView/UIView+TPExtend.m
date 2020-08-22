//
//  UIView+TPExtend.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import "UIView+TPExtend.h"
#import "TPFoundationMacro.h"
TPSYNTH_DUMMY_CLASS(UIView_TPExtend)

@implementation UIView (TPExtend)
- (void)tp_removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}
- (void)tp_cornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner {
    [self layoutIfNeeded];//这句代码很重要，不能忘了
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(value, value)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
}
@end
