//
//  TPTableDataPrivateProtocol.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/26.
//

#import "TPTableDataPrivateProtocol.h"
#import "TPFoundationMethodSwizzling.h"
#import <objc/runtime.h>
#import "TPTableRow.h"
#import "TPTableViewProxy.h"

static char kTPTableProxyKey;

@implementation UITableViewCell (TPTableViewDataPrivate)
+ (void)load {
    TPFoundationSwizzling(self, @selector(prepareForReuse), @selector(tp_prepareForReuse));
}
- (void)tp_prepareForReuse {
    TPTableRow *row = [self.TPTableProxy.dataBindingMap objectForKey:self];
    if (row && [row respondsToSelector:@selector(tp_tableViewCellWillDisplay:proxy:indexPath:)]) {
        NSIndexPath *indexPath = [self.TPTableProxy.tableView indexPathForCell:self];
        [row tp_tableViewCellWillDisplay:self proxy:self.TPTableProxy indexPath:indexPath];
    }
    [self.TPTableProxy tp_unbindTableDataForView:self];
    [self tp_prepareForReuse];
}
- (TPTableViewProxy<TPTableViewProxyPrivateProtocol> *)TPTableProxy {
    return objc_getAssociatedObject(self, &kTPTableProxyKey);
}
- (void)setTPTableProxy:(TPTableViewProxy<TPTableViewProxyPrivateProtocol> *)TPTableProxy {
    objc_setAssociatedObject(self, &kTPTableProxyKey, TPTableProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)tp_displayTableRow:(TPTableRow *)row {
    UITableView *tableView = self.TPTableProxy.tableView;
    if (tableView.delegate && [tableView.delegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        NSIndexPath *indexPath = [tableView indexPathForCell:self];
        [tableView.delegate tableView:tableView willDisplayCell:self forRowAtIndexPath:indexPath];
    }
}
@end
