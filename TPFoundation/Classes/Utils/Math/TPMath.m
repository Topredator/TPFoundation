//
//  TPMath.m
//  TPFoundation
//
//  Created by Topredator on 2021/11/1.
//

#import "TPMath.h"

@implementation TPMath
+ (instancetype)tp_mathOnceLinearEquationWithPointA:(TPMathPoint)pointA
                                             pointB:(TPMathPoint)pointB {
    TPMath *math = [TPMath new];
    CGFloat x1 = pointA.x;
    CGFloat x2 = pointB.x;
    CGFloat y1 = pointA.y;
    CGFloat y2 = pointB.y;
    math.k = TPCalculateSlope(x1, y1, x2, y2);
    math.b = TPCalculateConstant(x1, y1, x2, y2);
    return math;
}
- (CGFloat)tp_xValueFromY:(CGFloat)y {
    if (_k == 0) return 0;
    return (y - _b) / _k;
}
- (CGFloat)tp_yValueFormX:(CGFloat)x {
    return _k * x + _b;
}
+ (CGSize)tp_resetFromSize:(CGSize)size
                fixedWidth:(CGFloat)width {
    CGFloat height = size.height * (width / size.width);
    return CGSizeMake(width, height);
}
+ (CGSize)tp_resetFromSize:(CGSize)size
                fixedHeight:(CGFloat)height {
    CGFloat width = size.width * (height / size.height);
    return CGSizeMake(width, height);
}

+ (CGFloat)tp_degreeFromRadian:(CGFloat)radian {
    return radian * (180.0 / M_PI);
}
+ (CGFloat)tp_radianFromDegree:(CGFloat)degree {
    return degree * M_PI / 180.0;
}

/// tan函数 计算 弧度
+ (CGFloat)tp_radianFromTanSideA:(CGFloat)sideA
                           sideB:(CGFloat)sideB {
    return atan2(sideA, sideB);
}


CGFloat TPCalculateSlope(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2) {
    if (x1 == x2) return 0;
    return (y2 - y1) / (x2 - x1);
}
CGFloat TPCalculateConstant(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2) {
    if (x2 == x1) return 0;
    return (y1 * (x2 - x1) - x1 * (y2 - y1)) / (x2 - x1);
}
@end
