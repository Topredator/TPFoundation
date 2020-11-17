//
//  TPScreenShot.m
//  TPFoundation
//
//  Created by Topredator on 2020/11/17.
//

#import "TPScreenShot.h"

@implementation TPScreenShot
+ (UIImage *)currentScreenShot {
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage * )shotWithView:(UIView * )view {
    if (!view) return nil;
    CGSize size = view.frame.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)shotWithScrollview:(UIScrollView *)scrollview {
    if (!scrollview) return nil;
    CGSize size = scrollview.contentSize;
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
    
    //获取当前scrollview的frame 和 contentOffset
    CGRect saveFrame = scrollview.frame;
    CGPoint saveOffset = scrollview.contentOffset;
    //置为起点
    scrollview.contentOffset = CGPointZero;
    scrollview.frame = CGRectMake(0, 0, scrollview.contentSize.width, scrollview.contentSize.height);
    
    [scrollview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //还原
    scrollview.frame = saveFrame;
    scrollview.contentOffset = saveOffset;
    return image;
}
+ (UIImage *)shotWithInnerView:(UIView *)innerView atFrame:(CGRect)rect {
    if (!innerView) return nil;
    UIGraphicsBeginImageContext(innerView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(rect);
    [innerView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  theImage ? [UIImage imageWithCGImage:CGImageCreateWithImageInRect(theImage.CGImage, rect)] : nil;
}
@end
