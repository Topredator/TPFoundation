//
//  TPUIPopupMenuCell.m
//  TPUIKit
//
//  Created by Topredator on 2021/10/20.
//

#import "TPUIPopupMenuCell.h"
#import "TPUI.h"
#import <Masonry/Masonry.h>
@interface TPUIPopupMenuCell ()
@property (nonatomic, strong) TPUIPopupMenuConfig *config;
@end

@implementation TPUIPopupMenuCell
- (void)setupSubviews {
    self.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.titleLabel];
}
- (void)makeConstrains {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configTitle:(NSString *)title config:(TPUIPopupMenuConfig *)config {
    self.config = config;
    self.titleLabel.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.titleLabel.font = selected ? self.config.selectedTextFont : self.config.textFont;
    self.titleLabel.textColor = selected ? self.config.selectedTextColor : self.config.textColor;
    self.contentView.backgroundColor = selected ? self.config.selectedBgColor : self.config.bgColor;
}
#pragma mark ------------------------  lazy method  ---------------------------
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:14 weight:FontMedium];
        _titleLabel.textColor = [TPUI rgba:51];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
