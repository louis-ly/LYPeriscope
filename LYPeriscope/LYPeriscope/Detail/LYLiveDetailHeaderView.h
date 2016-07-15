//
//  LYLiveDetailHeaderView.h
//  LYPeriscope
//
//  Created by Louis on 16/7/15.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LYLiveDetailHeaderViewHeight 353

@class LYLiveDetailHeaderView;
@protocol LYLiveDetailHeaderViewDelegate <NSObject>
@optional;
- (void)detailHeaderView:(LYLiveDetailHeaderView *)detailHeaderView shareBtnDidClicked:(UIButton *)btn;
- (void)detailHeaderView:(LYLiveDetailHeaderView *)detailHeaderView hiddenBtnDidClicked:(UIButton *)btn;
- (void)detailHeaderView:(LYLiveDetailHeaderView *)detailHeaderView showBtnDidClicked:(UIButton *)btn;
@end

@interface LYLiveDetailHeaderView : UIView
@property (nonatomic, weak) id<LYLiveDetailHeaderViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *suspendView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *suspendViewTopConstraint;
@end
