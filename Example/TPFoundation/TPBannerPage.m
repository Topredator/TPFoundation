//
//  TPBannerPage.m
//  TPFoundation_Example
//
//  Created by Topredator on 2021/11/1.
//  Copyright © 2021 周晓路. All rights reserved.
//

#import "TPBannerPage.h"
#import <Masonry/Masonry.h>
@implementation TPBannerPage
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.masksToBounds = YES;
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews {
    [self addSubview:self.imageView];
    self.imageView.frame = CGRectMake(-50, 0, TPUI.tp_screenWidth + 100, TPUI.tp_screenHeight - TPUI.tp_topBarHeight);
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(-50);
//        make.width.mas_equalTo(TPUI.tp_screenWidth + 100);
//        make.top.bottom.mas_equalTo(0);
//    }];
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode =  UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}
@end
