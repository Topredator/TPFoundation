//
//  TPUIPopupMenuVC.m
//  TPUIKit
//
//  Created by Topredator on 2021/10/20.
//

#import "TPUIPopupMenuVC.h"
#import <Masonry/Masonry.h>
#import "TPUI.h"
#import "TPUIPopupMenuCell.h"
@interface TPUIPopupMenuVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *bgMaskView;
@property (nonatomic, strong) TPUIPopupMenuConfig *config;
@property (nonatomic, assign) NSInteger selectedIndex;
/// 内容高度约束
@property (nonatomic, strong) MASConstraint *heightConstraint;
@end

@implementation TPUIPopupMenuVC
- (instancetype)initMenuConfig:(TPUIPopupMenuConfig *)config titles:(NSArray <NSString *> *)titles {
    self = [super initWithNibName:nil bundle:[NSBundle bundleForClass:TPUIPopupMenuVC.class]];
    if (self) {
        self.config = config ?: [TPUIPopupMenuConfig new];
        _menuTitles = titles;
    }
    return self;
}
+ (instancetype)menuConfig:(TPUIPopupMenuConfig *)config titles:(NSArray <NSString *> *)titles {
    return [[self alloc] initMenuConfig:config titles:titles];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor = [UIColor clearColor];
    [self setupSubviews];
    self.selectedIndex = self.config.selectedIndex;
}
- (void)setupSubviews {
    [self.view addSubview:self.bgMaskView];
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.tableView];
    [TPUI tp_adjustsInsets:self.tableView vc:self];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.bgMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)presentInTargetVC:(UIViewController *)targetVC contentHeight:(CGFloat)contentHeight topOffset:(CGFloat)topOffset {
    _targetVC = targetVC;
    [targetVC addChildViewController:self];
    [targetVC.view addSubview:self.view];
    if ((targetVC.navigationController && !targetVC.navigationController.navigationBar.translucent) || !targetVC.navigationController) {
        self.view.frame = CGRectMake(0, topOffset, targetVC.view.bounds.size.width, targetVC.view.bounds.size.height);
    } else {
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake([TPUI tp_topBarHeight] + topOffset, 0, 0, 0));
        }];
    }
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        self.heightConstraint = make.height.mas_equalTo(0);
    }];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.heightConstraint.mas_equalTo(contentHeight);
        self.bgMaskView.alpha = 1;
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    } completion:nil];
}
- (void)dismiss {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.heightConstraint.mas_equalTo(0);
        self.bgMaskView.alpha = 0;
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (self.dismissBlock) {
            self.dismissBlock();
        }
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

- (CGFloat)maxContentHeight {
    return self.menuTitles.count * self.config.rowHeight;
}
#pragma mark ------------------------  UITableViewDataSource & UITableViewDelegate  ---------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuTitles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.config.rowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section { return 0.01; }
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section { return 0.01; }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TPUIPopupMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TPUIPopupMenuCell" forIndexPath:indexPath];
    [cell configTitle:self.menuTitles[indexPath.row] config:self.config];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndex = indexPath.row;
    [self dismiss];
    if (self.didSelectedBlock) {
        self.didSelectedBlock(indexPath.row);
    }
}
#pragma mark ------------------------  Setter  ---------------------------
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    if (selectedIndex < 0 || selectedIndex >= self.menuTitles.count) {
        if (_tableView.indexPathForSelectedRow) {
            [_tableView deselectRowAtIndexPath:_tableView.indexPathForSelectedRow animated:NO];
        }
    } else {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        [_tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}
#pragma mark ------------------------  lazy method  ---------------------------
- (UIButton *)bgMaskView {
    if (!_bgMaskView) {
        _bgMaskView = [[UIButton alloc] initWithFrame:CGRectZero];
        _bgMaskView.backgroundColor = self.config.shieldColor;
        [_bgMaskView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _bgMaskView.alpha = 0;
    }
    return _bgMaskView;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _contentView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delaysContentTouches = YES;
        _tableView.separatorStyle = self.config.isShowDivider ? UITableViewCellSeparatorStyleSingleLine : UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorColor = [TPUI rgba:229];
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:TPUIPopupMenuCell.class forCellReuseIdentifier:@"TPUIPopupMenuCell"];
    }
    return _tableView;
}
@end
