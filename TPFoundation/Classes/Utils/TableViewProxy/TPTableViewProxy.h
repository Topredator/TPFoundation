//
//  TPTableViewProxy.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/26.
//

#import <Foundation/Foundation.h>
#import "TPTableSection.h"
#import "TPTableRow.h"

NS_ASSUME_NONNULL_BEGIN

/// tableview的数据代理
@interface TPTableViewProxy : NSObject <UITableViewDataSource, UITableViewDelegate>
/// 被代理的列表
@property (nonatomic, weak, readonly) UITableView *tableView;
@property (nonatomic, weak) id <UITableViewDataSource> dataSource;
@property (nonatomic, weak) id <UITableViewDelegate> delegate;
@property (nonatomic, copy, readonly) NSArray <TPTableSection <TPTableRow *>*>*data;
/// 便利构造器 初始化
/// @param tableView 被代理的table
+ (instancetype)proxyWithTableView:(UITableView *)tableView;
/// 禁用初始化
- (instancetype)init NS_UNAVAILABLE;
/// 初始化方法，会赋值tableview的DataSource及delegate 到当前proxy
- (instancetype)initWithTableView:(UITableView *)tableView;


/// 重新加载数据
/// @param data 特定的嵌套数据
- (void)reloadData:(NSArray <TPTableSection <TPTableRow *>*>*)data;

/// 刷新sections
- (void)reloadSections:(nonnull NSArray <TPTableSection <TPTableRow *>*>*)sections indexSet:(nonnull NSIndexSet *)indexSet;
/// 刷新rows
- (void)reloadRows:(nonnull NSArray <TPTableRow *>*)rows indexPaths:(nonnull NSArray <NSIndexPath *>*)indexPaths;
@end

@interface UITableView (TPTableViewProxy)
@property (nonatomic, strong) TPTableViewProxy *TPProxy;
@end

@interface UIViewController (TPTableViewProxy)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
