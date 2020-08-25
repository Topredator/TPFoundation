//
//  TPCellModel.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 注册类型
typedef NS_ENUM(NSInteger, TPTableCellRegistrationType) {
    TPTableCellRegistrationTypeCode, /// 代码
    TPTableCellRegistrationTypeXib /// xib
};

/// cell模型
@interface TPTableCellModel : NSObject
@property (nonatomic, readonly) Class cellClass;
@property (nonatomic, readonly) Class headFootClass;
/// 重用标识符
@property (nonatomic, copy, readonly) NSString *reuseId;
/// 注册类型
@property (nonatomic, assign, readonly) TPTableCellRegistrationType type;

/// 注册cell
+ (instancetype)modelWithcellClass:(Class)cellClass
                           reuseId:(nullable NSString *)reuseId
                              type:(TPTableCellRegistrationType)type;
+ (instancetype)modelWithcellClass:(Class)cellClass type:(TPTableCellRegistrationType)type;

/// 注册 headerFooter view
+ (instancetype)modelWithHeadFootClass:(Class)headFootClass
                               reuseId:(nullable NSString *)reuseId
                                  type:(TPTableCellRegistrationType)type;
+ (instancetype)modelWithHeadFootClass:(Class)headFootClass type:(TPTableCellRegistrationType)type;
@end



/// 纯代码创建cell的模型
/// @param cellClass cell对应的类
NS_INLINE TPTableCellModel *TPDefaultCodeCell(Class cellClass) {
    return [TPTableCellModel modelWithcellClass:cellClass type:TPTableCellRegistrationTypeCode];
}
NS_INLINE TPTableCellModel *TPCodeCell(Class cellClass,  NSString * _Nullable reuseId) {
    return [TPTableCellModel modelWithcellClass:cellClass reuseId:reuseId type:TPTableCellRegistrationTypeCode];
}
/// 使用xib创建cell的模型
/// @param cellClass cell对应的类
NS_INLINE TPTableCellModel *TPDefaultXibCell(Class cellClass) {
    return [TPTableCellModel modelWithcellClass:cellClass type:TPTableCellRegistrationTypeXib];
}
NS_INLINE TPTableCellModel *TPXibCell(Class cellClass, NSString * _Nullable reuseId) {
    return [TPTableCellModel modelWithcellClass:cellClass reuseId:reuseId type:TPTableCellRegistrationTypeXib];
}



/// 纯代码创建headerFooterView的模型
NS_INLINE TPTableCellModel *TPDefaultCodeHeadFootView(Class headFootClass) {
    return [TPTableCellModel modelWithHeadFootClass:headFootClass type:TPTableCellRegistrationTypeCode];
}
NS_INLINE TPTableCellModel *TPCodeHeadFootView(Class headFootClass, NSString *reuseId) {
    return [TPTableCellModel modelWithHeadFootClass:headFootClass reuseId:reuseId type:TPTableCellRegistrationTypeCode];
}

/// 使用xib创建headerFooterView的模型
NS_INLINE TPTableCellModel *TPDefaultXibHeadFootView(Class headfootClass) {
    return [TPTableCellModel modelWithHeadFootClass:headfootClass type:TPTableCellRegistrationTypeXib];
}
NS_INLINE TPTableCellModel *TPXibHeadFootView(Class headfootClass, NSString * _Nullable reuseId) {
    return [TPTableCellModel modelWithHeadFootClass:headfootClass reuseId:reuseId type:TPTableCellRegistrationTypeXib];
}


NS_ASSUME_NONNULL_END
