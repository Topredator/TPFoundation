//
//  TPTableRow.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/26.
//

#import <Foundation/Foundation.h>
#import "TPModelID.h"
NS_ASSUME_NONNULL_BEGIN

@class TPTableViewProxy;
@class TPTableRow;

/// cell的高
typedef CGFloat (^TPTableCellHeightBlock)(__kindof TPTableRow *rowData, TPTableViewProxy *proxy, NSIndexPath *indexPath);
/// cell 将要出现
typedef void (^TPTableCellWillDisplayBlock)(__kindof TPTableRow *rowData, __kindof UITableViewCell *cell, TPTableViewProxy *proxy, NSIndexPath *indexPath);
/// cell 初始化
typedef void (^TPTableCellPreparedBlock)(__kindof TPTableRow *rowData, __kindof UITableViewCell *cell, TPTableViewProxy *proxy, NSIndexPath *indexPath);
/// cell 点击
typedef void (^TPTableCellDidSelectedBlock)(__kindof TPTableRow *rowData, TPTableViewProxy *proxy, NSIndexPath *indexPath);
/// cell 是否可编辑
typedef BOOL (^TPTableCellCanEditBlock)(__kindof TPTableRow *rowData, TPTableViewProxy *proxy, NSIndexPath *indexPath);
/// cell 编辑提交
typedef void (^TPTableCellCommitEditingBlock)(__kindof TPTableRow *rowData, UITableViewCellEditingStyle editingStyle, TPTableViewProxy *proxy, NSIndexPath *indexPath);
/// cell删除标题内容自定
typedef NSString *_Nonnull(^TPTableCellTitleForDeleteBlock)(__kindof TPTableRow *rowData,TPTableViewProxy *proxy, NSIndexPath *indexPath);

@protocol TPTableRowDelegate <NSObject>
/// cell 高
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath;
/// cell 将要出现
- (void)tp_tableViewCellWillDisplay:(__kindof UITableViewCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath;
/// cell 初始化
- (void)tp_tableViewPreparedCell:(__kindof UITableViewCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath;
/// cell 点击
- (void)tp_tableViewCellDidSelected:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath;
/// cell 是否能编辑
- (BOOL)tp_tableViewCanEditRowWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath;
/// cell 提交编辑
- (void)tp_tableViewCommitEditingStyle:(UITableViewCellEditingStyle)editingStyle proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath;
/// cell 删除按钮文案
- (NSString *)tp_tableViewTitleForDeleteConfirmationButtonForRowAtIndexPath:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath;
@optional
/// 将要重用
- (void)tp_tableViewCellWillReuse:(__kindof UITableViewCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath;
@end


/// tableview cell对应的对象
@interface TPTableRow : NSObject <TPModelID, TPTableRowDelegate>
/// 额外信息
@property (nonatomic, strong) NSDictionary *infoDic;
/// 注册cell的类
@property (nonatomic, readonly) Class cellClass;
/// cell的重用标识符
@property (nonatomic, copy, readonly) NSString *cellReuseId;
/// 当前展示的cell，当cell被重用时置空
@property (nonatomic, weak, readonly) __kindof UITableViewCell *cell;
/// cell的高
@property (nonatomic, assign) TPTableCellHeightBlock cellHeight;
/// cell将要出现
@property (nonatomic, copy) TPTableCellWillDisplayBlock cellWillDisplay;
/// cell初始化
@property (nonatomic, copy) TPTableCellPreparedBlock cellPrepared;
/// cell 点击
@property (nonatomic, copy) TPTableCellDidSelectedBlock cellDidSelected;
/// cell 是否可编辑
@property (nonatomic, copy) TPTableCellCanEditBlock cellCanEdit;
/// cell 提交编辑
@property (nonatomic, copy) TPTableCellCommitEditingBlock cellCommitEditing;
/// 自定义删除按钮标题
@property (nonatomic, copy) TPTableCellTitleForDeleteBlock titleForDeleteBlock;

+ (instancetype)row;
+ (instancetype)rowWithID:(nullable id<NSCopying>)rowid;
- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithID:(nullable id<NSCopying>)rowid;


/// 注册cell
/// @param cellClass 类名
- (void)setCellClass:(Class)cellClass;
/// 注册cell
/// @param cellClass 类名
/// @param reuseId 重用标识符
- (void)setCellClass:(Class)cellClass reuseId:(nullable NSString *)reuseId;

/// 重新渲染cell，如果cell未被重用，会触发当前数据源内部的tp_tableViewWillDisplayCell:withTableView:indexPath:方法
- (void)displayCell;
@end

NS_ASSUME_NONNULL_END
