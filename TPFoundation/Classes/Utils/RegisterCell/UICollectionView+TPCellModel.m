//
//  UICollectionView+TPCellModel.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/25.
//

#import "UICollectionView+TPCellModel.h"

@implementation UICollectionView (TPCellModel)
- (void)tp_registerCell:(NSArray <TPTableCellModel *>*)cells {
    if (!cells.count) return;
//    for (TPTableCellModel *model in cells) {
//        if (model.type == TPCellModelRegistrationTypeCode) {
//            [self registerClass:NSClassFromString(model.className) forCellWithReuseIdentifier:model.resueIdentifier];
//        } else {
//            UINib *nib = [UINib nibWithNibName:model.className bundle:nil];
//            [self registerNib:nib forCellWithReuseIdentifier:model.resueIdentifier];
//        }
//    }
}

- (void)tp_regitsterSections:(NSArray <TPTableCellModel *>*)sections elementKind:(NSString *)elementKind {
    
}
@end
