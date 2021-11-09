//
//  TPUIShadowCellConfig.m
//  TPUIKit
//
//  Created by Topredator on 2021/10/20.
//

#import "TPUIShadowCellConfig.h"
#import "TPUI.h"
@implementation TPShadowCellMaker
- (instancetype)init {
    self = [super init];
    if (self) {
        self.containerInsets = UIEdgeInsetsMake(10, 15, 5, 15);
        self.totalInsets = UIEdgeInsetsMake(25, 48, 25, 48);
        self.topInsets = UIEdgeInsetsMake(23, 48, 0, 48);
        self.middleInsets = UIEdgeInsetsMake(9, 48, 9, 48);
        self.bottomInsets = UIEdgeInsetsMake(2, 48, 16, 48);
    }
    return self;
}
- (UIImage *)totalImage {
    return [self imageWithName:@"TPShadowCell_all"
                   errorReason:@"自定义ShadowCell 整体图片不符合规则"];
}
- (UIImage *)topImage {
    return [self imageWithName:@"TPShadowCell_top"
                   errorReason:@"自定义ShadowCell 顶部图片不符合规则"];
}
- (UIImage *)middleImage {
    return [self imageWithName:@"TPShadowCell_middle"
                   errorReason:@"自定义ShadowCell 中间图片不符合规则"];
}
- (UIImage *)bottomImage {
    return [self imageWithName:@"TPShadowCell_bottom"
                   errorReason:@"自定义ShadowCell 底部图片不符合规则"];
}

- (UIImage *)imageWithName:(NSString *)imageName errorReason:(NSString *)reason {
    if (!self.resourcePath.length) {
        return [TPUI tp_imageName:imageName bundleName:@"TPUIShadowCell"];
    }
    NSArray *fileNames = [self fileList];
    if (!fileNames.count ||
        ![fileNames containsObject:imageName]) {
        @throw [NSException exceptionWithName:@"file name error  or file does not exist"
                                       reason:reason
                                        userInfo:nil];
    }
    return [UIImage imageWithContentsOfFile:[self.imagePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.png", imageName]]];
}
- (NSString *)imagePath {
    return [self.resourcePath stringByAppendingPathComponent:@"/shadowCell"];
}
- (NSArray * _Nullable)fileList {
    if (!self.imagePath.length) return nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager contentsOfDirectoryAtPath:self.imagePath error:nil];
}


- (TPShadowCellMaker *(^)(UIEdgeInsets))container {
    return ^TPShadowCellMaker *(UIEdgeInsets insets) {
        self.containerInsets = insets;
        return self;
    };
}
- (TPShadowCellMaker *(^)(UIEdgeInsets))total {
    return ^TPShadowCellMaker *(UIEdgeInsets insets) {
        self.totalInsets = insets;
        return self;
    };
}
- (TPShadowCellMaker *(^)(UIEdgeInsets))top {
    return ^TPShadowCellMaker *(UIEdgeInsets insets) {
        self.topInsets = insets;
        return self;
    };
}
- (TPShadowCellMaker *(^)(UIEdgeInsets))middle {
    return ^TPShadowCellMaker *(UIEdgeInsets insets) {
        self.middleInsets = insets;
        return self;
    };
}
- (TPShadowCellMaker *(^)(UIEdgeInsets))bottom {
    return ^TPShadowCellMaker *(UIEdgeInsets insets) {
        self.bottomInsets = insets;
        return self;
    };
}
- (TPShadowCellMaker *(^)(NSString *))path {
    return ^TPShadowCellMaker *(NSString *resourcePath) {
        self.resourcePath = resourcePath;
        return self;
    };
}
@end

@interface TPUIShadowCellConfig ()
@property (nonatomic, strong) TPShadowCellMaker *cellMaker;
@end

@implementation TPUIShadowCellConfig
+ (instancetype)config {
    static TPUIShadowCellConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [TPUIShadowCellConfig new];
    });
    return config;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.cellMaker = [TPShadowCellMaker new];
    }
    return self;
}
+ (instancetype)shadowCellConfig:(void(^)(TPShadowCellMaker *make))maker {
    TPUIShadowCellConfig *config = [TPUIShadowCellConfig config];
    if (maker) maker(config.cellMaker);
    return config;
}
@end
