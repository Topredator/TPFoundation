//
//  TPMath.h
//  TPFoundation
//
//  Created by Topredator on 2021/11/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

struct TPMathPoint {
    CGFloat x;
    CGFloat y;
};
typedef struct TPMathPoint TPMathPoint;

static inline TPMathPoint TPMathPointMake(CGFloat x, CGFloat y) {
    TPMathPoint point;
    point.x = x;
    point.y = y;
    return point;
}

/// 数学 运算
@interface TPMath : NSObject
#pragma mark ------------------------  一次线性函数 y = kx + b  ---------------------------
@property (nonatomic, assign) CGFloat k;
@property (nonatomic, assign) CGFloat b;


/// 通过 两个坐标点 计算一次线性方程的 常数 和 斜率
+ (instancetype)tp_mathOnceLinearEquationWithPointA:(TPMathPoint)pointA
                                             pointB:(TPMathPoint)pointB;
/// 通过y坐标 值 获取x坐标的值
- (CGFloat)tp_xValueFromY:(CGFloat)y;
/// 通过x坐标值 获取y坐标的值
- (CGFloat)tp_yValueFormX:(CGFloat)x;
/// 获得固定宽度的新大小
+ (CGSize)tp_resetFromSize:(CGSize)size
                fixedWidth:(CGFloat)width;
/// 获得固定高度的新大小
+ (CGSize)tp_resetFromSize:(CGSize)size
                fixedHeight:(CGFloat)height;

/// 将 弧度 转换为 度
+ (CGFloat)tp_degreeFromRadian:(CGFloat)radian;

/// 将 度 转化为 弧度
+ (CGFloat)tp_radianFromDegree:(CGFloat)degree;

/// tan函数 计算 弧度
+ (CGFloat)tp_radianFromTanSideA:(CGFloat)sideA sideB:(CGFloat)sideB;

@end

NS_ASSUME_NONNULL_END
