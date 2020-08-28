//
//  TPTableSection.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/26.
//

#import "TPMutableArray.h"
NS_ASSUME_NONNULL_BEGIN

@class TPTableViewProxy;
@class TPTableSection;
/// section高
typedef CGFloat (^TPTableSectionHeightBlock)(__kindof TPTableSection *sectionData, TPTableViewProxy *proxy, NSUInteger section);
/// section header/footer 展示
typedef void (^TPTableSectionPreparedBlock)(__kindof TPTableSection *sectionData, __kindof UITableViewHeaderFooterView *view, TPTableViewProxy *proxy, NSUInteger section);

@protocol TPTableViewSectionDelegate <NSObject>
/// 分区header的高
- (CGFloat)tp_tableViewHeaderHeightWithPorxy:(TPTableViewProxy *)proxy section:(NSUInteger)section;
/// 分区footer的高
- (CGFloat)tp_tableViewFooterHeightWithPorxy:(TPTableViewProxy *)proxy section:(NSUInteger)section;
/// 初始化 分区header
- (void)tp_tableViewHeader:(__kindof UITableViewHeaderFooterView *)header preparedWithProxy:(TPTableViewProxy *)proxy section:(NSUInteger)section;
/// 初始化 分区footer
- (void)tp_tableViewFooter:(__kindof UITableViewHeaderFooterView *)footer preparedWithProxy:(TPTableViewProxy *)proxy section:(NSUInteger)section;
@end


/// 对应tableview分区的模型
@interface TPTableSection<__covariant ObjectType> : TPMutableArray <TPTableViewSectionDelegate>
/// 额外信息，默认为nil
@property (nonatomic, strong) NSDictionary *infoDic;
/// 分区header的类
@property (nonatomic, readonly) Class headerClass;
/// 分区header重用标识符
@property (nonatomic, readonly) NSString *headerReuseId;
/// 分区header的高
@property (nonatomic, assign) TPTableSectionHeightBlock headerHeight;
/// 分区header 初始化
@property (nonatomic, copy) TPTableSectionPreparedBlock headerPrepared;

/// 分区footer的类
@property (nonatomic, readonly) Class footerClass;
/// 分区footer 重用标识符
@property (nonatomic, readonly) NSString *footerReuseId;
/// 分区footer的高
@property (nonatomic, assign) TPTableSectionHeightBlock footerHeight;
/// 分区footer 初始化
@property (nonatomic, copy) TPTableSectionPreparedBlock footerPrepared;


/// 便利构造器 初始化
+ (instancetype)section;

/// 便利构造器 初始化
/// @param sId 身份Id
+ (instancetype)sectionWithId:(nullable id <NSCopying>)sId;


/// 注册sectionHeaderView的类，类名作为标识符
/// @param headerClass 类名
- (void)setHeaderClass:(Class)headerClass;

/// 注册sectionHeaderView的类
/// @param headerClass 类名
/// @param reuseId 标识符
- (void)setHeaderClass:(Class)headerClass reuseId:(nullable NSString *)reuseId;


/// 注册sectionFooterView的类，类名为标识符
/// @param footerClass 类名
- (void)setFooterClass:(Class)footerClass;

/// 注册sectionFooterView的类
/// @param footerClass 类名
/// @param reuseId 标识符
- (void)setFooterClass:(Class)footerClass reuseId:(nullable NSString *)reuseId;
@end

@interface NSArray (TPTableSection)
- (TPTableSection *)tableSection;
@end

NS_ASSUME_NONNULL_END
