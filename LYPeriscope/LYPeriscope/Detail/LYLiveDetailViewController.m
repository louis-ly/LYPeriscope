//
//  LYLiveDetailViewController.m
//  LYPeriscope
//
//  Created by Louis on 16/7/13.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "LYLiveDetailViewController.h"
#import "LYLiveDetailCell.h"
#import "LYLiveDetailHeaderView.h"

#define LYLiveDetailTitleViewHeight 60
#define LYLiveDetailTableY 128

@interface LYLiveDetailTableView : UITableView
@end
@implementation LYLiveDetailTableView
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return point.y < 0 ? nil : [super hitTest:point withEvent:event];
}
@end

@interface LYLiveDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *chatShowBtn;

@property (nonatomic, strong) LYLiveDetailTableView *tableView;
@property (nonatomic, strong) UIView *tableBGView;
@property (nonatomic, strong) LYLiveDetailHeaderView *tableHeaderView;
@property (nonatomic, strong) UIView *suspendView;
@end

@implementation LYLiveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.view insertSubview:self.tableBGView belowSubview:self.tableView];
    [self.view addSubview:self.titleView];
    [self scrollViewDidScroll:self.tableView];
    [self.view addSubview:self.suspendView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYLiveDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LYLiveDetailCell.class)];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.preservesSuperviewLayoutMargins = NO;
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 80, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 80, 0, 0)];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    _titleView.y = (contentOffsetY < 0 ? -contentOffsetY : 0) + LYLiveDetailTableY - LYLiveDetailTitleViewHeight;
    _tableBGView.y = CGRectGetMaxY(_titleView.frame);
    _suspendView.hidden = !(contentOffsetY > LYLiveDetailHeaderViewHeight - 40);
}


#pragma mark - Response Events
- (void)chatShowBtnDidClicked:(UIButton *)btn {
    [_liveVC showChat];
}

#pragma mark - Getter/Setter
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat tableViewHeight = kScreenHeight - LYLiveDetailTableY;
        CGFloat tableViewMargin = 10;
        _tableView = [[LYLiveDetailTableView alloc] initWithFrame:CGRectMake(tableViewMargin, LYLiveDetailTableY, kScreenWidth - tableViewMargin * 2, tableViewHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.layer.cornerRadius = 5;
        _tableView.layer.masksToBounds = YES;
        _tableView.rowHeight = 60;
        _tableView.contentInset = UIEdgeInsetsMake(tableViewHeight - 180, 0, 0, 0);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.tableHeaderView;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(LYLiveDetailCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(LYLiveDetailCell.class)];
        
        _tableBGView = [[UIView alloc] initWithFrame:_tableView.frame];
        _tableBGView.backgroundColor = [UIColor whiteColor];
        _tableBGView.layer.masksToBounds = YES;
        _tableBGView.layer.cornerRadius = 5;
    }
    return _tableView;
}

- (UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(LYLiveDetailHeaderView.class) owner:self options:nil][0];
        _tableHeaderView.delegate = _liveVC;
    }
    return _tableHeaderView;
}

- (UIView *)suspendView {
    if (!_suspendView) {
        _suspendView = [[UIView alloc] initWithFrame:CGRectMake(10, LYLiveDetailTableY, self.tableView.width, 40)];
        _suspendView.backgroundColor = [UIColor whiteColor];
        _suspendView.layer.cornerRadius = 5;
        _suspendView.layer.masksToBounds = YES;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 40)];
        label.text = @"直播观众";
        label.textColor = [UIColor colorWithWhite:85/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:15];
        [_suspendView addSubview:label];
        _suspendView.hidden = YES;
    }
    return _suspendView;
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        
        CGFloat margin = 12;
        CGFloat labelWidth = kScreenWidth - margin * 2;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, labelWidth, 32)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.text = @"我和草原有个约会";
        [_titleView addSubview:_titleLabel];
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(_titleLabel.frame), labelWidth, 15)];
        _descLabel.textColor = [UIColor whiteColor];
        _descLabel.font = [UIFont systemFontOfSize:12];
        _descLabel.text = @"#疯狂旅游#";
        [_titleView addSubview:_descLabel];
        
        _chatShowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _chatShowBtn.frame = CGRectMake(labelWidth - 12, (CGRectGetHeight(_titleView.frame) - 32)/2, 32, 32);
        [_chatShowBtn setImage:[UIImage imageNamed:@"icon_chat"] forState:UIControlStateNormal];
        [_chatShowBtn addTarget:self action:@selector(chatShowBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:_chatShowBtn];
    }
    return _titleView;
}
@end
