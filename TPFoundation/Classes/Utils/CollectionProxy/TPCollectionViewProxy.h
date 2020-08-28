//
//  TPCollectionViewProxy.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/28.
//

#import <Foundation/Foundation.h>
#import "TPCollectionRow.h"
#import "TPCollectionSection.h"

NS_ASSUME_NONNULL_BEGIN

/// collectionView的代理
@interface TPCollectionViewProxy : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak, readonly) UICollectionView *collectionView;
@property (nonatomic, weak) id <UICollectionViewDataSource> dataSource;
@property (nonatomic, weak) id <UICollectionViewDelegate> delegate;

/// 特定的数据结构
@property (nonatomic, copy, readonly) NSArray <TPCollectionSection <TPCollectionRow *> *> *data;
/**
 工厂方法
 */
+ (instancetype)proxyWithCollectionView:(UICollectionView *)collectionView;

/**
 禁用初始化方法
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 初始化方法，会赋值collectionView的Delegate及DataSource到当前Proxy
 */
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;;

/**
 重新加载数据，会强制赋值collectionView的Delegate及DataSource为当前Proxy
 @param data 嵌套的列表数据
 */
- (void)reloadData:(NSArray <TPCollectionSection <TPCollectionRow *>*>*)data;
/// 刷新sections
- (void)reloadSections:(nonnull NSArray <TPCollectionSection <TPCollectionRow *>*>*)sections indexSet:(nonnull NSIndexSet *)indexSet;
/// 刷新rows
- (void)reloadRows:(nonnull TPMutableArray <TPCollectionRow *>*)rows indexPaths:(nonnull NSArray <NSIndexPath *>*)indexPaths;
@end

@interface UICollectionView (TPCollectionViewProxy)
@property (nonatomic, strong) TPCollectionViewProxy *TPProxy;
@end

NS_ASSUME_NONNULL_END
