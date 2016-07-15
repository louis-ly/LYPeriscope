//
//  LYLiveChatViewController.h
//  LYPeriscope
//
//  Created by Louis on 16/7/13.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYLiveViewController.h"

@interface LYLiveChatViewController : UIViewController
@property (nonatomic, copy) void(^dismissBtnBlock)();
@property (nonatomic, assign) LYLiveType liveType;
- (void)hiddenChat;
- (void)showChat;
@end
