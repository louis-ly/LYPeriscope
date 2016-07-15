//
//  LYLiveGiftBarrageView.m
//  GlobalLive
//
//  Created by Louis on 16/7/9.
//  Copyright © 2016年 GuanCloud. All rights reserved.
//

#import "LYLiveGiftBarrageView.h"


@interface LYLiveGiftBarrageView ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;
@end
@implementation LYLiveGiftBarrageView

+ (instancetype)barrageWithAvatar:(NSString *)avatar nickName:(NSString *)nickName content:(NSString *)content giftIcon:(NSString *)giftIcon {
    LYLiveGiftBarrageView *barrageView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(LYLiveGiftBarrageView.class) owner:self options:nil][0];
    barrageView.avatarImageView.image = [UIImage imageNamed:avatar];
    barrageView.avatarImageView.layer.cornerRadius = barrageView.avatarImageView.width / 2;
    barrageView.avatarImageView.layer.borderWidth = 1;
    barrageView.avatarImageView.layer.borderColor = [UIColor colorWithRed:75/255.0 green:211/255.0 blue:179/255.0 alpha:1].CGColor;
    barrageView.nickNameLabel.text = nickName;
    barrageView.contentLabel.text = content;
    barrageView.giftImageView.image = [UIImage imageNamed:giftIcon];
    return barrageView;
}

- (void)startAnimatingCompleted:(void(^)())completed {
    self.x = -self.width;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.x = 0;
        self.alpha = 1;
    } completion:^(BOOL finished) {
        CGFloat giftImageX = _giftImageView.x;
        _giftImageView.x = -_giftImageView.width;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _giftImageView.x = giftImageX;
            _giftImageView.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 delay:4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.y = -64;
                self.alpha = 0;
            } completion:^(BOOL finished) {
                if (completed) {
                    completed();
                }
            }];
        }];
    }];
}
@end
