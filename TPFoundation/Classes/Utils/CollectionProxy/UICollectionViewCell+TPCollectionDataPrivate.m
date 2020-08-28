//
//  UICollectionViewCell+TPCollectionDataPrivate.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/28.
//

#import "UICollectionViewCell+TPCollectionDataPrivate.h"
#import "TPFoundationMethodSwizzling.h"
#import <objc/runtime.h>
#import "TPCollectionRow.h"
#import "TPCollectionViewProxy.h"

static char kTPCollectionProxyKey;
@implementation UICollectionViewCell (TPCollectionDataPrivate)
+ (void)load {
    TPFoundationSwizzling(self, @selector(prepareForReuse), @selector(tp_prepareForReuse));
}
- (void)tp_prepareForReuse {
    TPCollectionRow *row = [self.TPCollectionProxy.dataBindingMap objectForKey:self];
    if (row && [row respondsToSelector:@selector(tp_collectionViewCellWillDisplay:proxy:indexPath:)]) {
        NSIndexPath *indexPath = [self.TPCollectionProxy.collectionView indexPathForCell:self];
        [row tp_collectionViewCellWillDisplay:self proxy:self.TPCollectionProxy indexPath:indexPath];
    }
    [self.TPCollectionProxy tp_unbindCollectionDataForView:self];
    [self tp_prepareForReuse];
}
- (TPCollectionViewProxy<TPCollectionViewProxyPrivateProtocol> *)TPCollectionProxy {
    return objc_getAssociatedObject(self, &kTPCollectionProxyKey);
}
- (void)setTPCollectionProxy:(TPCollectionViewProxy<TPCollectionViewProxyPrivateProtocol> *)TPCollectionProxy {
    objc_setAssociatedObject(self, &kTPCollectionProxyKey, TPCollectionProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)tp_displayCollectionRow:(TPCollectionRow *)row {
    UICollectionView *collectionView = self.TPCollectionProxy.collectionView;
    if (collectionView.delegate && [collectionView.delegate respondsToSelector:@selector(collectionView:willDisplayCell:forItemAtIndexPath:)]) {
        NSIndexPath *indexPath = [collectionView indexPathForCell:self];
        [collectionView.delegate collectionView:collectionView willDisplayCell:self forItemAtIndexPath:indexPath];
    }
}

@end
