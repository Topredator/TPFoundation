//
//  UITableView+TPCellModel.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/25.
//

#import <UIKit/UIKit.h>
#import "TPTableCellModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 注册cell 扩展
@interface UITableView (TPCellModel)

/// 注册cell 或 headerFooterView
/// @param data 用于存储的模型
- (void)tp_registerAllClassWithData:(NSArray <TPTableCellModel *>*)data;
@end

NS_ASSUME_NONNULL_END
