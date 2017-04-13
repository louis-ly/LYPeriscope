//
//  LYLiveChatViewController.m
//  LYPeriscope
//
//  Created by Louis on 16/7/13.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "LYLiveChatViewController.h"
#import "LYLiveGiftView.h"
#import "LYLiveChatCell.h"
#import "LYLiveGiftBarrage.h"

@interface LYLiveChatViewController () <LYLiveGiftViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *editingView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containViewBottomConstraint;
@property (weak, nonatomic) IBOutlet UIButton *giftBtn;
@property (strong, nonatomic) IBOutlet LYLiveGiftView *giftView;
@property (nonatomic, strong) UIView *dismissGiftView;
@property (weak, nonatomic) IBOutlet UIView *toolBtnsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBtnsViewBottomConstraint;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIView *giftContainView;
@property (nonatomic, strong) LYLiveGiftBarrage *giftService;

@property (weak, nonatomic) IBOutlet UIButton *avatarBtn;
@property (weak, nonatomic) IBOutlet UIImageView *levelImageView;
@property (weak, nonatomic) IBOutlet UILabel *onlineCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *liveTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *newlyMessageBtn;
@property (weak, nonatomic) IBOutlet UILabel *connectChatroomLabel;

@property (nonatomic, assign) BOOL hadSendLike;
@property (nonatomic, assign) NSInteger animateColorCount;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@end

@implementation LYLiveChatViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    _dataArray = [NSMutableArray array];
    [_liveTitleLabel setLabelShadow];
    [_onlineCountLabel setLabelShadow];
    [_coinCountLabel setLabelShadow];
    
    _giftService = [[LYLiveGiftBarrage alloc] initBarrageToView:_giftContainView];

    _giftView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(LYLiveChatCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(LYLiveChatCell.class)];
    
    _animateColorCount = arc4random()%6;
    
    if (_liveType == LYLiveTypeRecord) {
        [_shareBtn setImage:[UIImage imageNamed:@"room_pop_up_beauty"] forState:UIControlStateSelected];
        [_shareBtn setImage:[UIImage imageNamed:@"room_pop_up_beauty_p"] forState:UIControlStateNormal];
        [_giftBtn setImage:[UIImage imageNamed:@"room_pop_up_camera"] forState:UIControlStateSelected];
        [_giftBtn setImage:[UIImage imageNamed:@"room_pop_up_camera_p"] forState:UIControlStateNormal];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_giftService startBarrage];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_giftService stopBarrage];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYLiveChatCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LYLiveChatCell.class)];
    if (indexPath.row < self.dataArray.count) {
        cell.chatModel = self.dataArray[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataArray.count) {
        LYLiveChatModel *chatModel = self.dataArray[indexPath.row];
        return chatModel.cellHeight;
    }
    return 30;
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self sendBtnDidClicked:nil];
    return YES;
}


#pragma mark - LYLiveGiftViewDelegate
- (void)giftView:(LYLiveGiftView *)giftView rechargeBtnDidClicked:(UIButton *)rechargeBtn {
    [self.view showAlert:@"应该调往充值页面"];
}

- (void)giftView:(LYLiveGiftView *)giftView sendBtnDidClickedWithFCount:(NSString *)fCount {
    [self hiddenGiftView];
    NSDictionary *extension = @{LY_avatar : USER_avatar,
                                LY_nickName : USER_nickName,
                                LY_userId : USER_userId,
                                LY_level : USER_level,
                                LY_giftType : @"noDefine",
                                LY_coinCount : fCount,
                                LY_content : @"送了一辆保时捷",
                                LY_dataType : LY_EaseMob_MSG_TYPE_GIFT};
    [self reloadTableViewDataWithDict:extension];
    [self updateCoinCount:fCount];
    [_giftService addBarrageItem:[LYLiveGiftBarrageView barrageWithAvatar:@"zhibo_head_xiao" nickName:@"我最帅" content:@"送一辆保时捷" giftIcon:@"tinyCar"]];
}


#pragma mark - Response Events
- (IBAction)chatBtnDidClicked:(UIButton *)sender {
    [_textField becomeFirstResponder];
}

- (IBAction)closeBtnDidClicked:(UIButton *)sender {
    if (_dismissBtnBlock) _dismissBtnBlock();
}

- (IBAction)messageBtnDidClicked:(UIButton *)sender {
    [self.view showAlert:@"此处应该信息界面, 内容比较多"];
}

- (IBAction)moreCoinDidClicked:(UIButton *)sender {
    [self.view showAlert:@"此处显示映票详情"];
}

- (IBAction)newMessageBtnDidClicked:(UIButton *)sender {
    _newlyMessageBtn.hidden = YES;
    [_tableView setContentOffset:CGPointMake(0, MAX(0, _tableView.contentSize.height - _tableView.height)) animated:YES];
}

- (IBAction)shareBtnDidClicked:(UIButton *)sender {
    [self.view showAlert:@"此处应该弹出分享框"];
}

- (IBAction)giftBtnDidClicked:(UIButton *)sender {
    _giftView.y = kScreenHeight;
    [self.view addSubview:self.dismissGiftView];
    [self.view addSubview:_giftView];
    _toolBtnsViewBottomConstraint.constant = -_toolBtnsView.height;
    [UIView animateWithDuration:0.4 animations:^{
        _tableView.alpha = 0;
        _giftView.y -= _giftView.height;
        [_toolBtnsView layoutIfNeeded];
    }];
}

- (IBAction)sendBtnDidClicked:(UIButton *)sender {
    if (_textField.text.length != 0) {
        ;
        [self reloadTableViewDataWithDict:@{LY_avatar : USER_avatar,
                                            LY_nickName : USER_nickName,
                                            LY_userId : USER_userId,
                                            LY_level : USER_level,
                                            LY_content : _textField.text,
                                            LY_dataType : LY_EaseMob_MSG_TYPE_COMMENT}];
        _textField.text = @"";
    }
}


- (IBAction)avatarBtnDidClicked:(UIButton *)btn {
    [self.view showAlert:@"此处应该弹出个人资料框"];
}



- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    if (!self.textField.isEditing) return;
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    if (endFrame.size.height == 0) return;
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    _containViewBottomConstraint.constant = beginFrame.origin.y < endFrame.origin.y ? 0 : endFrame.size.height;
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        [self.view layoutIfNeeded];
        _editingView.alpha = !(beginFrame.origin.y < endFrame.origin.y);
    } completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.textField.isEditing) [self.textField resignFirstResponder];
    if (!_hadSendLike) {
        _hadSendLike = YES;
        NSDictionary *extension = @{LY_avatar : USER_avatar,
                                    LY_nickName : USER_nickName,
                                    LY_userId : USER_userId,
                                    LY_level : USER_level,
                                    LY_content : @"给主播点了赞",
                                    LY_dataType : LY_EaseMob_MSG_TYPE_C_LIKE};
        [self reloadTableViewDataWithDict:extension];
    }
    [self showMoreLoveAnimateFromView:_giftBtn addToView:self.view fromMe:NO];
    [self hiddenGiftView];
}

#pragma mark - UIGestureRecognizer
- (void)handleDismissGiftTapGesture:(UITapGestureRecognizer *)tapGesture {
    [self hiddenGiftView];
}

- (void)handleDismissGiftPanGesture:(UIPanGestureRecognizer *)panGesture {
    [self hiddenGiftView];
}

#pragma mark - Private Methods
- (void)reloadTableViewDataWithDict:(NSDictionary *)dict {
    LYLiveChatModel *model = [[LYLiveChatModel alloc] initWithDictionary:dict];
    [_dataArray addObject:model];
    [_tableView reloadData];
    if (_tableView.contentSize.height - _tableView.contentOffset.y > 400) {
        _newlyMessageBtn.hidden = NO;
    } else {
        [_tableView setContentOffset:CGPointMake(0, MAX(0, _tableView.contentSize.height - _tableView.height)) animated:YES];
    }
}

- (void)hiddenGiftView {
    if (_giftView.y != kScreenHeight) {
        _toolBtnsViewBottomConstraint.constant = 0;
        [UIView animateWithDuration:0.4 animations:^{
            _giftView.y = kScreenHeight;
            [_toolBtnsView layoutIfNeeded];
            _tableView.alpha = 1;
        } completion:^(BOOL finished) {
            [_giftView removeFromSuperview];
            [_dismissGiftView removeFromSuperview];
        }];
    }
}

- (void)showMoreLoveAnimateFromView:(UIView *)fromView addToView:(UIView *)addToView fromMe:(BOOL)fromMe {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    CGRect loveFrame = [fromView convertRect:fromView.frame toView:addToView];
    CGPoint position = CGPointMake(fromView.layer.position.x, loveFrame.origin.y - 30);
    imageView.layer.position = position;
    NSArray *imgArr = @[@"live_like_s_blue",@"live_like_s_grn",@"live_like_s_orange",@"live_like_s_violet",@"live_like_s_yel",@"live_like_s_red"];
    NSInteger img = fromMe ? _animateColorCount : arc4random()%6;
    imageView.image = [UIImage imageNamed:imgArr[img]];
    [addToView addSubview:imageView];
    
    imageView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        imageView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    CGFloat duration = 3 + arc4random()%5;
    CAKeyframeAnimation *positionAnimate = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimate.repeatCount = 1;
    positionAnimate.duration = duration;
    positionAnimate.fillMode = kCAFillModeForwards;
    positionAnimate.removedOnCompletion = NO;
    
    UIBezierPath *sPath = [UIBezierPath bezierPath];
    [sPath moveToPoint:position];
    CGFloat sign = arc4random()%2 == 1 ? 1 : -1;
    CGFloat controlPointValue = (arc4random()%50 + arc4random()%100) * sign;
    [sPath addCurveToPoint:CGPointMake(position.x, position.y - 300) controlPoint1:CGPointMake(position.x - controlPointValue, position.y - 150) controlPoint2:CGPointMake(position.x + controlPointValue, position.y - 150)];
    positionAnimate.path = sPath.CGPath;
    [imageView.layer addAnimation:positionAnimate forKey:@"heartAnimated"];
    
    
    [UIView animateWithDuration:duration animations:^{
        imageView.layer.opacity = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}



#pragma mark - Publick Methods
- (void)hiddenChat {
    _containView.hidden = YES;
    _toolBtnsView.hidden = YES;
    _giftContainView.hidden = YES;
}

- (void)showChat {
    _containView.hidden = NO;
    _toolBtnsView.hidden = NO;
    _giftContainView.hidden = NO;
}


#pragma mark - Getter/Setter
- (UIView *)dismissGiftView {
    if (!_dismissGiftView) {
        _dismissGiftView = [[UIView alloc] initWithFrame:self.view.bounds];
        
        [_dismissGiftView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDismissGiftTapGesture:)]];
        [_dismissGiftView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDismissGiftPanGesture:)]];
    }
    return _dismissGiftView;
}

- (void)updateCoinCount:(NSString *)coinCount {
    NSInteger currentCount = [_coinCountLabel.text integerValue];
    NSInteger addCount = [coinCount integerValue];
    _coinCountLabel.text = [NSString stringWithFormat:@"%ld", currentCount + addCount];
}
@end
