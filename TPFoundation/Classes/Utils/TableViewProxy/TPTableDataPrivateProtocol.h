//
//  TPTableDataPrivateProtocol.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/26.
//

#import <Foundation/Foundation.h>
#import "TPDataProxyProtocol.h"

@class TPTableRow;
@class TPTableViewProxy;


/// tableview代理 私有协议
@protocol TPTableViewProxyPrivateProtocol <TPDataProxyProtocol>
/// 数据与view 绑定
- (void)tp_bindTableData:(id <TPDataPrivateProtocol>)data view:(__kindof UIView *)view;
/// 数据与view 解绑
- (void)tp_unbindTableDataForView:(__kindof UIView *)view;
/// 解绑所有数据
- (void)tp_unbindAllTableData;
@end

@interface UITableViewCell (TPTableViewDataPrivate)
@property (nonatomic, strong) TPTableViewProxy <TPTableViewProxyPrivateProtocol> *TPTableProxy;
/// cell 通过row展示
- (void)tp_displayTableRow:(TPTableRow *)row;
@end
