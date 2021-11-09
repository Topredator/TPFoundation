//
//  TPUIShadowCellConfig.h
//  TPUIKit
//
//  Created by Topredator on 2021/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface TPShadowCellMaker : NSObject
@property (nonatomic, assign) UIEdgeInsets containerInsets;
@property (nonatomic, assign) UIEdgeInsets totalInsets;
@property (nonatomic, assign) UIEdgeInsets topInsets;
@property (nonatomic, assign) UIEdgeInsets bottomInsets;
@property (nonatomic, assign) UIEdgeInsets middleInsets;
/// 图片资源地址
@property (nonatomic, copy) NSString *resourcePath;

- (UIImage *)totalImage;
- (UIImage *)topImage;
- (UIImage *)middleImage;
- (UIImage *)bottomImage;


- (TPShadowCellMaker *(^)(UIEdgeInsets))container;
- (TPShadowCellMaker *(^)(UIEdgeInsets))total;
- (TPShadowCellMaker *(^)(UIEdgeInsets))top;
- (TPShadowCellMaker *(^)(UIEdgeInsets))middle;
- (TPShadowCellMaker *(^)(UIEdgeInsets))bottom;
- (TPShadowCellMaker *(^)(NSString *))path;
@end



/// 阴影cell 配置
@interface TPUIShadowCellConfig : NSObject
/// 配置信息
@property (nonatomic, strong, readonly) TPShadowCellMaker *cellMaker;
+ (instancetype)config;
+ (instancetype)shadowCellConfig:(void(^)(TPShadowCellMaker *make))maker;
@end

NS_ASSUME_NONNULL_END
