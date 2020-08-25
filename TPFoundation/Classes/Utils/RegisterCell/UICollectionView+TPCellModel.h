//
//  UICollectionView+TPCellModel.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/25.
//

#import <UIKit/UIKit.h>
#import "TPTableCellModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 注册cell 及 section 扩展
@interface UICollectionView (TPCellModel)

/// 注册cell
/// @param cells 存储用于重用的cell对象
- (void)tp_registerCell:(NSArray <TPTableCellModel *>*)cells;

/// 注册 sectionView
/// @param sections 存储用于重用的sectionView
/// @param elementKind 分区头、尾
- (void)tp_regitsterSections:(NSArray <TPTableCellModel *>*)sections elementKind:(NSString *)elementKind;
@end

NS_ASSUME_NONNULL_END
