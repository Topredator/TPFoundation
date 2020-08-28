//
//  TPDataProxyProtocol.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/26.
//

#import <Foundation/Foundation.h>


/// 数据代理协议
@protocol TPDataProxyProtocol <NSObject>
/// 数据绑定 容器; 例:{cell : row} cell为key，row为value
- (NSMapTable *)dataBindingMap;
@end


/// 私有数据协议
@protocol TPDataPrivateProtocol <NSObject>
/// 绑定视图 (数据代理与视图进行绑定)
- (void)tp_bindView:(__kindof UIView *)view dataProxy:(id <TPDataProxyProtocol>)dataProxy;
/// 解绑视图 (数据代理与视图进行解绑)
- (void)tp_unbindViewWithProxy:(id <TPDataProxyProtocol>)dataProxy;
@end
