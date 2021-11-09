//
//  TPUIShadowCell.m
//  TPUIKit
//
//  Created by Topredator on 2021/10/20.
//

#import "TPUIShadowCell.h"
#import "TPUI.h"
#import "TPUIShadowCellConfig.h"
#import <Masonry/Masonry.h>
@interface TPUIShadowCell ()
@property (nonatomic, strong) UIImageView *bgImageView;
@end

@implementation TPUIShadowCell
- (void)setupSubviews {
    [self.contentView addSubview:self.bgImageView];
    [self.contentView addSubview:self.container];
}
- (void)makeConstrains {
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets([TPUIShadowCellConfig config].cellMaker.containerInsets);
    }];
}
- (void)tp_prepareCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    NSInteger rows = [tableView numberOfRowsInSection:indexPath.section];
    if (rows == 1) { // 只有一个
        self.bgImageView.image = [TPUIShadowCellConfig.config.cellMaker.totalImage
                                  resizableImageWithCapInsets:TPUIShadowCellConfig.config.cellMaker.totalInsets resizingMode:UIImageResizingModeStretch];
        [self.container mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(TPUIShadowCellConfig.config.cellMaker.containerInsets);
        }];
    } else {
        if (indexPath.row == 0) { // 分区第一个
            self.bgImageView.image = [TPUIShadowCellConfig.config.cellMaker.topImage
                                      resizableImageWithCapInsets:TPUIShadowCellConfig.config.cellMaker.topInsets
                                      resizingMode:UIImageResizingModeStretch];
            UIEdgeInsets topInsets = TPUIShadowCellConfig.config.cellMaker.topInsets;
            [self.container mas_remakeConstraints:^(MASConstraintMaker *make) {
               make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(topInsets.top,
                                                                            topInsets.left,
                                                                            0,
                                                                            topInsets.bottom));
            }];
        } else if (indexPath.row == rows - 1) { // 分区最后一个
            self.bgImageView.image = [TPUIShadowCellConfig.config.cellMaker.bottomImage
                                      resizableImageWithCapInsets:TPUIShadowCellConfig.config.cellMaker.bottomInsets
                                      resizingMode:UIImageResizingModeStretch];
            UIEdgeInsets bottomInsets = TPUIShadowCellConfig.config.cellMaker.bottomInsets;
            [self.container mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0,
                                                                             bottomInsets.left,
                                                                             bottomInsets.bottom,
                                                                             bottomInsets.right));
            }];
        } else { // 分区中间
            self.bgImageView.image = [TPUIShadowCellConfig.config.cellMaker.middleImage
                                      resizableImageWithCapInsets:TPUIShadowCellConfig.config.cellMaker.middleInsets
                                      resizingMode:UIImageResizingModeStretch];
            UIEdgeInsets middleInsets = TPUIShadowCellConfig.config.cellMaker.middleInsets;
            [self.container mas_remakeConstraints:^(MASConstraintMaker *make) {
               make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0,
                                                                            middleInsets.left,
                                                                            0,
                                                                            middleInsets.right));
            }];
        }
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark ------------------------  lazy method  ---------------------------
- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] initWithFrame:self.contentView.bounds];
        _container.backgroundColor = UIColor.clearColor;
    }
    return _container;
}
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[TPUIShadowCellConfig config].cellMaker.totalImage];
    }
    return _bgImageView;
}
@end
