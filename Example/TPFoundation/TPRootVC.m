//
//  TPRootVC.m
//  TPFoundation_Example
//
//  Created by Topredator on 2021/11/1.
//  Copyright © 2021 周晓路. All rights reserved.
//

#import "TPRootVC.h"
#import <TPFoundation/TPFoundation.h>
#import <Masonry/Masonry.h>

#import "TPBannerVC.h"
@interface TPRootVC ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *titles;
@end

@implementation TPRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Root";
    [self setupSubviews];
    [self loadData];
}
- (void)setupSubviews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)loadData {
    TPTableSection *section = [TPTableSection section];
    [section tp_safetyAddObject:[self fetchRow]];
    [self.tableView.TPProxy reloadData:@[section]];
}
- (TPTableRow *)fetchRow {
    TPTableRow *row = [TPTableRow row];
    row.cellPrepared = ^(__kindof TPTableRow * _Nonnull rowData, __kindof UITableViewCell * _Nonnull cell, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        cell.textLabel.text = self.titles[indexPath.row];
    };
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        switch (indexPath.row) {
            case 0: {
                [TPUINavigator pushViewController:TPBannerVC.new animated:YES];
            }
                break;
            default: break;
        }
    };
    row.cellHeight = ^CGFloat(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        return 45.0;
    };
    return row;
}
#pragma mark ------------------------  lazy method  ---------------------------
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.TPProxy = [TPTableViewProxy proxyWithTableView:_tableView];
    }
    return _tableView;
}
- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"视觉效果动画"];
    }
    return _titles;
}
@end
