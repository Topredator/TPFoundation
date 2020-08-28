//
//  UICollectionViewCell+TPCollectionDataPrivate.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/28.
//

#import <UIKit/UIKit.h>
#import "TPDataProxyProtocol.h"

NS_ASSUME_NONNULL_BEGIN
@class TPCollectionViewProxy;
@class TPCollectionRow;

@protocol TPCollectionViewProxyPrivateProtocol <TPDataProxyProtocol>
/// 数据与view绑定
- (void)tp_bindCollectionData:(id <TPDataPrivateProtocol>)data forView:(__kindof UIView *)view;
/// 数据与view解绑
- (void)tp_unbindCollectionDataForView:(__kindof UIView *)view;
/// 解绑所有
- (void)tp_unbindAllCollectionData;
@end




/// collectionViewCell 扩展
@interface UICollectionViewCell (TPCollectionDataPrivate)
@property (nonatomic, strong) TPCollectionViewProxy <TPCollectionViewProxyPrivateProtocol> *TPCollectionProxy;
/// cell 通过row展示
- (void)tp_displayCollectionRow:(TPCollectionRow *)row;
@end

NS_ASSUME_NONNULL_END
