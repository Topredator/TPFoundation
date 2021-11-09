//
//  TPBannerVC.m
//  TPFoundation_Example
//
//  Created by Topredator on 2021/11/1.
//  Copyright © 2021 周晓路. All rights reserved.
//

#import "TPBannerVC.h"
#import <Masonry/Masonry.h>
#import "TPBannerPage.h"
#import <TPFoundation/TPFoundation.h>

@interface TPBannerVC () <TPUIBannerViewDelegate>
@property (nonatomic, strong) TPUIBannerView *banner;
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, strong) TPMath *math;
@end

@implementation TPBannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Banner";
    
    self.math = [TPMath tp_mathOnceLinearEquationWithPointA:TPMathPointMake(0, -50) pointB:TPMathPointMake(UIScreen.mainScreen.bounds.size.width, TPUI.tp_screenWidth - 50 - 80)];
    
    [self setupSubviews];
    [self.banner reloadData];
}
- (void)setupSubviews {
    [self.view addSubview:self.banner];
    [self.banner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
#pragma mark ------------------------  TPUIBannerViewDelegate  ---------------------------
- (NSInteger)numberOfPagesForBannerView:(TPUIBannerView *)bannerView {
    return self.images.count;
}
/// banner的页面
- (TPUIBannerPageView *)bannerView:(TPUIBannerView *)banner viewForPageIndex:(NSInteger)pageIndex {
    TPBannerPage *pageView = [banner dequeueReusablePageWithIdentifier:@"page"];
    if (!pageView) {
        pageView = [[TPBannerPage alloc] initWithReuseIdentifier:@"page"];
    }
    pageView.tag = pageIndex + 100;
    pageView.imageView.image = self.images[pageIndex];
    return pageView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != self.banner.scrollView) return;
    CGFloat x = scrollView.contentOffset.x;
    for (NSInteger i = 0; i < self.images.count; i++) {
        TPBannerPage *pageView = (TPBannerPage *)[scrollView viewWithTag:i + 100];
        pageView.imageView.tp_x = self.math.k * (x - i * TPUI.tp_screenWidth) + self.math.b;
    }
}
#pragma mark ------------------------  lazy method  ---------------------------
- (TPUIBannerView *)banner {
    if (!_banner) {
        _banner = [[TPUIBannerView alloc] initWithFrame:CGRectZero];
        _banner.delegate = self;
        _banner.pageControl.hidden = YES;
        _banner.backgroundColor = UIColor.whiteColor;
    }
    return _banner;
}
- (NSArray *)images {
    if (!_images) {
        _images = @[
            [UIImage imageNamed:@"1"],
            [UIImage imageNamed:@"2"],
            [UIImage imageNamed:@"3"],
            [UIImage imageNamed:@"4"],
            [UIImage imageNamed:@"5"]
        ];
    }
    return _images;
}
@end
