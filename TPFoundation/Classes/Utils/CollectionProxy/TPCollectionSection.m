//
//  TPCollectionSection.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/28.
//

#import "TPCollectionSection.h"
#import "TPCollectionViewProxy.h"

@implementation TPCollectionSection
+ (instancetype)section {
    return [[self alloc] initWithID:nil];
}

+ (instancetype)sectionWithID:(id<NSCopying>)identity {
    return [[self alloc] initWithID:identity];
}

- (void)setHeaderClass:(Class)headerClass {
    [self setHeaderClass:headerClass withReuseID:nil];
}

- (void)setHeaderClass:(Class)headerClass withReuseID:(NSString *)identifier {
    _headerClass = headerClass;
    _headerReuseID = identifier ?: NSStringFromClass(headerClass);
}

- (void)setFooterClass:(Class)footerClass {
    [self setFooterClass:footerClass withReuseID:nil];
}

- (void)setFooterClass:(Class)footerClass withReuseID:(NSString *)identifier {
    _footerClass = footerClass;
    _footerReuseID = identifier ?: NSStringFromClass(footerClass);
}
#pragma mark ------------------------  TPCollectionSectionDelegate  ---------------------------
- (void)tp_collectionViewHeader:(__kindof UICollectionReusableView *)header preparedWithProxy:(TPCollectionViewProxy *)proxy section:(NSUInteger)section {
    if (self.headerPrepared) self.headerPrepared(self, header, proxy, section);
}
- (void)tp_collectionViewFooter:(__kindof UICollectionReusableView *)footer preparedWithProxy:(TPCollectionViewProxy *)proxy section:(NSUInteger)section {
    if (self.footerPrepared) self.footerPrepared(self, footer, proxy, section);
}
- (CGFloat)tp_collectionMinimumLineSpacingWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    if (self.lineSpacingBlock) return self.lineSpacingBlock(self, proxy, section);
    return 0;
}
- (CGFloat)tp_collectionMinimumInteritemSpacingWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    if (self.itemSpacingBlock) return self.itemSpacingBlock(self, proxy, section);
    return 0;
}
- (CGSize)tp_collectionSectionHeaderSizeWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    if (self.headerSizeBlock) return self.headerSizeBlock(self, proxy, section);
    return CGSizeZero;
}
- (CGSize)tp_collectionSectionFooterSizeWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    if (self.footerSizeBlock) return self.footerSizeBlock(self, proxy, section);
    return CGSizeZero;
}
- (UIEdgeInsets)tp_collectionSectionInsetWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    if (self.sectionInsetBlock) return self.sectionInsetBlock(self, proxy, section);
    return UIEdgeInsetsZero;
}
@end

@implementation NSArray (TPCollectionSection)
- (TPCollectionSection *)collectionSection {
    return [[TPCollectionSection alloc] initWithArray:self];
}

@end
