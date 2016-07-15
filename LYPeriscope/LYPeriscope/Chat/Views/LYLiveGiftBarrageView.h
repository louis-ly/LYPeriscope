//
//  LYLiveGiftBarrageView.h
//  GlobalLive
//
//  Created by Louis on 16/7/9.
//  Copyright © 2016年 GuanCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYLiveGiftBarrageView : UIView
+ (instancetype)barrageWithAvatar:(NSString *)avatar nickName:(NSString *)nickName content:(NSString *)content giftIcon:(NSString *)giftIcon;
- (void)startAnimatingCompleted:(void(^)())completed;
@end
