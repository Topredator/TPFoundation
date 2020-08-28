//
//  UIImage+TPExtend.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/28.
//

#import "UIImage+TPExtend.h"
#import "TPFoundationMacro.h"
TPSYNTH_DUMMY_CLASS(UIImage_TPExtend)

@implementation UIImage (TPExtend)
//给定imageView尺寸，截取部分图像
- (UIImage *)tp_imageForSize:(CGSize)size {
    UIImage *image = [self tp_scaleToBigOfSize:CGSizeMake(size.width*2, size.height*2)];
    return image;
}


//截取部分图像
- (UIImage *)tp_getSubImage:(CGRect)rect {
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CFRelease(subImageRef);
    return smallImage;
}

//等比例缩放 取边长最短的一边
- (UIImage *)tp_scaleToSmallOfSize:(CGSize)size {
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1) {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    } else {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}


//等比例缩放 取边长最长的一边
- (UIImage *)tp_scaleToBigOfSize:(CGSize)size {
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1) {
        radio = verticalRadio > horizontalRadio ? verticalRadio : horizontalRadio;
    } else {
        radio = verticalRadio < horizontalRadio ? horizontalRadio : verticalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

/** 返回一张颜色图片 */
+ (UIImage *)tp_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

/** 返回一张颜色图片 */
+ (UIImage *)tp_imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


+ (UIImage *)tp_resizedImageWithName:(NSString *)name
{
    return [self tp_resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)tp_resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

- (UIImage *)tp_resizedImageWithLeft:(CGFloat)left top:(CGFloat)top {
    return [self stretchableImageWithLeftCapWidth:self.size.width * left topCapHeight:self.size.height * top];
}


+ (UIImage *)tp_roundImageWithImage:(UIImage *)image cornerRadius:(CGFloat)radius {
    CGFloat dealt = image.size.width - image.size.height;
    CGRect tempRect = CGRectZero;
    if (dealt >= 0) {
        tempRect = CGRectMake(0, 0, image.size.width/image.size.height * radius*2, radius*2);
    } else {
        tempRect = CGRectMake(0, 0, radius*2, radius*2 * image.size.height /image.size.width );
    }
    
    UIGraphicsBeginImageContext(tempRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [image drawInRect:tempRect];
    CGContextTranslateCTM(context, 0, tempRect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, tempRect, image.CGImage);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIImage *)tp_tintImageWithColor:(UIColor *)tintColor {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    tintedImage = [tintedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return tintedImage;
}


- (UIImage *)tp_imageForSize:(CGSize)size vertical:(TPImageVerticalClipType)vertical horizontal:(TPImageHorizontalClipType)horizontal {
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float imageRadio = width/height;
    float sizeRadio = size.width/size.height;
    CGRect rect = CGRectZero;
    if(imageRadio>sizeRadio) {//裁剪宽
        if(horizontal == TPImageHorizontalClipTypeLeft){//左
            rect = CGRectMake(0, 0, height * sizeRadio, height);
        }else if (horizontal == TPImageHorizontalClipTypeCenter){//中
            rect = CGRectMake((width - height * sizeRadio)*0.5, 0, height * sizeRadio, height);
        }else{//右
            rect = CGRectMake(width - height * sizeRadio, 0, height * sizeRadio, height);
        }
    }else {//裁剪高
        if(horizontal == TPImageVerticalClipTypeTop){//左
            rect = CGRectMake(0, 0, width,width * size.height/size.width);
        }else if (horizontal == TPImageVerticalClipTypeCenter){//中
            rect = CGRectMake(0, (height - width * size.height/size.width)*0.5, width, width * size.height/size.width);
        }else{//右
            rect = CGRectMake(0, height - width * size.height/size.width, width, width * size.height/size.width);
        }
    }
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:subImageRef scale:2.0 orientation:0];
    CFRelease(subImageRef);
    // 返回新的改变大小后的图片
    return image;
}

//按宽度等比例缩放（给定宽度）
- (UIImage *)tp_scaleToSmallWithWidth:(CGFloat)aWidth {
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(2*aWidth, 2*aWidth*height/width));
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, 2*aWidth, 2*aWidth*height/width)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)tp_imageByScalingToMaxSize:(UIImage *)sourceImage {
    CGFloat width = [UIScreen mainScreen].bounds.size.width * [UIScreen mainScreen].scale;
    
    if (sourceImage.size.width < width) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = width;
        btWidth = sourceImage.size.width * (width / sourceImage.size.height);
    } else {
        btWidth = width;
        btHeight = sourceImage.size.height * (width / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self tp_imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

+ (UIImage *)tp_imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else {
            if (widthFactor < heightFactor) {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

- (CGSize)tp_scaleAspectFitAsSize:(CGSize)size {
    CGSize finalSize = CGSizeZero;
    
    CGFloat ratio = 1;
    
    if ((self.size.width == 0) || (self.size.height == 0)) {
        return self.size;
    }
    if ((self.size.width > size.width) || (self.size.height > size.height)) {
        ratio = MIN(size.width/self.size.width, size.height/self.size.height);
    }
    if ((self.size.width < size.width) || (self.size.height > size.height)) {
        ratio = MIN(size.width/self.size.width, size.height/self.size.height);
    }
    finalSize = CGSizeMake(self.size.width*ratio, self.size.height*ratio);
    return finalSize;
}


- (UIImage *)compressQualityWithMaxLength:(NSInteger)maxLength {
   CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return [UIImage imageWithData:data];
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    return [UIImage imageWithData:data];
}
@end
