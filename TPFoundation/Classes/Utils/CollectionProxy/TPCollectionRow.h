//
//  TPCollectionRow.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/28.
//

#import <Foundation/Foundation.h>
#import "TPModelID.h"
NS_ASSUME_NONNULL_BEGIN
@class TPCollectionRow;
@class TPCollectionViewProxy;

/// cell将要出现
typedef void (^TPCollectionCellWillDisplayBlock)(__kindof TPCollectionRow *rowData, __kindof UICollectionViewCell *cell, TPCollectionViewProxy *proxy, NSIndexPath *indexPath);
/// cell 初始化
typedef void (^TPCollectionCellPreparedBlock)(__kindof TPCollectionRow *rowData, __kindof UICollectionViewCell *cell, TPCollectionViewProxy *proxy, NSIndexPath *indexPath);
/// cell 点击
typedef void (^TPCollectionCellDidSelectedBlock)(__kindof TPCollectionRow *rowData, TPCollectionViewProxy *proxy, NSIndexPath *indexPath);
/// cell 尺寸
typedef CGSize (^TPCollectionCellItemSizeBlock)(__kindof TPCollectionRow *rowData, TPCollectionViewProxy *proxy, NSIndexPath *indexPath);

@protocol TPCollectionRowDelegate <NSObject>
- (void)tp_collectionViewCellWillDisplay:(__kindof UICollectionViewCell *)cell proxy:(TPCollectionViewProxy *)proxy indexPath:(NSIndexPath *)indexPath;
- (void)tp_collectionViewPreparedCell:(__kindof UICollectionViewCell *)cell proxy:(TPCollectionViewProxy *)proxy indexPath:(NSIndexPath *)indexPath;
- (void)tp_collectionDidSelectedItem:(TPCollectionViewProxy *)proxy indexPath:(NSIndexPath *)indexPath;
- (CGSize)tp_collectionViewItemSizeWithProxy:(__kindof TPCollectionViewProxy *)proxy indexPath:(NSIndexPath *)indexPath;
@end
/// collectionViewCell 绑定对象
@interface TPCollectionRow : NSObject <TPModelID, TPCollectionRowDelegate>
/// 额外信息，默认为nil
@property (nonatomic, strong) NSDictionary *infoDictionary;
/// 注册cell的类
@property (nonatomic, readonly) Class cellClass;
/// cell的重用标识符
@property (nonatomic, readonly) NSString *cellReuseID;
/// 当前显示的cell，当cell被重用时置空
@property (nonatomic, weak, readonly) __kindof UICollectionViewCell *cell;
/// cell初始化
@property (nonatomic, copy) TPCollectionCellPreparedBlock preparedBlock;
/// cell将要展示
@property (nonatomic, copy) TPCollectionCellWillDisplayBlock willDisplayBlock;
/// cell点击操作
@property (nonatomic, copy) TPCollectionCellDidSelectedBlock didSelectedBlock;
/// cell尺寸
@property (nonatomic, copy) TPCollectionCellItemSizeBlock itemSizeBlock;

+ (instancetype)row;
+ (instancetype)rowWithID:(id<NSCopying>)rowid;
- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithID:(id<NSCopying>)rowid;

/**
 注册cell的类，并使用类名作为重用表示符
 */
- (void)setCellClass:(Class)cellClass;

/**
 注册cell的类
 @param reuseID 重用表示符。如果为nil，使用类名作为重用表示符
 */
- (void)setCellClass:(Class)cellClass forReuseID:(nullable NSString *)reuseID;
/// 重新渲染cell，如果cell未被重用，会触发当前数据源内部的tp_collectionViewCellWillDisplay:proxy:indexPath:方法
- (void)tp_displayCell;
@end

NS_ASSUME_NONNULL_END
