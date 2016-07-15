//
//  LYLiveViewController.m
//  LYPeriscope
//
//  Created by Louis on 16/7/13.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "LYLiveViewController.h"
#import "UIView+LYAdd.h"
#import "LYLiveDetailViewController.h"
#import "LYLiveChatViewController.h"

#define LYLiveCloseTipViewHeight 40
#define LYLiveBGColorAplha 0.7

@interface LYLiveViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UIView *looseCloseTipView;
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LYLiveChatViewController *chatVC;
@end

@implementation LYLiveViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    
    [self.view addSubview:self.containView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addLoadingAnimation];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - LYLiveDetailHeaderViewDelegate
- (void)detailHeaderView:(LYLiveDetailHeaderView *)detailHeaderView shareBtnDidClicked:(UIButton *)btn {
    [self.view showAlert:@"应该跳出分享框"];
}

- (void)detailHeaderView:(LYLiveDetailHeaderView *)detailHeaderView hiddenBtnDidClicked:(UIButton *)btn {
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    }];
    [_chatVC hiddenChat];
}
- (void)showChat {
    [self detailHeaderView:nil showBtnDidClicked:nil];
}
- (void)detailHeaderView:(LYLiveDetailHeaderView *)detailHeaderView showBtnDidClicked:(UIButton *)btn {
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    }];
    [_chatVC showChat];
}

#pragma mark - Response Events
- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    CGPoint movePoint = [panGesture translationInView:panGesture.view];
    
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
    
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        
    } else if (panGesture.state == UIGestureRecognizerStateChanged) {
        _containView.y += movePoint.y / 2.5;
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        
        if (_containView.y > 64 && _looseCloseTipView.alpha == 0) {
            [UIView animateWithDuration:0.3 animations:^{
                _looseCloseTipView.alpha = 1;
            }];
        } else if (_containView.y < 64 && _looseCloseTipView.alpha == 1) {
            [UIView animateWithDuration:0.3 animations:^{
                _looseCloseTipView.alpha = 0;
            }];
        } else if (_containView.y < 0) {
            self.view.backgroundColor = [UIColor blackColor];
        }
    } else if (panGesture.state == UIGestureRecognizerStateEnded) {
        if (_containView.y < 0) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _containView.y = 0;
            } completion:^(BOOL finished) {
                
            }];
        } else if (_containView.y > 64) {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _containView.y = _containView.height;
                self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
            } completion:^(BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
            }];
        } else if (_containView.y < 64) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _containView.y = 0;
                self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:LYLiveBGColorAplha];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}


#pragma mark - Private Methods
- (void)addLoadingAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.repeatCount = MAXFLOAT;
    animation.duration = 5;
    animation.delegate = self;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
                         [NSValue valueWithCGPoint:CGPointMake(-[UIScreen mainScreen].bounds.size.width, 0)]];
    [_loadingView.layer addAnimation:animation forKey:@"animation"];
}

- (void)dismissBtnDidClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getter/Setter
- (UIView *)looseCloseTipView {
    if (!_looseCloseTipView) {
        CGFloat screenWidth =[UIScreen mainScreen].bounds.size.width;
        _looseCloseTipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
        _looseCloseTipView.alpha = 0;
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = CGRectMake(0, 0, screenWidth, 40);
        gradient.colors = @[(__bridge id)[UIColor colorWithWhite:0 alpha:0.5].CGColor,
                            (__bridge id)[UIColor colorWithWhite:0 alpha:0.2].CGColor,
                            (__bridge id)[UIColor colorWithWhite:0 alpha:0].CGColor];
        [_looseCloseTipView.layer addSublayer:gradient];
        
        UILabel *label = [[UILabel alloc] initWithFrame:_looseCloseTipView.bounds];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"松开以关闭"];
        [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0, 3)];
        [attrString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(3, 2)];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, attrString.length)];
        label.attributedText = attrString;
        label.textAlignment = 1;
        [_looseCloseTipView addSubview:label];
    }
    return _looseCloseTipView;
}

- (UIView *)containView {
    if (!_containView) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        _containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        _containView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        
        _coverImageView = [[UIImageView alloc] initWithFrame:_containView.bounds];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.image = [UIImage imageNamed:@"girl.jpg"];
        [_containView addSubview:_coverImageView];
        
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        blurView.frame = _coverImageView.bounds;
        [_coverImageView addSubview:blurView];
        
        _loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth * 2, 221)];
        _loadingView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loading_pattern_video"]];
        _loadingView.layer.anchorPoint = CGPointMake(0, 0);
        [_containView addSubview:_loadingView];
        
        [_containView addSubview:self.looseCloseTipView];
        
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        _panGesture.delegate = self;
        [_containView addGestureRecognizer:_panGesture];
        
        [_containView addSubview:self.scrollView];
    }
    return _containView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
        
        LYLiveDetailViewController *detailVC = [LYLiveDetailViewController new];
        detailVC.liveVC = self;
        detailVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self addChildViewController:detailVC];
        [_scrollView addSubview:detailVC.view];
        
        _chatVC = [LYLiveChatViewController new];
        _chatVC.liveType = _liveType;
        _chatVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
        [self addChildViewController:_chatVC];
        [_scrollView addSubview:_chatVC.view];
        __weak typeof(self) weakSelf = self;
        _chatVC.dismissBtnBlock = ^{
            [weakSelf dismissBtnDidClicked];
        };
    }
    return _scrollView;
}
@end
