//
//  TPUITableViewCell.m
//  TPUIKit
//
//  Created by Topredator on 2021/10/20.
//

#import "TPUITableViewCell.h"


@implementation TPUITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
        [self makeConstrains];
    }
    return self;
}
- (void)setupSubviews {}
- (void)makeConstrains {}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
