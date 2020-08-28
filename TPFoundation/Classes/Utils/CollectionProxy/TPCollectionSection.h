//
//  TPCollectionSection.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/28.
//

#import "TPMutableArray.h"

NS_ASSUME_NONNULL_BEGIN
@class TPCollectionSection;
@class TPCollectionViewProxy;

/// section header/footer 展示
typedef void (^TPCollectionSectionPreparedBlock)(__kindof TPCollectionSection *sectionData, __kindof UICollectionReusableView *view, TPCollectionViewProxy *proxy, NSUInteger section);
/// cell 的最小行间距
typedef CGFloat (^TPCollectionMinimumLineSpacingBlock)(__kindof TPCollectionSection *sectionData, TPCollectionViewProxy *proxy, NSUInteger section);
/// cell 最小间距
typedef CGFloat (^TPCollectionMinimumInteritemSpacingBlock)(__kindof TPCollectionSection *sectionData, TPCollectionViewProxy *proxy, NSUInteger section);
/// 分区 inset
typedef UIEdgeInsets (^TPCollectionSectionInsetBlock)(__kindof TPCollectionSection *sectionData, TPCollectionViewProxy *proxy, NSUInteger section);

/// 分区头尾高度
typedef CGSize (^TPCollectionSectionSizeBlock)(__kindof TPCollectionSection *sectionData, TPCollectionViewProxy *proxy, NSUInteger section);


@protocol TPCollectionSectionDelegate <NSObject>
/// 分区header 初始化
- (void)tp_collectionViewHeader:(__kindof UICollectionReusableView *)header preparedWithProxy:(TPCollectionViewProxy *)proxy section:(NSUInteger)section;
/// 分区footer 初始化
- (void)tp_collectionViewFooter:(__kindof UICollectionReusableView *)footer preparedWithProxy:(TPCollectionViewProxy *)proxy section:(NSUInteger)section;
/// 最小行间距
- (CGFloat)tp_collectionMinimumLineSpacingWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section;
/// 最小间距
- (CGFloat)tp_collectionMinimumInteritemSpacingWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section;
/// 分区头部高度
- (CGSize)tp_collectionSectionHeaderSizeWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section;
/// 分区尾部高度
- (CGSize)tp_collectionSectionFooterSizeWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section;
/// 分区内边距
- (UIEdgeInsets)tp_collectionSectionInsetWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section;
@end
/// collectionView section绑定对象
@interface TPCollectionSection<__covariant ObjectType> : TPMutableArray <TPCollectionSectionDelegate>
/// 额外信息，默认为nil
@property (nonatomic, strong) NSDictionary *infoDictionary;
/// SectionHeaderView的类，如果为nil，则显示系统默认header
@property (nonatomic, readonly) Class headerClass;
/// SectionHeaderView的重用标识符
@property (nonatomic, readonly) NSString *headerReuseID;

@property (nonatomic, copy) TPCollectionSectionPreparedBlock headerPrepared;
@property (nonatomic, copy) TPCollectionSectionSizeBlock headerSizeBlock;

/// SectionFooterView的类，如果为nil，则显示系统默认footer
@property (nonatomic, readonly) Class footerClass;
/// SectionHeaderView的重用标识符
@property (nonatomic, readonly) NSString *footerReuseID;
@property (nonatomic, copy) TPCollectionSectionPreparedBlock footerPrepared;
@property (nonatomic, copy) TPCollectionSectionSizeBlock footerSizeBlock;

/// 分区行间距
@property (nonatomic, copy) TPCollectionMinimumLineSpacingBlock lineSpacingBlock;
/// 分区item间距
@property (nonatomic, copy) TPCollectionMinimumInteritemSpacingBlock itemSpacingBlock;
/// 分区内边距
@property (nonatomic, copy) TPCollectionSectionInsetBlock sectionInsetBlock;


+ (instancetype)section;
+ (instancetype)sectionWithID:(id<NSCopying>)sid;
/**
 注册SectionHeaderView的类，使用类名作为重用标识符
 */
- (void)setHeaderClass:(Class)headerClass;

/**
 注册SectionHeaderView的类，如果identifier为nil，使用类名作为重用标识符
 */
- (void)setHeaderClass:(Class)headerClass withReuseID:(nullable NSString *)identifier;

/**
 注册SectionFooterView的类，使用类名作为重用标识符
 */
- (void)setFooterClass:(Class)footerClass;

/**
 注册SectionFooterView的类，如果identifier为nil，使用类名作为重用标识符
 */
- (void)setFooterClass:(Class)footerClass withReuseID:(nullable NSString *)identifier;
@end

@interface NSArray (TPCollectionSection)
- (TPCollectionSection *)collectionSection;
@end

NS_ASSUME_NONNULL_END
