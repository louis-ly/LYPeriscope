//
//  LYLiveDetailHeaderView.m
//  LYPeriscope
//
//  Created by Louis on 16/7/15.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "LYLiveDetailHeaderView.h"

@interface LYLiveDetailHeaderView ()
@end
@implementation LYLiveDetailHeaderView
- (IBAction)shareBtnDidClicked:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(detailHeaderView:shareBtnDidClicked:)]) {
        [_delegate detailHeaderView:self shareBtnDidClicked:sender];
    }
}

- (IBAction)chatHiddenBtnDidClicked:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"隐藏聊天"]) {
        [sender setTitle:@"显示聊天" forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"icon_showchat"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"icon_showchat_selected"] forState:UIControlStateSelected];
        if ([_delegate respondsToSelector:@selector(detailHeaderView:hiddenBtnDidClicked:)]) {
            [_delegate detailHeaderView:self hiddenBtnDidClicked:sender];
        }
    } else {
        [sender setTitle:@"隐藏聊天" forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"icon_hidechat"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"icon_hidechat_selected"] forState:UIControlStateSelected];
        if ([_delegate respondsToSelector:@selector(detailHeaderView:showBtnDidClicked:)]) {
            [_delegate detailHeaderView:self showBtnDidClicked:sender];
        }
    }
}
@end
