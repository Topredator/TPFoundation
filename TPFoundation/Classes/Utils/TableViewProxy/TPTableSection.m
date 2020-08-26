//
//  TPTableSection.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/26.
//

#import "TPTableSection.h"
#import "TPTableViewProxy.h"

@implementation TPTableSection
+ (instancetype)section {
    return [[self alloc] initWithId:nil];
}
+ (instancetype)sectionWithId:(id<NSCopying>)sId {
    return [[self alloc] initWithId:sId];
}
- (void)setHeaderClass:(Class)headerClass {
    [self setHeaderClass:headerClass reuseId:nil];
}
- (void)setHeaderClass:(Class)headerClass reuseId:(NSString *)reuseId {
    _headerClass = headerClass;
    _headerReuseId = reuseId ?: NSStringFromClass(headerClass);
}
- (void)setFooterClass:(Class)footerClass {
    [self setFooterClass:footerClass reuseId:nil];
}
- (void)setFooterClass:(Class)footerClass reuseId:(NSString *)reuseId {
    _footerClass = footerClass;
    _footerReuseId = reuseId ?: NSStringFromClass(footerClass);
}
#pragma mark ------------------------  TPTableViewSectionDelegate  ---------------------------
- (CGFloat)tp_tableViewHeaderHeightWithPorxy:(TPTableViewProxy *)proxy section:(NSUInteger)section {
    if (self.headerHeight) return self.headerHeight(self, proxy, section);
    return UITableViewAutomaticDimension;
}
- (CGFloat)tp_tableViewFooterHeightWithPorxy:(TPTableViewProxy *)proxy section:(NSUInteger)section {
    if (self.footerHeight) return self.footerHeight(self, proxy, section);
    return UITableViewAutomaticDimension;
}
- (void)tp_tableViewHeader:(__kindof UITableViewHeaderFooterView *)header preparedWithProxy:(TPTableViewProxy *)proxy section:(NSUInteger)section {
    if (self.headerPrepared) self.headerPrepared(self, header, proxy, section);
}
- (void)tp_tableViewFooter:(__kindof UITableViewHeaderFooterView *)footer preparedWithProxy:(TPTableViewProxy *)proxy section:(NSUInteger)section {
    if (self.footerPrepared) self.footerPrepared(self, footer, proxy, section);
}
@end

@implementation NSArray (TPTableSection)
- (TPTableSection *)tableSection {
    return [[TPTableSection alloc] initWithArray:self];
}
@end
